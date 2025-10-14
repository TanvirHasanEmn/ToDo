import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:file_picker/file_picker.dart';
import '../models/ready_pending_completed_model.dart';

class TodoController extends GetxController {
  Rx<ToDoStatus> selectedStatus = ToDoStatus.ready.obs;
  RxList<ToDoModel> _allTodos = <ToDoModel>[].obs;
  RxBool isLoading = false.obs;

  late final String csvFilePath;

  @override
  void onInit() {
    super.onInit();
    _initPathsAndLoad();
  }

  Future<void> _initPathsAndLoad() async {
    isLoading.value = true;
    try {
      final dir = Directory('/storage/emulated/0/Download');
      csvFilePath = '${dir.path}/todos.csv';
      await loadFromCsv();
    } catch (e) {
      debugPrint('Path init error: $e');
      csvFilePath = 'todos.csv';
      await loadFromCsv();
    } finally {
      isLoading.value = false;
    }
  }

  List<ToDoModel> get currentTodos {
    final status = selectedStatus.value;
    return _allTodos.where((t) => t.status == status).toList();
  }

  void changeStatus(ToDoStatus status) {
    if (selectedStatus.value != status) {
      selectedStatus.value = status;
    }
  }

  Future<void> addTodo(ToDoModel todo) async {
    _allTodos.add(todo);
    await _saveToCsv();
    _refresh();
  }

  Future<void> deleteTodo(String id) async {
    _allTodos.removeWhere((t) => t.id == id);
    await _saveToCsv();
    _refresh();
  }

  Future<void> updateTodoStatus(String id, ToDoStatus newStatus) async {
    final idx = _allTodos.indexWhere((t) => t.id == id);
    if (idx >= 0) {
      final old = _allTodos[idx];
      final updated = ToDoModel(
        id: old.id,
        title: old.title,
        description: old.description,
        createdAt: old.createdAt,
        status: newStatus,
      );
      _allTodos[idx] = updated;
      await _saveToCsv();
      _refresh();
    }
  }

  void _refresh() => _allTodos.refresh();

  Future<void> loadFromCsv() async {
    try {
      final f = File(csvFilePath);
      if (!await f.exists()) {
        _allTodos.value = <ToDoModel>[];
        // create empty file with header
        await f.writeAsString('"id","title","description","created_at","status"\n');
        return;
      }
      final contents = await f.readAsString();
      final lines = const LineSplitter().convert(contents);
      if (lines.isEmpty) {
        _allTodos.value = <ToDoModel>[];
        return;
      }
      final start = (lines.first.toLowerCase().contains('id') && lines.first.toLowerCase().contains('title')) ? 1 : 0;
      final todos = <ToDoModel>[];
      for (var i = start; i < lines.length; i++) {
        final line = lines[i].trim();
        if (line.isEmpty) continue;
        try {
          final t = ToDoModel.fromCsvLine(line);
          todos.add(t);
        } catch (e) {
          debugPrint('Failed parse CSV line $i: $e');
        }
      }
      _allTodos.value = todos;
    } catch (e) {
      debugPrint('Load CSV failed: $e');
      _allTodos.value = <ToDoModel>[];
    }
  }

  Future<void> _saveToCsv() async {
    try {
      final f = File(csvFilePath);
      final lines = <String>[];
      lines.add('"id","title","description","created_at","status"');
      for (final t in _allTodos) {
        lines.add(t.toCsvLine());
      }
      await f.writeAsString(lines.join('\n'));
    } catch (e) {
      debugPrint('Save CSV failed: $e');
    }
  }

  /// Open file picker and import JSON
  Future<void> pickAndImportJson() async {
    try {
      final result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['json']);
      if (result == null || result.files.isEmpty) return;

      final filePath = result.files.single.path;
      if (filePath == null) return;

      final file = File(filePath);
      if (!await file.exists()) {
        Get.snackbar('Error', 'Selected file does not exist');
        return;
      }

      final content = await file.readAsString();
      final parsed = jsonDecode(content);
      final List<dynamic> list = (parsed is List) ? parsed : [parsed];

      final imported = <ToDoModel>[];
      for (final item in list) {
        if (item is Map<String, dynamic>) {
          try {
            final t = ToDoModel.fromJson(item);
            imported.add(t);
          } catch (e) {
            debugPrint('Skip invalid item: $e');
          }
        } else {
          debugPrint('Skip non-object item in JSON');
        }
      }

      if (imported.isEmpty) {
        Get.snackbar('Import', 'No valid todos found in file');
        return;
      }

      // Merge with existing, avoid duplicate ids (if id exists, update it)
      final existingIndexById = {for (var i = 0; i < _allTodos.length; i++) _allTodos[i].id: i};
      for (final t in imported) {
        if (existingIndexById.containsKey(t.id)) {
          // replace
          _allTodos[existingIndexById[t.id]!] = t;
        } else {
          _allTodos.add(t);
        }
      }

      await _saveToCsv();
      _refresh();
      Get.snackbar('Import', 'Imported ${imported.length} todos');
    } catch (e) {
      debugPrint('Import failed: $e');
      Get.snackbar('Error', 'Import failed: $e');
    }
  }
}
