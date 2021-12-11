class TodoModel {
  int id;
  String name;

  TodoModel({required this.id, required this.name});

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(id: json['id'], name: json['name']);
  }
}
