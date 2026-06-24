import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Soft, slowly-drifting glow orbs behind the content — this is what
/// gives the whole portfolio its "glowing" premium feel without
/// costing much performance (just a few animated blurred circles).
class GlowBackground extends StatefulWidget {
  final Widget child;
  const GlowBackground({super.key, required this.child});

  @override
  State<GlowBackground> createState() => _GlowBackgroundState();
}

class _GlowBackgroundState extends State<GlowBackground>
    with TickerProviderStateMixin {
  late final AnimationController _c1;
  late final AnimationController _c2;

  @override
  void initState() {
    super.initState();
    _c1 = AnimationController(vsync: this, duration: const Duration(seconds: 18))
      ..repeat(reverse: true);
    _c2 = AnimationController(vsync: this, duration: const Duration(seconds: 24))
      ..repeat(reverse: true);
  }

  @override
  void dispose() {
    _c1.dispose();
    _c2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Stack(
      children: [
        // Base color
        Container(color: AppColors.bgDeep),

        // Drifting glow blob #1 (brand purple-blue)
        AnimatedBuilder(
          animation: _c1,
          builder: (context, _) {
            final dx = -60 + (_c1.value * 120);
            final dy = -40 + (_c1.value * 80);
            return Positioned(
              top: size.height * 0.05 + dy,
              left: size.width * 0.05 + dx,
              child: _blob(420, AppColors.brand.withOpacity(0.35)),
            );
          },
        ),

        // Drifting glow blob #2 (lighter accent)
        AnimatedBuilder(
          animation: _c2,
          builder: (context, _) {
            final dx = 40 - (_c2.value * 100);
            final dy = 30 - (_c2.value * 60);
            return Positioned(
              bottom: size.height * 0.05 + dy,
              right: size.width * 0.02 + dx,
              child: _blob(380, AppColors.brandLight.withOpacity(0.22)),
            );
          },
        ),

        // Subtle vignette so content stays readable
        Container(
          decoration: const BoxDecoration(
            gradient: RadialGradient(
              center: Alignment.center,
              radius: 1.3,
              colors: [Colors.transparent, Color(0xCC07070C)],
            ),
          ),
        ),

        widget.child,
      ],
    );
  }

  Widget _blob(double size, Color color) {
    return IgnorePointer(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [color, color.withOpacity(0)],
          ),
        ),
      ),
    );
  }
}
