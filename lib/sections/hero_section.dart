import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';
import '../widgets/gradient_text.dart';
import '../widgets/primary_button.dart';

class HeroSection extends StatelessWidget {
  final GlobalKey sectionKey;
  final VoidCallback onViewProjects;
  final VoidCallback onContact;

  const HeroSection({
    super.key,
    required this.sectionKey,
    required this.onViewProjects,
    required this.onContact,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isMobile = width < 900;
    final nameSize = width < 640 ? 36.0 : (width < 900 ? 48.0 : 60.0);

    final textColumn = Column(
      crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        // Availability tag
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
          decoration: BoxDecoration(
            color: AppColors.success.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.success.withOpacity(0.4)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: AppColors.success,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text('Open to opportunities',
                  style: AppTheme.mono(12, color: AppColors.success)),
            ],
          ),
        ).animate().fadeIn(duration: 500.ms),

        const SizedBox(height: 24),

        Text('Hi, I\'m',
                textAlign: isMobile ? TextAlign.center : TextAlign.start,
                style: AppTheme.display(width < 640 ? 20 : 24,
                    weight: FontWeight.w500, color: AppColors.textSecondary))
            .animate()
            .fadeIn(delay: 100.ms, duration: 500.ms)
            .slideY(begin: 0.3, end: 0),

        const SizedBox(height: 6),

        GradientText(
          'ABDULAZEEZ\nAJIBOLA',
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
          style: AppTheme.display(nameSize, weight: FontWeight.w800, height: 1.08),
        ).animate().fadeIn(delay: 200.ms, duration: 600.ms).slideY(begin: 0.3, end: 0),

        const SizedBox(height: 18),

        // Animated rotating role text
        SizedBox(
          height: 32,
          child: DefaultTextStyle(
            style: AppTheme.display(width < 640 ? 16 : 20,
                weight: FontWeight.w600, color: AppColors.brandLight),
            child: const _RotatingRoles(),
          ),
        ).animate().fadeIn(delay: 300.ms, duration: 500.ms),

        const SizedBox(height: 18),

        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: Text(
            'Mobile App & Web Developer crafting smooth, modern experiences with '
            'Flutter, Firebase and the web stack — currently studying at SQI College '
            'of ICT, Iwo-Road Campus. I turn ideas into fast, reliable, beautifully '
            'designed products.',
            textAlign: isMobile ? TextAlign.center : TextAlign.start,
            style: AppTheme.body(15.5, height: 1.7),
          ),
        ).animate().fadeIn(delay: 400.ms, duration: 500.ms),

        const SizedBox(height: 34),

        Wrap(
          alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
          spacing: 14,
          runSpacing: 14,
          children: [
            PrimaryButton(
              label: 'View My Work',
              icon: Icons.arrow_forward_rounded,
              onPressed: onViewProjects,
            ),
            PrimaryButton(
              label: 'Contact Me',
              outlined: true,
              onPressed: onContact,
            ),
          ],
        ).animate().fadeIn(delay: 500.ms, duration: 500.ms),
      ],
    );

    final avatar = _AvatarGlow(size: isMobile ? 220 : 300);

    return Container(
      key: sectionKey,
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: width < 640 ? 20 : 40,
        vertical: isMobile ? 60 : 40,
      ),
      constraints: BoxConstraints(minHeight: isMobile ? 0 : MediaQuery.sizeOf(context).height * 0.92),
      alignment: Alignment.center,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1140),
          child: isMobile
              ? Column(
                  children: [
                    avatar,
                    const SizedBox(height: 40),
                    textColumn,
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(flex: 6, child: textColumn),
                    const SizedBox(width: 40),
                    Expanded(flex: 4, child: Center(child: avatar)),
                  ],
                ),
        ),
      ),
    );
  }
}

class _RotatingRoles extends StatefulWidget {
  const _RotatingRoles();

  @override
  State<_RotatingRoles> createState() => _RotatingRolesState();
}

class _RotatingRolesState extends State<_RotatingRoles> {
  static const roles = [
    'Flutter & Dart Developer',
    'Web Developer (HTML · CSS · JS)',
    'Firebase Enthusiast',
    'Building JOYIN 🚀',
  ];
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _loop();
  }

  Future<void> _loop() async {
    while (mounted) {
      await Future.delayed(const Duration(seconds: 3));
      if (!mounted) return;
      setState(() => _index = (_index + 1) % roles.length);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 450),
      transitionBuilder: (child, anim) => FadeTransition(
        opacity: anim,
        child: SlideTransition(
          position: Tween(begin: const Offset(0, 0.4), end: Offset.zero).animate(anim),
          child: child,
        ),
      ),
      child: Text(roles[_index], key: ValueKey(_index)),
    );
  }
}

/// Profile circle with a glowing, pulsing ring around it.
/// Replace the icon Container with an Image.asset of your real photo
/// once you add it under assets/images/.
class _AvatarGlow extends StatefulWidget {
  final double size;
  const _AvatarGlow({required this.size});

  @override
  State<_AvatarGlow> createState() => _AvatarGlowState();
}

class _AvatarGlowState extends State<_AvatarGlow> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 3))
      ..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        final glow = 0.35 + (_controller.value * 0.25);
        return Container(
          width: widget.size,
          height: widget.size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: AppColors.brandGradient,
            boxShadow: [
              BoxShadow(
                color: AppColors.brand.withOpacity(glow),
                blurRadius: 60,
                spreadRadius: 6,
              ),
            ],
          ),
          padding: const EdgeInsets.all(5),
          child: Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.bgSurface,
            ),
            padding: const EdgeInsets.all(4),
            child: ClipOval(
              child: Container(
                color: AppColors.bgSurfaceAlt,
                alignment: Alignment.center,
                // 👉 Swap this Icon for:
                // Image.asset('assets/images/profile.jpg', fit: BoxFit.cover)
                child: Icon(
                  Icons.person_rounded,
                  size: widget.size * 0.5,
                  color: AppColors.brandLight.withOpacity(0.6),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
