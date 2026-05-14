import 'moon_phase.dart';

extension MoonPhaseLabel on MoonPhase {
  String get label => switch (this) {
        MoonPhase.newMoon => 'New Moon',
        MoonPhase.waxingCrescent => 'Waxing Crescent',
        MoonPhase.firstQuarter => 'First Quarter',
        MoonPhase.waxingGibbous => 'Waxing Gibbous',
        MoonPhase.fullMoon => 'Full Moon',
        MoonPhase.waningGibbous => 'Waning Gibbous',
        MoonPhase.lastQuarter => 'Last Quarter',
        MoonPhase.waningCrescent => 'Waning Crescent',
      };
}
