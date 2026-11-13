import '../model/assignment_status.dart';
import '../model/availability_block.dart';
import '../model/study_session.dart';

class StudyplanningService {
  String? validateBooking({
    required StudySession newSession,
    required List<AvailabilityBlock> availabilityBlocks,
    required List<StudySession> existingSessions,
  }) {
    final assignment = newSession.assignment;

    if (assignment.status == AssignmentStatus.completed) {
      return 'Cannot book a study session for a completed assignment.';
    }

    if (newSession.startDateTime.isAfter(newSession.endDateTime)) {
      return 'Start time must be before end time.';
    }

    if (newSession.startDateTime.isBefore(DateTime.now())) {
      return 'Cannot book a study session in the past.';
    }

    final start = newSession.startDateTime;
    final end = newSession.endDateTime;

    final sameDay = start.year == end.year && start.month == end.month && start.day == end.day;

    if (!sameDay) {
      return 'Study sessions must start and end on the same day.';
    }

    final sessionStart = Duration(
      hours: start.hour,
      minutes: start.minute,
    );

    final sessionEnd = Duration(
      hours: end.hour,
      minutes: end.minute,
    );

    final sessionWeekday = Weekday.values[start.weekday - 1];

    final fitsAvailability = availabilityBlocks.any((block) {
      return block.dayOfWeek == sessionWeekday && sessionStart >= block.startTime && sessionEnd <= block.endTime;
    });

    if (!fitsAvailability) {
      return 'Study session does not fit within your availability.';
    }

    for (final existingSession in existingSessions) {
      final overlaps = newSession.startDateTime.isBefore(
        existingSession.endDateTime,
      ) && existingSession.startDateTime.isBefore(
        newSession.endDateTime,
      );

      if (overlaps) {
        return 'Session overlaps with another booked session.';
      }
    }

    final estimatedEffort = assignment.estimatedEffort;

    if (estimatedEffort == null) {
      return 'Please enter the estimated effort before booking.';
    }

    double bookedHours = 0;

    for (final session in existingSessions) {
      if (session.assignment.id == assignment.id) {
        bookedHours += session.endDateTime.difference(session.startDateTime).inMinutes / 60;
      }
    }

    final newSessionHours = newSession.endDateTime.difference(newSession.startDateTime).inMinutes / 60;

    bookedHours += newSessionHours;

    if (bookedHours > estimatedEffort) {
      return 'This session would exceed the assignment estimated effort.';
    }

    return null;
  }
}
    