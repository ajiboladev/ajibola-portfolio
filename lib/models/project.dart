import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// Simple data model for each project shown in the Projects section.
/// Add / edit your real projects here — this is the only place
/// you need to touch to update that section.
class Project {
  final String title;
  final String description;
  final List<String> tags;
  final String role;
  final String? liveUrl;
  final String? githubUrl;
  final FaIconData icon; // used as a quick visual icon per card

  const Project({
    required this.title,
    required this.description,
    required this.tags,
    required this.role,
    required this.icon,
    this.liveUrl,
    this.githubUrl,
  });
}

/// 👉 Replace urls (null for now) with your real GitHub / live links.
final List<Project> projects = [
  Project(
    icon: FontAwesomeIcons.schoolFlag,
    title: 'School Portal System',
    description:
        'A full school management web platform with three dedicated portals — '
        'Student, Admin and Teacher — covering result checking, attendance, '
        'class & course management, announcements and an admin dashboard for '
        'overseeing the entire school operation.',
    tags: ['HTML', 'CSS', 'JavaScript', 'Bootstrap', 'Firebase'],
    role: 'Full-Stack Developer',
    liveUrl: null,
    githubUrl: null,
  ),
  Project(
    icon: FontAwesomeIcons.userGroup,
    title: 'JOYIN — Social Media Platform',
    description:
        'A social networking platform that lets users create profiles, share '
        'posts, follow other users, like & comment, and chat in real time — '
        'built with a Firebase real-time backend for instant updates across '
        'feeds and conversations.',
    tags: ['Flutter', 'Dart', 'Firebase', 'Cloud Firestore', 'Firebase Auth'],
    role: 'Mobile App Developer',
    liveUrl: null,
    githubUrl: null,
  ),
  Project(
    icon: FontAwesomeIcons.bagShopping,
    title: 'E-Commerce Storefront',
    description:
        'A responsive online store concept with product catalog, cart, '
        'checkout flow and an admin-side product manager — focused on clean '
        'UX and fast load times.',
    tags: ['Flutter', 'Dart', 'Firebase', 'Provider'],
    role: 'App Developer',
    liveUrl: null,
    githubUrl: null,
  ),
  Project(
    icon: FontAwesomeIcons.checkDouble,
    title: 'Task & Productivity Manager',
    description:
        'A clean to-do / task management app with reminders, categories and '
        'progress tracking, designed to help users stay organized with a calm, '
        'distraction-free interface.',
    tags: ['Flutter', 'Dart', 'Local Storage'],
    role: 'Mobile App Developer',
    liveUrl: null,
    githubUrl: null,
  ),
];
