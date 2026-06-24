import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';
import 'gradient_text.dart';

/// Consistent "TAG / Heading / subtitle" block used at the top of
/// every section (About, Skills, Education, Projects, Contact).
class SectionHeading extends StatelessWidget {
  final String tag;
  final String title;
  final String? subtitle;
  final bool center;

  const SectionHeading({
    super.key,
    required this.tag,
    required this.title,
    this.subtitle,
    this.center = false,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final titleSize = width < 640 ? 30.0 : 40.0;

    return Column(
      crossAxisAlignment:
          center ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.brand.withOpacity(0.12),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.brand.withOpacity(0.35)),
          ),
          child: Text(tag, style: AppTheme.mono(12, weight: FontWeight.w600)),
        ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.3, end: 0),
        const SizedBox(height: 16),
        GradientText(
          title,
          textAlign: center ? TextAlign.center : TextAlign.start,
          style: AppTheme.display(titleSize, weight: FontWeight.w700),
        ).animate().fadeIn(delay: 100.ms, duration: 500.ms).slideY(begin: 0.3, end: 0),
        if (subtitle != null) ...[
          const SizedBox(height: 12),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: Text(
              subtitle!,
              textAlign: center ? TextAlign.center : TextAlign.start,
              style: AppTheme.body(16, height: 1.6),
            ),
          ).animate().fadeIn(delay: 200.ms, duration: 500.ms),
        ],
      ],
    );
  }
}

/// Gives every section the same max-width, horizontal padding and
/// vertical breathing room, and assigns it a key for nav-bar scrolling.
class SectionWrapper extends StatelessWidget {
  final Widget child;
  final GlobalKey sectionKey;
  final Color? backgroundColor;

  const SectionWrapper({
    super.key,
    required this.child,
    required this.sectionKey,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final horizontalPad = width < 640
        ? 20.0
        : width < 1024
            ? 40.0
            : (width - 1140).clamp(24, 400) / 2 + 24;

    return Container(
      key: sectionKey,
      width: double.infinity,
      color: backgroundColor,
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPad,
        vertical: width < 640 ? 64 : 100,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1140),
          child: child,
        ),
      ),
    );
  }
}
