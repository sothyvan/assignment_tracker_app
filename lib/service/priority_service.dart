import '../model/assignment.dart';
import '../model/assignment_status.dart';
import '../model/assignment_priority.dart';

class PriorityService {
  AssignmentPriority? calculatePriority(
    Assignment assignment, {
    DateTime? now,
  }) {
    final currentTime = now ?? DateTime.now();

    if(assignment.status == AssignmentStatus.completed) {
      return null;
    }

    if(!assignment.deadline.isAfter(currentTime)) {
      return AssignmentPriority.high;
    }

    final estimatedEffort = assignment.estimatedEffort;

    if(estimatedEffort == null) {
      return AssignmentPriority.notSet;
    }

    final timeUntilDeadline = assignment.deadline.difference(currentTime).inSeconds / 3600;

    final slack = timeUntilDeadline - estimatedEffort;

    if(slack <= 24) {
      return AssignmentPriority.high;
    } else if(slack <= 72) {
      return AssignmentPriority.medium;
    } else {
      return AssignmentPriority.low;
    }
  }

  bool isOverdue(
    Assignment assignment, {
    DateTime? now,
  }) {
    final currentTime = now ?? DateTime.now();
    
    return assignment.status == AssignmentStatus.pending && !assignment.deadline.isAfter(currentTime);
  }
}