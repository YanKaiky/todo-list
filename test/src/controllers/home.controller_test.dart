import 'package:flutter_test/flutter_test.dart';
import 'package:list/src/controllers/home.controller.dart';
import 'package:list/src/models/todo.model.dart';
import 'package:list/src/repositories/todo.repository.dart';
import 'package:mockito/mockito.dart';

class TodoRepositoryMock extends Mock implements TodoRepository {}

main() {
  final repository = TodoRepositoryMock();
  final controller = HomeController(repository);

  test('List Todos', () async {
    when(repository.fetchTodos()).thenAnswer((_) async => [TodoModel()]);

    await controller.start();

    expect(controller.todos.isEmpty, true);
  });
}
