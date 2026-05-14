import 'package:equatable/equatable.dart';

import '../../../domain/entities/moon_day.dart';

sealed class DayDetailState extends Equatable {
  const DayDetailState();

  @override
  List<Object?> get props => [];
}

final class DayDetailInitial extends DayDetailState {
  const DayDetailInitial();
}

final class DayDetailLoading extends DayDetailState {
  const DayDetailLoading();
}

final class DayDetailLoaded extends DayDetailState {
  final MoonDay moonDay;

  const DayDetailLoaded(this.moonDay);

  @override
  List<Object?> get props => [moonDay];
}

final class DayDetailError extends DayDetailState {
  final String message;

  const DayDetailError(this.message);

  @override
  List<Object?> get props => [message];
}
