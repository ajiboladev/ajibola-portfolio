import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_theme.dart';
import '../widgets/glass_card.dart';
import '../widgets/section_heading.dart';
import '../widgets/primary_button.dart';

class ContactSection extends StatefulWidget {
  final GlobalKey sectionKey;
  const ContactSection({super.key, required this.sectionKey});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _msgCtrl = TextEditingController();
  bool _sent = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _msgCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      // 👉 Hook this up to Firebase / Firestore / EmailJS / Formspree etc.
      // For now it just opens the user's mail client as a simple fallback:
      final subject = Uri.encodeComponent('Portfolio Contact from ${_nameCtrl.text}');
      final body = Uri.encodeComponent('${_msgCtrl.text}\n\n— ${_nameCtrl.text} (${_emailCtrl.text})');
      launchUrl(Uri.parse('mailto:youremail@example.com?subject=$subject&body=$body'));
      setState(() => _sent = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isMobile = width < 900;

    final infoColumn = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Let\'s build something great', style: AppTheme.display(22, weight: FontWeight.w700)),
        const SizedBox(height: 12),
        Text(
          'Whether it\'s a Flutter app, a web platform, or you just want to talk '
          'tech — my inbox is open. I usually reply within a day.',
          style: AppTheme.body(14.5, height: 1.7),
        ),
        const SizedBox(height: 28),
        _ContactRow(icon: FontAwesomeIcons.envelope, label: 'youremail@example.com', url: 'mailto:youremail@example.com'),
        const SizedBox(height: 16),
        _ContactRow(icon: FontAwesomeIcons.phone, label: '+234 000 000 0000', url: 'tel:+2340000000000'),
        const SizedBox(height: 16),
        _ContactRow(icon: FontAwesomeIcons.locationDot, label: 'Iwo Road, Ibadan, Nigeria', url: null),
        const SizedBox(height: 28),
        Row(
          children: const [
            _SocialIcon(icon: FontAwesomeIcons.github, url: 'https://github.com/yourusername'),
            SizedBox(width: 12),
            _SocialIcon(icon: FontAwesomeIcons.linkedinIn, url: 'https://linkedin.com/in/yourusername'),
            SizedBox(width: 12),
            _SocialIcon(icon: FontAwesomeIcons.xTwitter, url: 'https://twitter.com/yourusername'),
            SizedBox(width: 12),
            _SocialIcon(icon: FontAwesomeIcons.instagram, url: 'https://instagram.com/yourusername'),
          ],
        ),
      ],
    );

    final formCard = GlassCard(
      hoverGlow: false,
      child: _sent
          ? _SuccessState(onReset: () => setState(() => _sent = false))
          : Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _Field(label: 'Your Name', controller: _nameCtrl, hint: 'John Doe'),
                  const SizedBox(height: 16),
                  _Field(
                    label: 'Your Email',
                    controller: _emailCtrl,
                    hint: 'john@example.com',
                    validator: (v) {
                      if (v == null || v.isEmpty) return 'Email is required';
                      if (!v.contains('@')) return 'Enter a valid email';
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  _Field(label: 'Message', controller: _msgCtrl, hint: 'Tell me about your project...', maxLines: 5),
                  const SizedBox(height: 22),
                  SizedBox(
                    width: double.infinity,
                    child: Center(
                      child: PrimaryButton(label: 'Send Message', icon: Icons.send_rounded, onPressed: _submit),
                    ),
                  ),
                ],
              ),
            ),
    );

    return SectionWrapper(
      sectionKey: widget.sectionKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeading(
            tag: 'CONTACT',
            title: 'Get in touch',
            center: false,
          ),
          const SizedBox(height: 44),
          isMobile
              ? Column(
                  children: [
                    infoColumn,
                    const SizedBox(height: 32),
                    formCard,
                  ],
                )
              : IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 4, child: infoColumn),
                      const SizedBox(width: 40),
                      Expanded(flex: 6, child: formCard),
                    ],
                  ),
                ),
          const SizedBox(height: 70),
          Divider(color: AppColors.glassBorder),
          const SizedBox(height: 24),
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 12,
            runSpacing: 12,
            children: [
              Text('© 2026 Abdulazeez Ajibola. All rights reserved.',
                  style: AppTheme.body(12.5, color: AppColors.textMuted)),
              Text('Built with Flutter 💙', style: AppTheme.body(12.5, color: AppColors.textMuted)),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class _Field extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String hint;
  final int maxLines;
  final String? Function(String?)? validator;

  const _Field({
    required this.label,
    required this.controller,
    required this.hint,
    this.maxLines = 1,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTheme.body(12.5, weight: FontWeight.w600, color: AppColors.textSecondary)),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          validator: validator ?? (v) => (v == null || v.isEmpty) ? '$label is required' : null,
          style: AppTheme.body(14, color: AppColors.textPrimary),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: AppTheme.body(14, color: AppColors.textMuted),
            filled: true,
            fillColor: Colors.white.withOpacity(0.04),
            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.glassBorder),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.glassBorder),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.brand, width: 1.4),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.redAccent),
            ),
          ),
        ),
      ],
    );
  }
}

class _ContactRow extends StatelessWidget {
  final FaIconData icon;
  final String label;
  final String? url;
  const _ContactRow({required this.icon, required this.label, required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: url == null ? null : () => launchUrl(Uri.parse(url!)),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: AppColors.brand.withOpacity(0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.center,
            child: FaIcon(icon, size: 15, color: AppColors.brandLight),
          ),
          const SizedBox(width: 12),
          Text(label, style: AppTheme.body(14, color: AppColors.textPrimary)),
        ],
      ),
    );
  }
}

class _SocialIcon extends StatefulWidget {
  final FaIconData  icon;
  final String url;
  const _SocialIcon({required this.icon, required this.url});

  @override
  State<_SocialIcon> createState() => _SocialIconState();
}

class _SocialIconState extends State<_SocialIcon> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: () => launchUrl(Uri.parse(widget.url)),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: _hovering ? AppColors.brand.withOpacity(0.2) : Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _hovering ? AppColors.brand : AppColors.glassBorder),
          ),
          alignment: Alignment.center,
          child: FaIcon(widget.icon, size: 16, color: _hovering ? AppColors.brandLight : AppColors.textSecondary),
        ),
      ),
    );
  }
}

class _SuccessState extends StatelessWidget {
  final VoidCallback onReset;
  const _SuccessState({required this.onReset});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: AppColors.success.withOpacity(0.12),
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.success.withOpacity(0.4)),
            ),
            alignment: Alignment.center,
            child: const Icon(Icons.check_rounded, color: AppColors.success, size: 28),
          ),
          const SizedBox(height: 16),
          Text('Message ready to send!', style: AppTheme.display(16, weight: FontWeight.w700)),
          const SizedBox(height: 6),
          Text('Your mail app should be opening now.',
              textAlign: TextAlign.center, style: AppTheme.body(13)),
          const SizedBox(height: 16),
          TextButton(onPressed: onReset, child: Text('Send another message', style: AppTheme.body(13, color: AppColors.brandLight))),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms).scale(begin: const Offset(0.95, 0.95));
  }
}
