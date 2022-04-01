class TodoModel {
  int id;
  int userId;
  String name;

  TodoModel({required this.id, required this.userId, required this.name});

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(id: json['id'], userId: json['user_id'], name: json['name']);
  }
}
