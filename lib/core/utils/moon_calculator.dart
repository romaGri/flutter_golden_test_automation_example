import 'dart:math';

import '../../domain/entities/moon_day.dart';
import '../../domain/entities/moon_phase.dart';

/// Pure functions for lunar calculations. No external dependencies — all
/// results are deterministic for a given [DateTime], which makes them
/// straightforward to unit-test and to use in golden tests.
class MoonCalculator {
  MoonCalculator._();

  /// Synodic month length in days.
  static const double synodicMonth = 29.53058867;

  /// Julian date of a known new moon: 2000-01-06 18:14 UTC.
  static const double _knownNewMoonJD = 2451550.1;

  // ---------------------------------------------------------------------------
  // Public API
  // ---------------------------------------------------------------------------

  /// Returns a fully populated [MoonDay] for the given [date].
  static MoonDay calculateDay(DateTime date) {
    final normalised = DateTime(date.year, date.month, date.day);
    final age = getMoonAge(normalised);
    return MoonDay(
      date: normalised,
      phase: _phaseFromAge(age),
      illumination: _illuminationFromAge(age),
      ageInDays: age,
    );
  }

  /// Days elapsed since the last new moon (0.0 ≤ result < [synodicMonth]).
  static double getMoonAge(DateTime date) {
    final jd = _julianDate(date);
    final age = (jd - _knownNewMoonJD) % synodicMonth;
    return age < 0 ? age + synodicMonth : age;
  }

  /// Fraction of the moon's disc that is illuminated (0.0 – 1.0).
  static double getIllumination(DateTime date) =>
      _illuminationFromAge(getMoonAge(date));

  /// The [MoonPhase] for the given [date].
  static MoonPhase getPhase(DateTime date) =>
      _phaseFromAge(getMoonAge(date));

  // ---------------------------------------------------------------------------
  // Private helpers
  // ---------------------------------------------------------------------------

  /// Converts a [DateTime] to a Julian Day Number (noon UT).
  static double _julianDate(DateTime date) {
    final y = date.year;
    final m = date.month;
    final d = date.day;

    final a = (14 - m) ~/ 12;
    final yy = y + 4800 - a;
    final mm = m + 12 * a - 3;

    return d +
        (153 * mm + 2) ~/ 5 +
        365 * yy +
        yy ~/ 4 -
        yy ~/ 100 +
        yy ~/ 400 -
        32045;
  }

  static double _illuminationFromAge(double age) =>
      (1 - cos(2 * pi * age / synodicMonth)) / 2;

  /// Maps [age] (days since new moon) to one of 8 equally-sized phase buckets.
  static MoonPhase _phaseFromAge(double age) {
    final fraction = age / synodicMonth;

    if (fraction < 0.0625 || fraction >= 0.9375) return MoonPhase.newMoon;
    if (fraction < 0.1875) return MoonPhase.waxingCrescent;
    if (fraction < 0.3125) return MoonPhase.firstQuarter;
    if (fraction < 0.4375) return MoonPhase.waxingGibbous;
    if (fraction < 0.5625) return MoonPhase.fullMoon;
    if (fraction < 0.6875) return MoonPhase.waningGibbous;
    if (fraction < 0.8125) return MoonPhase.lastQuarter;
    return MoonPhase.waningCrescent;
  }
}
