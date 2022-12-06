import 'package:flutter/material.dart';
import 'package:list/src/controllers/home.controller.dart';

void main() {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home Page',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const MyHomePage(title: 'Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final controller = HomeController();

  _start() {
    return Container();
  }

  _loading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  _success() {
    return ListView.builder(
      itemCount: controller.todos.length,
      itemBuilder: (context, index) {
        var todo = controller.todos[index];
        return ListTile(
          leading: Checkbox(
            value: todo.completed,
            onChanged: (bool? value) {},
          ),
          title: Text(todo.title),
        );
      },
    );
  }

  _error() {
    return Center(
      child: ElevatedButton(
        onPressed: (() => controller.start()),
        child: const Text('Try again'),
      ),
    );
  }

  managementState(HomeStates state) {
    switch (state) {
      case HomeStates.start:
        return _start();
      case HomeStates.loading:
        return _loading();
      case HomeStates.success:
        return _success();
      case HomeStates.error:
        return _error();
      default:
        return _start();
    }
  }

  @override
  void initState() {
    super.initState();

    controller.start();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
              onPressed: () => controller.start(),
              icon: const Icon(Icons.refresh_outlined)),
        ],
      ),
      body: AnimatedBuilder(
        animation: controller.state,
        builder: (context, child) {
          return managementState(controller.state.value);
        },
      ),
    );
  }
}
