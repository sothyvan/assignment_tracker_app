import 'assignment.dart';

class StudySession {
  final int id;
  final Assignment assignment;
  DateTime startDateTime;
  DateTime endDateTime;

  StudySession({
    required this.id,
    required this.assignment,
    required this.startDateTime,
    required this.endDateTime,
  });
}