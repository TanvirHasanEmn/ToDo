
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import '../../feature/todo/presentation/screens/todo_screen.dart';

class AppRoute {
  static const String todo = '/todo';


  static final route = [
    GetPage(
        name: todo,
        page: () => const TodoScreen(),
        transition: Transition.rightToLeft),
  ];
}