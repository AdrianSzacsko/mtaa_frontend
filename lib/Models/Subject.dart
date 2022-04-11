import 'dart:ui';

class Subject {
  final String subj_id;
  final String name;
  final List<String> professors;
  final List<List<String>> reviews;

  const Subject({
    required this.subj_id,
    required this.name,
    required this.professors,
    required this.reviews,
  });
}