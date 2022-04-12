import 'dart:ui';

class Professor {
  final String prof_id;
  final String name;
  final List<List<String>> reviews;

  const Professor({
    required this.prof_id,
    required this.name,
    required this.reviews,
  });
}