import 'dart:io';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../models/ready_pending_completed_model.dart';
import 'todo_controller.dart';

class CreateServiceController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final serviceNameController = TextEditingController();
  final descriptionController = TextEditingController();

  static final statusOptions = ToDoStatus.values;
  Rx<ToDoStatus> selectedStatus = ToDoStatus.pending.obs;

  /// Submit a new todo
  Future<void> submitService() async {
    if (!formKey.currentState!.validate()) return;

    final title = serviceNameController.text.trim();
    final desc = descriptionController.text.trim();

    final id = DateTime.now().millisecondsSinceEpoch.toString();
    final createdAt = DateTime.now().millisecondsSinceEpoch;

    final todo = ToDoModel(
      id: id,
      title: title,
      description: desc,
      createdAt: createdAt,
      status: selectedStatus.value,
    );

    // Add to main TodoController
    final todoController = Get.find<TodoController>();
    await todoController.addTodo(todo);

    // clear
    serviceNameController.clear();
    descriptionController.clear();
    selectedStatus.value = ToDoStatus.pending;
  }
}
