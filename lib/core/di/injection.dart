import 'package:get_it/get_it.dart';

import '../../data/datasources/moon_local_datasource.dart';
import '../../data/repositories/moon_repository_impl.dart';
import '../../domain/repositories/moon_repository.dart';
import '../../domain/usecases/get_day_moon.dart';
import '../../domain/usecases/get_month_calendar.dart';
import '../../domain/usecases/get_today_moon.dart';
import '../../presentation/calendar/bloc/calendar_bloc.dart';
import '../../presentation/day_detail/bloc/day_detail_bloc.dart';
import '../../presentation/home/bloc/home_bloc.dart';
import '../../presentation/moon_rituals/cubit/moon_rituals_cubit.dart';
import '../../presentation/moon_tips/cubit/moon_tips_cubit.dart';
import '../../presentation/settings/cubit/settings_cubit.dart';

final GetIt sl = GetIt.instance;

void configureDependencies() {
  // Datasources
  sl.registerLazySingleton<MoonLocalDatasource>(
    () => const MoonLocalDatasource(),
  );

  // Repositories
  sl.registerLazySingleton<MoonRepository>(
    () => MoonRepositoryImpl(sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => GetTodayMoon(sl()));
  sl.registerLazySingleton(() => GetDayMoon(sl()));
  sl.registerLazySingleton(() => GetMonthCalendar(sl()));

  // BLoCs / Cubits — factory so each page gets a fresh instance
  sl.registerFactory(() => HomeBloc(sl()));
  sl.registerFactory(() => MoonRitualsCubit());
  sl.registerFactory(() => MoonTipsCubit());
  sl.registerFactory(() => CalendarBloc(sl()));
  sl.registerFactory(() => DayDetailBloc(sl()));

  // Cubit — singleton: lives above MaterialApp to control theme globally
  sl.registerLazySingleton(() => SettingsCubit());
}
