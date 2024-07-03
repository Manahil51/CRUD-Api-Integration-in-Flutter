class TaskModel {
  String? sId;
  String? title;
  String? body;

  TaskModel({this.sId, this.title, this.body});

  TaskModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    body = json['body'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['title'] = title;
    data['body'] = body;
    return data;
  }
}
