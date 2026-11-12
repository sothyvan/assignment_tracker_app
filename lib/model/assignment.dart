import 'subject.dart';
import 'assignment_status.dart';

class Assignment {
  final int id;
  String title;
  final Subject subject;
  String? description;
  DateTime deadline;
  double? estimatedEffort;
  AssignmentStatus status;

  Assignment({
    required this.id,
    required this.title,
    required this.subject,
    this.description,
    required this.deadline,
    this.estimatedEffort,
    this.status = AssignmentStatus.pending,
  });
}