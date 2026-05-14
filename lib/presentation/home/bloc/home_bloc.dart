import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/get_today_moon.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetTodayMoon _getTodayMoon;

  HomeBloc(this._getTodayMoon) : super(const HomeInitial()) {
    on<HomeMoonLoadRequested>(_onLoadRequested);
  }

  void _onLoadRequested(
    HomeMoonLoadRequested event,
    Emitter<HomeState> emit,
  ) {
    emit(const HomeLoading());
    try {
      emit(HomeLoaded(_getTodayMoon()));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}
