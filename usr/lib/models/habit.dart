class Habit {
  final String id;
  final String name;
  final String description;
  final List<DateTime> completedDates;

  Habit({
    required this.id,
    required this.name,
    this.description = '',
    List<DateTime>? completedDates,
  }) : completedDates = completedDates ?? [];

  // Check if the habit was completed today
  bool isCompletedToday() {
    final today = DateTime.now();
    return completedDates.any((date) =>
        date.year == today.year &&
        date.month == today.month &&
        date.day == today.day);
  }

  // Toggle the completion status for today
  void toggleCompletion() {
    if (isCompletedToday()) {
      final today = DateTime.now();
      completedDates.removeWhere((date) =>
          date.year == today.year &&
          date.month == today.month &&
          date.day == today.day);
    } else {
      completedDates.add(DateTime.now());
    }
  }
}
