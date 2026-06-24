import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';
import 'glass_card.dart';
import 'primary_button.dart';

class NavItem {
  final String label;
  final VoidCallback onTap;
  NavItem(this.label, this.onTap);
}

/// Floating glass nav bar pinned to the top. Collapses into a clean
/// drawer menu on mobile widths.
class NavBar extends StatelessWidget implements PreferredSizeWidget {
  final List<NavItem> items;
  final VoidCallback onContact;

  const NavBar({super.key, required this.items, required this.onContact});

  @override
  Size get preferredSize => const Size.fromHeight(86);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isMobile = width < 900;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: GlassCard(
          hoverGlow: false,
          borderRadius: 18,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Row(
            children: [
              // Logo / initials
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  gradient: AppColors.brandGradient,
                  borderRadius: BorderRadius.circular(11),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.brand.withOpacity(0.5),
                      blurRadius: 18,
                      spreadRadius: -2,
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: Text('AA',
                    style: AppTheme.display(15, weight: FontWeight.w700)),
              ),
              const SizedBox(width: 12),
              Text('Abdulazeez',
                  style: AppTheme.display(16, weight: FontWeight.w600)),

              const Spacer(),

              if (!isMobile) ...[
                for (final item in items)
                  _NavLink(label: item.label, onTap: item.onTap),
                const SizedBox(width: 8),
                PrimaryButton(label: 'Contact', onPressed: onContact),
              ] else
                IconButton(
                  icon: const Icon(Icons.menu_rounded, color: AppColors.textPrimary),
                  onPressed: () => _openMobileMenu(context),
                ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(duration: 500.ms).slideY(begin: -0.3, end: 0);
  }

  void _openMobileMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => GlassCard(
        borderRadius: 24,
        hoverGlow: false,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8),
            for (final item in items)
              ListTile(
                title: Text(item.label,
                    style: AppTheme.body(16, weight: FontWeight.w600, color: AppColors.textPrimary)),
                onTap: () {
                  Navigator.pop(ctx);
                  item.onTap();
                },
              ),
            const SizedBox(height: 8),
            PrimaryButton(
              label: 'Contact Me',
              onPressed: () {
                Navigator.pop(ctx);
                onContact();
              },
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}

class _NavLink extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  const _NavLink({required this.label, required this.onTap});

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          child: Text(
            widget.label,
            style: AppTheme.body(
              14.5,
              weight: FontWeight.w500,
              color: _hovering ? AppColors.textPrimary : AppColors.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}
