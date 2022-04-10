import 'dart:ui';

class Subject {
  final String name;
  final List<String> professors;
  final List<List<String>> reviews;

  const Subject({
    required this.name,
    required this.professors,
    required this.reviews,
  });
}