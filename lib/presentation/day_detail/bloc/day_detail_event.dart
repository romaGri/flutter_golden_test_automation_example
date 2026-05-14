sealed class DayDetailEvent {
  const DayDetailEvent();
}

final class DayDetailLoadRequested extends DayDetailEvent {
  final DateTime date;

  const DayDetailLoadRequested(this.date);
}
