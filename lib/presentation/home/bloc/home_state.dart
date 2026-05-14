import 'package:equatable/equatable.dart';

import '../../../domain/entities/moon_day.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

final class HomeInitial extends HomeState {
  const HomeInitial();
}

final class HomeLoading extends HomeState {
  const HomeLoading();
}

final class HomeLoaded extends HomeState {
  final MoonDay moonDay;

  const HomeLoaded(this.moonDay);

  @override
  List<Object?> get props => [moonDay];
}

final class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);

  @override
  List<Object?> get props => [message];
}
