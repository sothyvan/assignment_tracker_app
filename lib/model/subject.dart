import 'assignment.dart';

class Subject {
  final int id;
  String name;
  final List<Assignment> assignments;

  Subject({
    required this.id,
    required this.name,
    List<Assignment>? assignments,
  }) : assignments = assignments ?? [];

  void addAssignment(Assignment assignment) {
    assignments.add(assignment);
  }

  void removeAssignment(Assignment assignment) {
    assignments.remove(assignment);
  }
}