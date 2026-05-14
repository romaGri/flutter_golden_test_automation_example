import 'moon_phase.dart';

class MoonDay {
  final DateTime date;
  final MoonPhase phase;
  final double illumination; // 0.0 to 1.0
  final double ageInDays; // days since new moon, 0..29.53

  const MoonDay({
    required this.date,
    required this.phase,
    required this.illumination,
    required this.ageInDays,
  });

  @override
  bool operator ==(Object other) =>
      other is MoonDay &&
      date == other.date &&
      phase == other.phase &&
      illumination == other.illumination &&
      ageInDays == other.ageInDays;

  @override
  int get hashCode => Object.hash(date, phase, illumination, ageInDays);
}
