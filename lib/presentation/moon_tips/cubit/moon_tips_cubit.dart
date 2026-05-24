import 'package:flutter_bloc/flutter_bloc.dart';

import 'moon_tips_state.dart';

class MoonTipsCubit extends Cubit<MoonTipsState> {
  MoonTipsCubit() : super(const MoonTipsInitial());

  static const _tips = [
    'New Moon: best time for new beginnings and setting intentions.',
    'Waxing Crescent: take the first steps toward your goals.',
    'First Quarter: push through obstacles and make decisions.',
    'Waxing Gibbous: refine and adjust your plans.',
    'Full Moon: peak energy — celebrate progress and release what no longer serves you.',
    'Waning Gibbous: share your knowledge and express gratitude.',
    'Last Quarter: forgive, let go, and clear out the old.',
    'Waning Crescent: rest, reflect, and prepare for the next cycle.',
  ];

  void loadTips() {
    emit(const MoonTipsLoading());
    emit(const MoonTipsLoaded(_tips));
  }
}
