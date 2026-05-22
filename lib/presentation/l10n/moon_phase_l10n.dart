import 'package:flutter/widgets.dart';

import '../../core/l10n/app_localizations_extension.dart';
import '../../domain/entities/moon_phase.dart';

extension MoonPhaseLabelL10n on MoonPhase {
  String localizedLabel(BuildContext context) => switch (this) {
    MoonPhase.newMoon => context.S.moonPhaseNewMoon,
    MoonPhase.waxingCrescent => context.S.moonPhaseWaxingCrescent,
    MoonPhase.firstQuarter => context.S.moonPhaseFirstQuarter,
    MoonPhase.waxingGibbous => context.S.moonPhaseWaxingGibbous,
    MoonPhase.fullMoon => context.S.moonPhaseFullMoon,
    MoonPhase.waningGibbous => context.S.moonPhaseWaningGibbous,
    MoonPhase.lastQuarter => context.S.moonPhaseLastQuarter,
    MoonPhase.waningCrescent => context.S.moonPhaseWaningCrescent,
  };
}
