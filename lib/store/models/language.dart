class Language {
  /*
      {
        "id": 1,
        "name": "arabe"
    },
   */
  final int id;
  final String name;

  Language({this.id, this.name});

  factory Language.fromJson(Map<String, dynamic> data) {
    return Language(
      id: data['id'],
      name: data['name'],
    );
  }

  @override
  String toString() {
    return "Language : $id => $name";
  }
}
