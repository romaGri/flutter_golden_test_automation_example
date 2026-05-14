import '../entities/moon_day.dart';
import '../repositories/moon_repository.dart';

class GetDayMoon {
  final MoonRepository _repository;

  const GetDayMoon(this._repository);

  MoonDay call(DateTime date) => _repository.getDay(date);
}
