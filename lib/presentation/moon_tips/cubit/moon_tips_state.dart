import 'package:equatable/equatable.dart';

sealed class MoonTipsState extends Equatable {
  const MoonTipsState();

  @override
  List<Object?> get props => [];
}

final class MoonTipsInitial extends MoonTipsState {
  const MoonTipsInitial();
}

final class MoonTipsLoading extends MoonTipsState {
  const MoonTipsLoading();
}

final class MoonTipsLoaded extends MoonTipsState {
  final List<String> tips;

  const MoonTipsLoaded(this.tips);

  @override
  List<Object?> get props => [tips];
}

final class MoonTipsError extends MoonTipsState {
  final String message;

  const MoonTipsError(this.message);

  @override
  List<Object?> get props => [message];
}
