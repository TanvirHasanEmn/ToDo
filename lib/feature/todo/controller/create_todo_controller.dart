
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CreateServiceController extends GetxController {

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final serviceNameController = TextEditingController();
  final servicePriceController = TextEditingController();
  final descriptionController = TextEditingController();
  final locationController = TextEditingController();
  final postalcodeController = TextEditingController();

  RxString selectedCategory = ''.obs;

  final List<String> categories = [
    'Electricista',
    'Plomería',
    'Cuadro',
    'Carpinteros',
    'AC Reparar'
  ];

  Rx<File?> uploadedFile = Rx<File?>(null);
  RxString selectedFileName = ''.obs;


  void submitService() async {
    if (!formKey.currentState!.validate()) return;
    if (uploadedFile.value == null) {
      Get.snackbar("Error", "Please upload an image");
      return;
    }

    final Map<String, dynamic> bodyData = {
      "title": serviceNameController.text.trim(),
      "category": selectedCategory.value,
      "price": int.tryParse(servicePriceController.text.trim()) ?? 0,
      "description": descriptionController.text.trim(),
      // "location": locationController.text.trim(),
      "postcode": postalcodeController.text.trim(),
      // or add a TextEditingController for it if needed
    };
  }

}