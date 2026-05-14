import 'package:equatable/equatable.dart';

import '../../../domain/entities/moon_calendar.dart';

sealed class CalendarState extends Equatable {
  const CalendarState();

  @override
  List<Object?> get props => [];
}

final class CalendarInitial extends CalendarState {
  const CalendarInitial();
}

final class CalendarLoading extends CalendarState {
  const CalendarLoading();
}

final class CalendarLoaded extends CalendarState {
  final MoonCalendar calendar;

  const CalendarLoaded(this.calendar);

  @override
  List<Object?> get props => [calendar];
}

final class CalendarError extends CalendarState {
  final String message;

  const CalendarError(this.message);

  @override
  List<Object?> get props => [message];
}
