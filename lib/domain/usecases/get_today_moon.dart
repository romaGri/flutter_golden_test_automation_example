import '../entities/moon_day.dart';
import '../repositories/moon_repository.dart';

class GetTodayMoon {
  final MoonRepository _repository;

  const GetTodayMoon(this._repository);

  MoonDay call() => _repository.getDay(DateTime.now());
}
