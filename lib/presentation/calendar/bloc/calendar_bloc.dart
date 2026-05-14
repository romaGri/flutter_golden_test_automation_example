import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/get_month_calendar.dart';
import 'calendar_event.dart';
import 'calendar_state.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  final GetMonthCalendar _getMonthCalendar;

  int _year = DateTime.now().year;
  int _month = DateTime.now().month;

  CalendarBloc(this._getMonthCalendar) : super(const CalendarInitial()) {
    on<CalendarMonthLoadRequested>(_onMonthLoadRequested);
    on<CalendarPreviousMonthRequested>(_onPreviousMonth);
    on<CalendarNextMonthRequested>(_onNextMonth);
  }

  void _onMonthLoadRequested(
    CalendarMonthLoadRequested event,
    Emitter<CalendarState> emit,
  ) {
    _year = event.year;
    _month = event.month;
    _loadCurrent(emit);
  }

  void _onPreviousMonth(
    CalendarPreviousMonthRequested event,
    Emitter<CalendarState> emit,
  ) {
    if (_month == 1) {
      _month = 12;
      _year--;
    } else {
      _month--;
    }
    _loadCurrent(emit);
  }

  void _onNextMonth(
    CalendarNextMonthRequested event,
    Emitter<CalendarState> emit,
  ) {
    if (_month == 12) {
      _month = 1;
      _year++;
    } else {
      _month++;
    }
    _loadCurrent(emit);
  }

  void _loadCurrent(Emitter<CalendarState> emit) {
    emit(const CalendarLoading());
    try {
      emit(CalendarLoaded(_getMonthCalendar(_year, _month)));
    } catch (e) {
      emit(CalendarError(e.toString()));
    }
  }
}
