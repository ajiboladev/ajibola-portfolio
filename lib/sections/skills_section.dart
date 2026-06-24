import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../theme/app_theme.dart';
import '../models/skill.dart';
import '../widgets/glass_card.dart';
import '../widgets/section_heading.dart';

class SkillsSection extends StatelessWidget {
  final GlobalKey sectionKey;
  const SkillsSection({super.key, required this.sectionKey});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final crossAxisCount = width < 640
        ? 2
        : width < 900
            ? 3
            : 4;

    return SectionWrapper(
      sectionKey: sectionKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeading(
            tag: 'SKILLS & TOOLS',
            title: 'What I work with',
            subtitle: 'The languages, frameworks and tools I use to build real, polished products.',
          ),
          const SizedBox(height: 44),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: skills.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: width < 640 ? 1.05 : 1.15,
            ),
            itemBuilder: (context, index) {
              final skill = skills[index];
              return _SkillCard(skill: skill)
                  .animate()
                  .fadeIn(delay: (index * 60).ms, duration: 400.ms)
                  .slideY(begin: 0.2, end: 0);
            },
          ),
        ],
      ),
    );
  }
}

class _SkillCard extends StatelessWidget {
  final Skill skill;
  const _SkillCard({required this.skill});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.brand.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: FaIcon(skill.icon, size: 20, color: AppColors.brandLight),
          ),
          const Spacer(),
          Text(skill.name, style: AppTheme.display(14.5, weight: FontWeight.w600)),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: skill.level,
              minHeight: 6,
              backgroundColor: Colors.white.withOpacity(0.08),
              color: AppColors.brand,
            ),
          ),
        ],
      ),
    );
  }
}
