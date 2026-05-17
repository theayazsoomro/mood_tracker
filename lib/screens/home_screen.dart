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
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isSmall = constraints.maxWidth < 600;
            final horizontalPadding = isSmall ? 20.0 : 48.0;

            return Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1200),
                child: CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(
                          horizontalPadding,
                          isSmall ? 40 : 80,
                          horizontalPadding,
                          isSmall ? 40 : 64,
                        ),
                        child: _buildHeader(context, isSmall),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                        child: _MoodSelectionSection(isSmall: isSmall),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: SizedBox(height: isSmall ? 64 : 100),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                        child: _TimelineSection(isSmall: isSmall),
                      ),
                    ),
                    const SliverPadding(padding: EdgeInsets.only(bottom: 80)),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, bool isSmall) {
    return Column(
      children: [
        Text(
          'How are you feeling today?',
          textAlign: TextAlign.center,
          style: (isSmall 
                  ? Theme.of(context).textTheme.headlineMedium 
                  : Theme.of(context).textTheme.displayMedium)
              ?.copyWith(
            fontWeight: FontWeight.w900,
            color: const Color(0xFF0F172A),
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
                fontSize: isSmall ? 16 : 18,
                height: 1.5,
              ),
        ),
      ],
    );
  }
}

class _MoodSelectionSection extends StatelessWidget {
  final bool isSmall;
  const _MoodSelectionSection({required this.isSmall});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MoodProvider>(context, listen: false);

    return Wrap(
      spacing: isSmall ? 16 : 24,
      runSpacing: isSmall ? 16 : 24,
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
  final bool isSmall;
  const _TimelineSection({required this.isSmall});

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
                    fontSize: isSmall ? 20 : 24,
                    letterSpacing: -0.5,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 48),
        SizedBox(
          height: 180,
          child: Center(
            child: ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              itemCount: entries.length,
              separatorBuilder: (_, __) => const SizedBox(width: 16),
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
