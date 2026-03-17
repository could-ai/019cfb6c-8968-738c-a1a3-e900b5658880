import 'package:flutter/material.dart';
import '../models/habit.dart';
import '../widgets/habit_tile.dart';
import 'add_habit_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Mock data for initial state
  final List<Habit> _habits = [
    Habit(id: '1', name: 'Drink Water', description: '8 glasses a day'),
    Habit(id: '2', name: 'Read', description: '10 pages of a book'),
    Habit(id: '3', name: 'Exercise', description: '30 minutes workout'),
  ];

  void _toggleHabit(Habit habit) {
    setState(() {
      habit.toggleCompletion();
    });
  }

  void _addHabit(Habit newHabit) {
    setState(() {
      _habits.add(newHabit);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Calculate progress
    final completedToday = _habits.where((h) => h.isCompletedToday()).length;
    final progress = _habits.isEmpty ? 0.0 : completedToday / _habits.length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Habits', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Column(
        children: [
          // Progress Header
          Container(
            padding: const EdgeInsets.all(24.0),
            margin: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Daily Progress',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onPrimaryContainer,
                          ),
                    ),
                    Text(
                      '$completedToday / ${_habits.length}',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onPrimaryContainer,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                LinearProgressIndicator(
                  value: progress,
                  backgroundColor: Theme.of(context).colorScheme.surface,
                  color: Theme.of(context).colorScheme.primary,
                  minHeight: 10,
                  borderRadius: BorderRadius.circular(10),
                ),
              ],
            ),
          ),
          
          // Habits List
          Expanded(
            child: _habits.isEmpty
                ? const Center(child: Text('No habits yet. Add one!'))
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: _habits.length,
                    itemBuilder: (context, index) {
                      final habit = _habits[index];
                      return HabitTile(
                        habit: habit,
                        onToggle: () => _toggleHabit(habit),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final newHabit = await Navigator.push<Habit>(
            context,
            MaterialPageRoute(builder: (context) => const AddHabitScreen()),
          );
          if (newHabit != null) {
            _addHabit(newHabit);
          }
        },
        icon: const Icon(Icons.add),
        label: const Text('New Habit'),
      ),
    );
  }
}
