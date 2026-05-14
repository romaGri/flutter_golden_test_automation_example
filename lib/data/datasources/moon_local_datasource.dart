import '../../core/utils/moon_calculator.dart';
import '../../domain/entities/moon_calendar.dart';
import '../../domain/entities/moon_day.dart';

class MoonLocalDatasource {
  const MoonLocalDatasource();

  MoonDay getDay(DateTime date) => MoonCalculator.calculateDay(date);

  MoonCalendar getMonth(int year, int month) {
    final daysInMonth = DateTime(year, month + 1, 0).day;
    final days = List.generate(
      daysInMonth,
      (i) => MoonCalculator.calculateDay(DateTime(year, month, i + 1)),
    );
    return MoonCalendar(year: year, month: month, days: days);
  }
}
