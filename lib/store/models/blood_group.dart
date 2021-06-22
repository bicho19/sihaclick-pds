class BloodGroup {
  final int id;
  final String group;
  final int rhesus;

  BloodGroup({this.id, this.group, this.rhesus});

  factory BloodGroup.fromJson(Map<String, dynamic> json) {
    return BloodGroup(
        id: json["id"] != null ? json['id'] : 0,
        group: json["group"] != null ? json['group'] : "",
        rhesus: json["rhesus"] != null ? json['rhesus'] : 0);
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "id": this.id,
      "group": this.group,
      "rhesus": this.rhesus
    };
  }
}
