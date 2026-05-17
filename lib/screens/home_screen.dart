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
                    // Header Section
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(
                          horizontalPadding,
                          isSmall ? 40 : 80,
                          horizontalPadding,
                          isSmall ? 40 : 64,
                        ),
                        child: _HeaderSection(isSmall: isSmall),
                      ),
                    ),
                    
                    // Mood Selection Grid
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                        child: _MoodSelectionSection(isSmall: isSmall),
                      ),
                    ),
                    
                    SliverToBoxAdapter(
                      child: SizedBox(height: isSmall ? 64 : 100),
                    ),
                    
                    // Recent Journey Timeline
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
}

class _HeaderSection extends StatelessWidget {
  final bool isSmall;
  const _HeaderSection({required this.isSmall});

  @override
  Widget build(BuildContext context) {
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
    // We don't need to listen here because we only perform an action
    final provider = Provider.of<MoodProvider>(context, listen: false);

    return Wrap(
      spacing: isSmall ? 16 : 24,
      runSpacing: isSmall ? 16 : 24,
      alignment: WrapAlignment.center,
      children: MoodType.values.map((type) {
        return MoodCard(
          type: type,
          onTap: () => provider.addMood(type),
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

    return Column(
      children: [
        _SectionHeader(
          title: 'Your Recent Journey',
          icon: Icons.history_rounded,
          isSmall: isSmall,
        ),
        const SizedBox(height: 32),
        if (entries.isEmpty)
          const _EmptyTimelineState()
        else
          SizedBox(
            height: 200, // Increased height to prevent overflow and accommodate scale animations
            child: ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              itemCount: entries.length,
              separatorBuilder: (_, __) => const SizedBox(width: 16),
              itemBuilder: (context, index) {
                // Showing latest entries first if needed, but provider keeps them in order
                return TimelineCard(entry: entries[index]);
              },
            ),
          ),
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isSmall;

  const _SectionHeader({
    required this.title,
    required this.icon,
    required this.isSmall,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.indigo.withValues(alpha: 0.08),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.indigo, size: 20),
        ),
        const SizedBox(width: 14),
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w800,
                color: const Color(0xFF334155),
                fontSize: isSmall ? 20 : 24,
                letterSpacing: -0.5,
              ),
        ),
      ],
    );
  }
}

class _EmptyTimelineState extends StatelessWidget {
  const _EmptyTimelineState();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        children: [
          Icon(Icons.auto_awesome_rounded, size: 48, color: Colors.indigo.withValues(alpha: 0.3)),
          const SizedBox(height: 16),
          Text(
            'No moods logged yet',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade600,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Start by selecting how you feel above!',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey.shade400,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
