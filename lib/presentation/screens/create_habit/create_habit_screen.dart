import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers.dart';
import '../../../domain/entities/habit.dart';
import '../../../domain/entities/habit_frequency.dart';

class CreateHabitScreen extends ConsumerStatefulWidget {
  const CreateHabitScreen({super.key});

  static const routeName = 'createHabit';

  @override
  ConsumerState<CreateHabitScreen> createState() => _CreateHabitScreenState();
}

class _CreateHabitScreenState extends ConsumerState<CreateHabitScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emojiController = TextEditingController(text: '🔥');
  HabitFrequency _frequency = HabitFrequency.daily;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Habit')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Habit name'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Enter a name' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _emojiController,
                decoration: const InputDecoration(labelText: 'Emoji'),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<HabitFrequency>(
                value: _frequency,
                items: HabitFrequency.values
                    .map(
                      (f) => DropdownMenuItem(
                        value: f,
                        child: Text(f.name),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _frequency = value);
                  }
                },
                decoration: const InputDecoration(labelText: 'Frequency'),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () async {
                  if (!_formKey.currentState!.validate()) return;
                  final createHabit = ref.read(createHabitProvider);
                  final id = DateTime.now().millisecondsSinceEpoch.toString();
                  final habit = Habit(
                    id: id,
                    name: _nameController.text.trim(),
                    emoji: _emojiController.text.trim(),
                    frequency: _frequency,
                  );
                  await createHabit(habit);
                  if (mounted) Navigator.of(context).pop();
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emojiController.dispose();
    super.dispose();
  }
}
