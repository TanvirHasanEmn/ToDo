import 'package:flutter/cupertino.dart';

enum ToDoTab { Ready, Completed, Pending }

class ToDoModel {
  final String image;
  final String title;
  final String date;
  final String price;
  final String? canceldate;
  final String time;
  final String? reason;
  final String address;

  ToDoModel({
    required this.image,
    required this.title,
    required this.date,
    required this.price,
    required this.time,
    required this.address,
    this.canceldate,
    this.reason,

  });

  factory ToDoModel.fromJson(Map<String, dynamic> json) {
    try {
      final service = json['service'] ?? {};
      final String rawDate = json['date'] ?? '';
      final String? cancelledAt = json['cancelledAt'];
      String? cancelDateFormatted;
      if (cancelledAt != null) {
        final DateTime cancelledDate = DateTime.tryParse(cancelledAt) ?? DateTime.now();
      }

      return ToDoModel(
        image: service['image'] ?? '',
        title: service['title'] ?? 'Unknown Title',
        date: "",
        price: '\$${service['price'] ?? '0'}',
        time: json['time'] ?? 'N/A',
        address: service['user']?['address'] ?? 'No address',
        canceldate: cancelDateFormatted,
        reason: json['cancelReason'],
      );
    } catch (e) {
      debugPrint('❌ Worker booking parsing error: $e');
      return ToDoModel(
        image: '',
        title: 'Error loading service',
        date: 'Error',
        time: 'N/A',
        address: '',
        price: '\$0',
      );
    }
  }
}