class Structure {
  final int id;
  final String name;

  Structure({this.id, this.name});

  factory Structure.fromJson({Map<String, dynamic> data}) {
    return Structure(
      id: data['id'] ?? 0,
      name: data['name'] ?? "No name",
    );
  }

// {
// "id": 1,
// "name": "Cabinet privé"
// },

}
