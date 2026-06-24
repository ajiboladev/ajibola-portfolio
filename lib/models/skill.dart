import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Skill {
  final String name;
  final FaIconData  icon;
  final double level; // 0.0 - 1.0, used for the progress bar
  final String category;

  const Skill({
    required this.name,
    required this.icon,
    required this.level,
    required this.category,
  });
}

/// 👉 Tune the `level` values to honestly reflect your comfort with each tool.
final List<Skill> skills = [
  Skill(name: 'HTML5', icon: FontAwesomeIcons.html5, level: 0.95, category: 'Web'),
  Skill(name: 'CSS3', icon: FontAwesomeIcons.css3Alt, level: 0.9, category: 'Web'),
  Skill(name: 'JavaScript', icon: FontAwesomeIcons.js, level: 0.85, category: 'Web'),
  Skill(name: 'Bootstrap', icon: FontAwesomeIcons.bootstrap, level: 0.9, category: 'Web'),
  Skill(name: 'Flutter', icon: FontAwesomeIcons.mobileScreenButton, level: 0.85, category: 'Mobile'),
  Skill(name: 'Dart', icon: FontAwesomeIcons.code, level: 0.85, category: 'Mobile'),
  Skill(name: 'Firebase', icon: FontAwesomeIcons.fire, level: 0.85, category: 'Backend'),
  Skill(name: 'GitHub', icon: FontAwesomeIcons.github, level: 0.9, category: 'Tools'),
  Skill(name: 'Git', icon: FontAwesomeIcons.gitAlt, level: 0.88, category: 'Tools'),
  Skill(name: 'REST APIs', icon: FontAwesomeIcons.plug, level: 0.8, category: 'Backend'),
  Skill(name: 'UI / UX', icon: FontAwesomeIcons.penNib, level: 0.8, category: 'Design'),
  Skill(name: 'VS Code', icon: FontAwesomeIcons.code, level: 0.9, category: 'Tools'),
];
