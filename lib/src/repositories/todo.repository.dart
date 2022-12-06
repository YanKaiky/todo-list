import 'package:dio/dio.dart';
import 'package:list/src/models/todo.model.dart';

class TodoRepository {
  late Dio dio;
  final url = 'https://jsonplaceholder.typicode.com/todos';

  TodoRepository([Dio? client]) : dio = client ?? Dio();

  Future<List<TodoModel>> fetchTodos() async {
    final response = await dio.get(url);

    final list = response.data as List;

    final todos = list.map((data) => TodoModel.fromJson(data)).toList();

    return todos;
  }
}
