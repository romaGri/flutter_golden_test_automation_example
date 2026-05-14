import '../../domain/entities/moon_calendar.dart';
import '../../domain/entities/moon_day.dart';
import '../../domain/repositories/moon_repository.dart';
import '../datasources/moon_local_datasource.dart';

class MoonRepositoryImpl implements MoonRepository {
  final MoonLocalDatasource _datasource;

  const MoonRepositoryImpl(this._datasource);

  @override
  MoonDay getDay(DateTime date) => _datasource.getDay(date);

  @override
  MoonCalendar getMonth(int year, int month) =>
      _datasource.getMonth(year, month);
}
