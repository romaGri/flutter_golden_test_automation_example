sealed class CalendarEvent {
  const CalendarEvent();
}

final class CalendarMonthLoadRequested extends CalendarEvent {
  final int year;
  final int month;

  const CalendarMonthLoadRequested({required this.year, required this.month});
}

final class CalendarPreviousMonthRequested extends CalendarEvent {
  const CalendarPreviousMonthRequested();
}

final class CalendarNextMonthRequested extends CalendarEvent {
  const CalendarNextMonthRequested();
}
