import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// The glowing brand-color CTA button used across the portfolio
/// (e.g. "View Projects", "Contact Me", "Send Message").
class PrimaryButton extends StatefulWidget {
  final String label;
  final VoidCallback onPressed;
  final IconData? icon;
  final bool outlined;

  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.outlined = false,
  });

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
          transform: Matrix4.identity()..scale(_hovering ? 1.03 : 1.0),
          transformAlignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            gradient: widget.outlined ? null : AppColors.brandGradient,
            color: widget.outlined ? Colors.transparent : null,
            border: widget.outlined
                ? Border.all(color: AppColors.glassBorder, width: 1.4)
                : null,
            boxShadow: !widget.outlined && _hovering
                ? [
                    BoxShadow(
                      color: AppColors.brand.withOpacity(0.55),
                      blurRadius: 28,
                      spreadRadius: -2,
                      offset: const Offset(0, 8),
                    ),
                  ]
                : !widget.outlined
                    ? [
                        BoxShadow(
                          color: AppColors.brand.withOpacity(0.3),
                          blurRadius: 20,
                          spreadRadius: -4,
                          offset: const Offset(0, 6),
                        ),
                      ]
                    : [],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.label,
                style: AppTheme.body(15,
                    weight: FontWeight.w600,
                    color: widget.outlined
                        ? AppColors.textPrimary
                        : Colors.white),
              ),
              if (widget.icon != null) ...[
                const SizedBox(width: 10),
                Icon(widget.icon,
                    size: 16,
                    color: widget.outlined
                        ? AppColors.textPrimary
                        : Colors.white),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
