import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../theme/app_theme.dart';
import '../models/project.dart';
import '../widgets/glass_card.dart';
import '../widgets/section_heading.dart';

class ProjectsSection extends StatelessWidget {
  final GlobalKey sectionKey;
  const ProjectsSection({super.key, required this.sectionKey});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final crossAxisCount = width < 760 ? 1 : 2;

    return SectionWrapper(
      sectionKey: sectionKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeading(
            tag: 'PROJECTS',
            title: 'Things I\'ve built',
            subtitle: 'A selection of real projects — from full school systems to social platforms, and more.',
          ),
          const SizedBox(height: 44),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: projects.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              mainAxisSpacing: 24,
              crossAxisSpacing: 24,
              childAspectRatio: crossAxisCount == 1 ? 1.25 : 1.05,
            ),
            itemBuilder: (context, index) {
              return _ProjectCard(project: projects[index])
                  .animate()
                  .fadeIn(delay: (index * 100).ms, duration: 450.ms)
                  .slideY(begin: 0.15, end: 0);
            },
          ),
        ],
      ),
    );
  }
}

class _ProjectCard extends StatelessWidget {
  final Project project;
  const _ProjectCard({required this.project});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: AppColors.brand.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.center,
                child: FaIcon(project.icon, size: 22, color: AppColors.brandLight),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.glassBorder),
                ),
                child: Text(project.role, style: AppTheme.mono(10.5)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(project.title, style: AppTheme.display(18, weight: FontWeight.w700)),
          const SizedBox(height: 10),
          Expanded(
            child: Text(
              project.description,
              style: AppTheme.body(13.5, height: 1.65),
              overflow: TextOverflow.fade,
            ),
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: project.tags
                .map((t) => Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: AppColors.brand.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: AppColors.brand.withOpacity(0.25)),
                      ),
                      child: Text(t, style: AppTheme.mono(10.5, color: AppColors.brandLight)),
                    ))
                .toList(),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              if (project.githubUrl != null)
                _LinkChip(icon: FontAwesomeIcons.github, label: 'Code', url: project.githubUrl!)
              else
                _LinkChip(icon: FontAwesomeIcons.github, label: 'Code', url: null, disabled: true),
              const SizedBox(width: 10),
              if (project.liveUrl != null)
                _LinkChip(icon: FontAwesomeIcons.arrowUpRightFromSquare, label: 'Live', url: project.liveUrl!)
              else
                _LinkChip(icon: FontAwesomeIcons.arrowUpRightFromSquare, label: 'Live', url: null, disabled: true),
            ],
          ),
        ],
      ),
    );
  }
}

class _LinkChip extends StatelessWidget {
  final FaIconData icon;
  final String label;
  final String? url;
  final bool disabled;
  const _LinkChip({required this.icon, required this.label, required this.url, this.disabled = false});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: disabled ? 0.4 : 1,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.glassBorder),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            FaIcon(icon, size: 13, color: AppColors.textSecondary),
            const SizedBox(width: 6),
            Text(label, style: AppTheme.body(12, weight: FontWeight.w500, color: AppColors.textSecondary)),
          ],
        ),
      ),
    );
  }
}
