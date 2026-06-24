import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../theme/app_theme.dart';
import '../widgets/glass_card.dart';
import '../widgets/section_heading.dart';

class AboutSection extends StatelessWidget {
  final GlobalKey sectionKey;
  const AboutSection({super.key, required this.sectionKey});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isMobile = width < 900;

    final stats = [
      _Stat(value: '2+', label: 'Years Learning & Building'),
      _Stat(value: '4+', label: 'Projects Completed'),
      _Stat(value: '7+', label: 'Tech Skills Mastered'),
      _Stat(value: '100%', label: 'Commitment to Quality'),
    ];

    final bioCard = GlassCard(
      hoverGlow: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'I\'m a passionate Mobile App & Web Developer studying at SQI College '
            'of ICT, Iwo-Road Campus, where I\'m sharpening my skills in both web '
            'and mobile development.',
            style: AppTheme.body(15.5, height: 1.8, color: AppColors.textPrimary),
          ),
          const SizedBox(height: 16),
          Text(
            'On the web side, I build with HTML, CSS, JavaScript and Bootstrap, '
            'and I rely on Firebase and GitHub to ship and manage real, working '
            'products — not just demos. On mobile, I build with Flutter and Dart, '
            'where I enjoy turning ideas into smooth, well-designed apps that '
            'people actually want to use.',
            style: AppTheme.body(15.5, height: 1.8),
          ),
          const SizedBox(height: 16),
          Text(
            'I\'ve built a multi-portal School Management System (Student, Admin '
            'and Teacher portals), and JOYIN, a social media platform with '
            'real-time interactions — among other projects. I care about clean '
            'code, fast performance, and interfaces that feel genuinely good to use.',
            style: AppTheme.body(15.5, height: 1.8),
          ),
        ],
      ),
    );

    final highlights = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _HighlightTile(
          icon: FontAwesomeIcons.mobileScreenButton,
          title: 'Mobile Development',
          desc: 'Flutter & Dart apps with clean architecture and real-time Firebase backends.',
        ),
        const SizedBox(height: 16),
        _HighlightTile(
          icon: FontAwesomeIcons.globe,
          title: 'Web Development',
          desc: 'Responsive, fast websites with HTML, CSS, JavaScript and Bootstrap.',
        ),
        const SizedBox(height: 16),
        _HighlightTile(
          icon: FontAwesomeIcons.bolt,
          title: 'Always Shipping',
          desc: 'I learn by building — every project is a real, working product.',
        ),
      ],
    );

    return SectionWrapper(
      sectionKey: sectionKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeading(
            tag: 'ABOUT ME',
            title: 'Get to know me',
            subtitle: 'A quick look at who I am, what I do, and how I work.',
          ),
          const SizedBox(height: 48),
          isMobile
              ? Column(
                  children: [
                    bioCard,
                    const SizedBox(height: 28),
                    highlights,
                  ],
                )
              : IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 6, child: bioCard),
                      const SizedBox(width: 32),
                      Expanded(flex: 4, child: highlights),
                    ],
                  ),
                ),
          const SizedBox(height: 48),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            alignment: WrapAlignment.center,
            children: stats
                .map((s) => SizedBox(
                      width: isMobile ? (width - 56) / 2 : 250,
                      child: _StatCard(stat: s),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _Stat {
  final String value;
  final String label;
  _Stat({required this.value, required this.label});
}

class _StatCard extends StatelessWidget {
  final _Stat stat;
  const _StatCard({required this.stat});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 12),
      child: Column(
        children: [
          Text(stat.value, style: AppTheme.display(28, weight: FontWeight.w800, color: AppColors.brandLight)),
          const SizedBox(height: 6),
          Text(
            stat.label,
            textAlign: TextAlign.center,
            style: AppTheme.body(12.5, color: AppColors.textSecondary),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms).scale(begin: const Offset(0.9, 0.9));
  }
}

class _HighlightTile extends StatelessWidget {
  final FaIconData icon;
  final String title;
  final String desc;
  const _HighlightTile({required this.icon, required this.title, required this.desc});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      hoverGlow: true,
      padding: const EdgeInsets.all(18),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.brand.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: FaIcon(icon, size: 18, color: AppColors.brandLight),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTheme.display(15, weight: FontWeight.w600)),
                const SizedBox(height: 4),
                Text(desc, style: AppTheme.body(13, height: 1.5)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
