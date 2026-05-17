import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/mood_entry.dart';
import '../providers/mood_provider.dart';
import '../widgets/mood_card.dart';
import '../widgets/timeline_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC), // Modern wellness soft background
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1100),
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 80, 24, 64),
                    child: _buildHeader(context),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: _MoodSelectionSection(),
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 120)),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: _TimelineSection(),
                  ),
                ),
                const SliverPadding(padding: EdgeInsets.only(bottom: 80)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      children: [
        Text(
          'How are you feeling today?',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                fontWeight: FontWeight.w900,
                color: const Color(0xFF0F172A),
                fontSize: 48,
                letterSpacing: -1.5,
              ),
        ),
        const SizedBox(height: 16),
        Text(
          'Tracking your moods helps you understand your emotional patterns.',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: const Color(0xFF64748B),
                fontWeight: FontWeight.w400,
                height: 1.5,
              ),
        ),
      ],
    );
  }
}

class _MoodSelectionSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MoodProvider>(context, listen: false);

    return Wrap(
      spacing: 24,
      runSpacing: 24,
      alignment: WrapAlignment.center,
      children: MoodType.values.map((type) {
        return MoodCard(
          type: type,
          onTap: () {
            provider.addMood(type);
          },
        );
      }).toList(),
    );
  }
}

class _TimelineSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final entries = context.watch<MoodProvider>().entries;

    if (entries.isEmpty) return const SizedBox.shrink();

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.indigo.withValues(alpha: 0.08),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.history_rounded, color: Colors.indigo, size: 20),
            ),
            const SizedBox(width: 14),
            Text(
              'Your Recent Journey',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF334155),
                    letterSpacing: -0.5,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 48),
        SizedBox(
          height: 110,
          child: Center(
            child: ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: entries.length,
              separatorBuilder: (_, __) => const SizedBox(width: 20),
              itemBuilder: (context, index) {
                return TimelineCard(entry: entries[index]);
              },
            ),
          ),
        ),
      ],
    );
  }
}
