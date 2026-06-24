import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_theme.dart';
import '../widgets/glass_card.dart';
import '../widgets/section_heading.dart';

class EducationSection extends StatelessWidget {
  final GlobalKey sectionKey;
  const EducationSection({super.key, required this.sectionKey});

  @override
  Widget build(BuildContext context) {
    return SectionWrapper(
      sectionKey: sectionKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeading(
            tag: 'EDUCATION',
            title: 'My learning journey',
            subtitle: 'Where I\'m sharpening the skills behind everything I build.',
          ),
          const SizedBox(height: 44),
          GlassCard(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    gradient: AppColors.brandGradient,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.brand.withOpacity(0.4),
                        blurRadius: 18,
                        spreadRadius: -2,
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: const FaIcon(FontAwesomeIcons.graduationCap, color: Colors.white, size: 22),
                ),
                const SizedBox(width: 18),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 10,
                        children: [
                          Text('Mobile App & Web Development',
                              style: AppTheme.display(17, weight: FontWeight.w700)),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColors.success.withOpacity(0.12),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: AppColors.success.withOpacity(0.35)),
                            ),
                            child: Text('In Progress',
                                style: AppTheme.mono(11, color: AppColors.success)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      GestureDetector(
                        onTap: () => launchUrl(Uri.parse('https://sqi.edu.ng')),
                        child: Text(
                          'SQI College of ICT — Iwo-Road Campus',
                          style: AppTheme.body(14.5, weight: FontWeight.w500, color: AppColors.brandLight),
                        ),
                      ),
                      const SizedBox(height: 14),
                      Text(
                        'Studying full-stack web development and Flutter-based mobile app '
                        'development — covering frontend & backend fundamentals, Firebase, '
                        'version control with Git/GitHub, and real-world project building '
                        'through hands-on coursework.',
                        style: AppTheme.body(14.5, height: 1.7),
                      ),
                      const SizedBox(height: 14),
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: const [
                          _Pill('Web Development'),
                          _Pill('Mobile App Development'),
                          _Pill('Firebase'),
                          _Pill('Git & GitHub'),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.15, end: 0),
        ],
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  final String label;
  const _Pill(this.label);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.glassBorder),
      ),
      child: Text(label, style: AppTheme.mono(11.5)),
    );
  }
}
