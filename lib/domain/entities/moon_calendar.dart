import 'moon_day.dart';

class MoonCalendar {
  final int year;
  final int month;
  final List<MoonDay> days;

  const MoonCalendar({
    required this.year,
    required this.month,
    required this.days,
  });
}
