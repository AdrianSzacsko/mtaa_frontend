
class SearchDB {
  final int? p_id;
  final String name;
  final String code;
  final String id;

  SearchDB(
      { this.p_id,
        required this.name,
        required this.code,
        required this.id,
        });

  SearchDB.fromMap(Map<String, dynamic> res)
      : p_id = res["p_id"],
        name = res["name"].toString(),
        code = res["code"].toString(),
        id = res["id"].toString();

  Map<String, Object?> toMap() {
    return {'p_id':p_id,'name': name, 'code': code, 'id': id};
  }
}