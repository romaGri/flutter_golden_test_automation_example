import '../entities/moon_calendar.dart';
import '../entities/moon_day.dart';

abstract class MoonRepository {
  MoonDay getDay(DateTime date);
  MoonCalendar getMonth(int year, int month);
}
