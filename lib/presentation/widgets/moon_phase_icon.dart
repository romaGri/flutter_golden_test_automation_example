import 'dart:math';

import 'package:flutter/material.dart';

import '../../domain/entities/moon_phase.dart';

/// Renders the lit/dark portions of the moon for a given [phase] and
/// [illumination]. Pure [CustomPainter] — no external state, deterministic
/// output — which makes it ideal for golden tests.
class MoonPhaseIcon extends StatelessWidget {
  final MoonPhase phase;
  final double illumination;
  final double size;

  const MoonPhaseIcon({
    super.key,
    required this.phase,
    required this.illumination,
    this.size = 64,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return SizedBox.square(
      dimension: size,
      child: CustomPaint(
        painter: _MoonPhasePainter(
          phase: phase,
          illumination: illumination,
          moonColor: isDark ? const Color(0xFFF5E6C8) : const Color(0xFFFFD966),
          shadowColor:
              isDark ? const Color(0xFF0D0D1A) : const Color(0xFF1A1A2E),
        ),
      ),
    );
  }
}

class _MoonPhasePainter extends CustomPainter {
  final MoonPhase phase;
  final double illumination;
  final Color moonColor;
  final Color shadowColor;

  const _MoonPhasePainter({
    required this.phase,
    required this.illumination,
    required this.moonColor,
    required this.shadowColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final r = size.shortestSide / 2;
    final center = Offset(size.width / 2, size.height / 2);
    final moonPaint = Paint()..color = moonColor;
    final shadowPaint = Paint()..color = shadowColor;

    // Clip everything to the moon circle.
    canvas.clipPath(
      Path()..addOval(Rect.fromCircle(center: center, radius: r)),
    );

    if (phase == MoonPhase.newMoon) {
      canvas.drawCircle(center, r, shadowPaint);
      return;
    }
    if (phase == MoonPhase.fullMoon) {
      canvas.drawCircle(center, r, moonPaint);
      return;
    }

    canvas.drawCircle(center, r, moonPaint);

    // Waxing phases (index 1–3): shadow on the left.
    // Waning phases (index 5–7): shadow on the right.
    final isWaxing = phase.index >= 1 && phase.index <= 3;
    canvas.drawPath(_shadowPath(r, center, isWaxing), shadowPaint);
  }

  /// Builds the shadow region using two shapes:
  /// - A semicircle on the dark side.
  /// - A terminator ellipse that either expands (crescent) or trims
  ///   (gibbous) that semicircle via [Path.combine].
  Path _shadowPath(double r, Offset center, bool isWaxing) {
    final moonRect = Rect.fromCircle(center: center, radius: r);
    final terminatorRadius = (r * (1 - 2 * illumination)).abs();
    final terminatorRect = Rect.fromCenter(
      center: center,
      width: terminatorRadius * 2,
      height: r * 2,
    );

    final semi = Path()
      ..moveTo(center.dx, center.dy - r)
      ..arcTo(moonRect, -pi / 2, isWaxing ? pi : -pi, false)
      ..close();

    final ellipse = Path()..addOval(terminatorRect);

    // Crescent: shadow is larger than the semicircle → union.
    // Gibbous:  shadow is smaller than the semicircle → difference.
    return illumination < 0.5
        ? Path.combine(PathOperation.union, semi, ellipse)
        : Path.combine(PathOperation.difference, semi, ellipse);
  }

  @override
  bool shouldRepaint(_MoonPhasePainter old) =>
      phase != old.phase ||
      illumination != old.illumination ||
      moonColor != old.moonColor ||
      shadowColor != old.shadowColor;
}
