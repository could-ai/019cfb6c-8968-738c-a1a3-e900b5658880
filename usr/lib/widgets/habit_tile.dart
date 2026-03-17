import 'package:flutter/material.dart';
import '../models/habit.dart';

class HabitTile extends StatelessWidget {
  final Habit habit;
  final VoidCallback onToggle;

  const HabitTile({
    super.key,
    required this.habit,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final isCompleted = habit.isCompletedToday();

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onToggle,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              // Custom Checkbox
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: isCompleted 
                      ? Theme.of(context).colorScheme.primary 
                      : Colors.transparent,
                  border: Border.all(
                    color: isCompleted 
                        ? Theme.of(context).colorScheme.primary 
                        : Theme.of(context).colorScheme.outline,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: isCompleted
                    ? const Icon(Icons.check, color: Colors.white, size: 20)
                    : null,
              ),
              const SizedBox(width: 16),
              
              // Habit Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      habit.name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: isCompleted ? Colors.grey : null,
                        decoration: isCompleted ? TextDecoration.lineThrough : null,
                      ),
                    ),
                    if (habit.description.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        habit.description,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                          decoration: isCompleted ? TextDecoration.lineThrough : null,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
