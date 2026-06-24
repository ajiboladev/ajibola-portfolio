import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'widgets/glow_background.dart';
import 'widgets/nav_bar.dart';
import 'sections/hero_section.dart';
import 'sections/about_section.dart';
import 'sections/skills_section.dart';
import 'sections/education_section.dart';
import 'sections/projects_section.dart';
import 'sections/contact_section.dart';

void main() {
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Abdulazeez Ajibola — Portfolio',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      home: const PortfolioHome(),
    );
  }
}

class PortfolioHome extends StatefulWidget {
  const PortfolioHome({super.key});

  @override
  State<PortfolioHome> createState() => _PortfolioHomeState();
}

class _PortfolioHomeState extends State<PortfolioHome> {
  final _scrollController = ScrollController();

  final _heroKey = GlobalKey();
  final _aboutKey = GlobalKey();
  final _skillsKey = GlobalKey();
  final _educationKey = GlobalKey();
  final _projectsKey = GlobalKey();
  final _contactKey = GlobalKey();

  void _scrollTo(GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: NavBar(
        onContact: () => _scrollTo(_contactKey),
        items: [
          NavItem('Home', () => _scrollTo(_heroKey)),
          NavItem('About', () => _scrollTo(_aboutKey)),
          NavItem('Skills', () => _scrollTo(_skillsKey)),
          NavItem('Education', () => _scrollTo(_educationKey)),
          NavItem('Projects', () => _scrollTo(_projectsKey)),
        ],
      ),
      body: GlowBackground(
        child: SingleChildScrollView(
          controller: _scrollController,
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(height: 86), // space for floating nav bar
              HeroSection(
                sectionKey: _heroKey,
                onViewProjects: () => _scrollTo(_projectsKey),
                onContact: () => _scrollTo(_contactKey),
              ),
              AboutSection(sectionKey: _aboutKey),
              SkillsSection(sectionKey: _skillsKey),
              EducationSection(sectionKey: _educationKey),
              ProjectsSection(sectionKey: _projectsKey),
              ContactSection(sectionKey: _contactKey),
            ],
          ),
        ),
      ),
    );
  }
}
