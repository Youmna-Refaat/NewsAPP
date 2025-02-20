class SourceDataModel {
  final String id;
  final String name;
  SourceDataModel({required this.id, required this.name});
  factory SourceDataModel.fromJson(Map<String, dynamic> json) =>
      SourceDataModel(id: json["id"], name: json["name"]);
}
