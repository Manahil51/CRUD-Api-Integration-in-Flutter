import 'package:curd_practice/model/post_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const baseUrl =
    "https://crudcrud.com/api/5181f740d17c4801833ce31df4bf787a/tasks";

Future<List<TaskModel>> getTaskApi() async {
  List<TaskModel> taskData = [];
  var url = Uri.parse(baseUrl);
  var response = await http.get(url);

  if (response.statusCode == 200) {
    var responseBody = jsonDecode(response.body);
    for (var eachMap in responseBody) {
      taskData.add(TaskModel.fromJson(eachMap));
    }
  }
  return taskData;
}

postTaskApi() async {
  var url = Uri.parse(baseUrl);
  var response = await http.post(
    url,
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({
      "title": "Second project",
      "body": "2nd Flutter Project",
    }),
  );
  print(response);
}

updateTaskApi(String id) async {
  var url = Uri.parse("$baseUrl/$id");
  var response = await http.put(
    url,
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({
      "title": "update Second project",
      "body": "update 2nd Flutter Project",
    }),
  );
  print(response);
}

deleteTaskApi(String id) async {
  var url = Uri.parse("$baseUrl/$id");
  var response = await http.delete(url);
  print(response);
}
