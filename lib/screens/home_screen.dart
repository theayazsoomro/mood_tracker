import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/mood_entry.dart';
import '../providers/mood_provider.dart';
import '../widgets/mood_face.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 64.0, horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'How are you feeling today?',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                ),
                const SizedBox(height: 64),
                _MoodSelector(),
                const SizedBox(height: 80),
                _MoodHistory(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MoodSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 32,
      runSpacing: 32,
      alignment: WrapAlignment.center,
      children: MoodType.values.map((type) {
        return _MoodButton(type: type);
      }).toList(),
    );
  }
}

class _MoodButton extends StatelessWidget {
  final MoodType type;

  const _MoodButton({required this.type});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MoodProvider>(context, listen: false);

    return InkWell(
      onTap: () => provider.addMood(type),
      borderRadius: BorderRadius.circular(24),
      hoverColor: Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.3),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            MoodFace(mood: type, size: 80),
            const SizedBox(height: 16),
            Text(
              type.name.toUpperCase(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MoodHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final entries = context.watch<MoodProvider>().entries;

    if (entries.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Recent History',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 32),
        SizedBox(
          height: 100,
          child: ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: entries.length,
            separatorBuilder: (_, __) => const SizedBox(width: 24),
            itemBuilder: (context, index) {
              final entry = entries[index];
              return Column(
                children: [
                  MoodFace(mood: entry.type, size: 48),
                  const SizedBox(height: 8),
                  Text(
                    _formatDate(entry.date),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}';
  }
}
