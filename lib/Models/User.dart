class User {
  final String email;
  final String name;
  final String comments;
  final String reg_date;
  final String study_year;
  final String imagePath;

  const User({
    required this.email,
    required this.name,
    required this.comments,
    required this.reg_date,
    required this.study_year,
    required this.imagePath,
  });
}