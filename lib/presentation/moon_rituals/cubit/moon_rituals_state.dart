import 'package:equatable/equatable.dart';

import '../../../domain/entities/moon_phase.dart';

class MoonRitual extends Equatable {
  final MoonPhase phase;
  final double illumination;
  final String title;
  final List<String> doList;
  final List<String> avoidList;

  const MoonRitual({
    required this.phase,
    required this.illumination,
    required this.title,
    required this.doList,
    required this.avoidList,
  });

  @override
  List<Object?> get props => [phase, illumination, title, doList, avoidList];
}

sealed class MoonRitualsState extends Equatable {
  const MoonRitualsState();

  @override
  List<Object?> get props => [];
}

final class MoonRitualsInitial extends MoonRitualsState {
  const MoonRitualsInitial();
}

final class MoonRitualsLoading extends MoonRitualsState {
  const MoonRitualsLoading();
}

final class MoonRitualsLoaded extends MoonRitualsState {
  final List<MoonRitual> rituals;

  const MoonRitualsLoaded(this.rituals);

  @override
  List<Object?> get props => [rituals];
}

final class MoonRitualsError extends MoonRitualsState {
  final String message;

  const MoonRitualsError(this.message);

  @override
  List<Object?> get props => [message];
}
