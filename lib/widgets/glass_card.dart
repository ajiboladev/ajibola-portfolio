import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// The signature "glassy" surface used everywhere in the portfolio:
/// blurred background, faint white border, subtle gradient sheen,
/// and an optional glow on hover (desktop) for extra polish.
class GlassCard extends StatefulWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final bool hoverGlow;
  final VoidCallback? onTap;

  const GlassCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(24),
    this.borderRadius = 24,
    this.hoverGlow = true,
    this.onTap,
  });

  @override
  State<GlassCard> createState() => _GlassCardState();
}

class _GlassCardState extends State<GlassCard> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final content = AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOut,
      transform: Matrix4.identity()
        ..translate(0.0, _hovering && widget.hoverGlow ? -4.0 : 0.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.borderRadius),
        boxShadow: _hovering && widget.hoverGlow
            ? [
                BoxShadow(
                  color: AppColors.brand.withOpacity(0.35),
                  blurRadius: 36,
                  spreadRadius: -6,
                  offset: const Offset(0, 14),
                ),
              ]
            : [],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(widget.borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
          child: Container(
            padding: widget.padding,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.glassFill,
                  Colors.white.withOpacity(0.03),
                ],
              ),
              border: Border.all(
                color: _hovering
                    ? AppColors.brand.withOpacity(0.5)
                    : AppColors.glassBorder,
                width: 1,
              ),
            ),
            child: widget.child,
          ),
        ),
      ),
    );

    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      cursor: widget.onTap != null
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      child: GestureDetector(onTap: widget.onTap, child: content),
    );
  }
}
