enum Weekday {
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
  sunday,
}

class AvailabilityBlock {
  final int id;
  Weekday dayOfWeek;
  DateTime startTime;
  DateTime endTime;

  AvailabilityBlock({
    required this.id,
    required this.dayOfWeek,
    required this.startTime,
    required this.endTime,
  });
}