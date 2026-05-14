import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/get_day_moon.dart';
import 'day_detail_event.dart';
import 'day_detail_state.dart';

class DayDetailBloc extends Bloc<DayDetailEvent, DayDetailState> {
  final GetDayMoon _getDayMoon;

  DayDetailBloc(this._getDayMoon) : super(const DayDetailInitial()) {
    on<DayDetailLoadRequested>(_onLoadRequested);
  }

  void _onLoadRequested(
    DayDetailLoadRequested event,
    Emitter<DayDetailState> emit,
  ) {
    emit(const DayDetailLoading());
    try {
      emit(DayDetailLoaded(_getDayMoon(event.date)));
    } catch (e) {
      emit(DayDetailError(e.toString()));
    }
  }
}
