
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import '../../feature/todo/presentation/screens/create_todo.dart';
import '../../feature/todo/presentation/screens/todo_main_screen.dart';

class AppRoute {
  static const String todo = '/todo';
  static const String create = '/create';


  static final route = [
    GetPage(name: todo, page: () => const TodoScreen(), transition: Transition.rightToLeft),
    GetPage(name: create, page: () => CreateTodo(), transition: Transition.rightToLeft),
  ];
}