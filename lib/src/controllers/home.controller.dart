import 'package:flutter/material.dart';
import 'package:list/src/models/todo.model.dart';
import 'package:list/src/repositories/todo.repository.dart';

enum HomeStates {
  start,
  loading,
  success,
  error,
}

class HomeController {
  List<TodoModel> todos = [];
  final TodoRepository _repository;
  final state = ValueNotifier<HomeStates>(HomeStates.start);

  HomeController([TodoRepository? repository])
      : _repository = repository ?? TodoRepository();

  Future start() async {
    try {
      state.value = HomeStates.loading;
      todos = await _repository.fetchTodos();
      state.value = HomeStates.success;
    } catch (e) {
      state.value = HomeStates.error;
    }
  }
}
