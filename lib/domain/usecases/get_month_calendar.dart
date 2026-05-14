import '../entities/moon_calendar.dart';
import '../repositories/moon_repository.dart';

class GetMonthCalendar {
  final MoonRepository _repository;

  const GetMonthCalendar(this._repository);

  MoonCalendar call(int year, int month) => _repository.getMonth(year, month);
}
