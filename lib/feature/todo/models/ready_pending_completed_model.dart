import 'package:flutter/cupertino.dart';

/// Enum for status
enum ToDoStatus { ready, pending, completed }

/// Model representing a todo entry with csv/json helpers
class ToDoModel {
  final String id; // string id (we'll use timestamp string by default)
  final String title;
  final String description;
  final int createdAt; // unix milliseconds
  final ToDoStatus status;

  ToDoModel({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.status,
  });

  // readable date helper
  String get readableDate {
    final dt = DateTime.fromMillisecondsSinceEpoch(createdAt);
    return '${dt.year}-${_two(dt.month)}-${_two(dt.day)} ${_two(dt.hour)}:${_two(dt.minute)}';
  }

  String _two(int n) => n.toString().padLeft(2, '0');

  /// Convert to CSV row (fields will be quoted and internal quotes doubled)
  String toCsvLine() {
    String q(String value) {
      final escaped = value.replaceAll('"', '""');
      return '"$escaped"';
    }

    return [q(id), q(title), q(description), q(createdAt.toString()), q(status.name)].join(',');
  }

  /// Parse CSV line into model
  factory ToDoModel.fromCsvLine(String line) {
    final fields = _parseCsvLine(line);
    try {
      return ToDoModel(
        id: fields[0],
        title: fields[1],
        description: fields[2],
        createdAt: int.tryParse(fields[3]) ?? DateTime.now().millisecondsSinceEpoch,
        status: _statusFromString(fields[4]),
      );
    } catch (e) {
      debugPrint('CSV parse error: $e');
      return ToDoModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: 'Parsing error',
        description: '',
        createdAt: DateTime.now().millisecondsSinceEpoch,
        status: ToDoStatus.pending,
      );
    }
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'created_at': createdAt,
    'status': status.name,
  };

  /// From JSON (expects keys: id, title, description, created_at, status)
  factory ToDoModel.fromJson(Map<String, dynamic> json) {
    return ToDoModel(
      id: (json['id'] ?? DateTime.now().millisecondsSinceEpoch).toString(),
      title: (json['title'] ?? '').toString(),
      description: (json['description'] ?? '').toString(),
      createdAt: (json['created_at'] is int)
          ? json['created_at']
          : int.tryParse(json['created_at']?.toString() ?? '') ?? DateTime.now().millisecondsSinceEpoch,
      status: _statusFromString((json['status'] ?? 'pending').toString()),
    );
  }

  static ToDoStatus _statusFromString(String s) {
    s = s.toLowerCase();
    if (s == 'ready') return ToDoStatus.ready;
    if (s == 'completed') return ToDoStatus.completed;
    return ToDoStatus.pending;
  }

  /// Simple CSV parser for a single line (supports quoted fields and doubled quotes)
  static List<String> _parseCsvLine(String line) {
    final List<String> result = [];
    final sb = StringBuffer();
    bool inQuotes = false;
    for (int i = 0; i < line.length; i++) {
      final ch = line[i];
      if (inQuotes) {
        if (ch == '"') {
          // check for doubled quote
          if (i + 1 < line.length && line[i + 1] == '"') {
            sb.write('"');
            i++;
          } else {
            inQuotes = false;
          }
        } else {
          sb.write(ch);
        }
      } else {
        if (ch == '"') {
          inQuotes = true;
        } else if (ch == ',') {
          result.add(sb.toString());
          sb.clear();
        } else {
          sb.write(ch);
        }
      }
    }
    result.add(sb.toString());
    return result;
  }
}
