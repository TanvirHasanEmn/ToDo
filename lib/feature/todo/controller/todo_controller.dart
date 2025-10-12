import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../models/ready_pending_completed_model.dart';



class TodoController extends GetxController {
  Rx<ToDoTab> selectedTab = ToDoTab.Ready.obs;

  RxList<ToDoModel> activeBookings = <ToDoModel>[].obs;
  RxList<ToDoModel> completedBookings = <ToDoModel>[].obs;
  RxList<ToDoModel> cancelledBookings = <ToDoModel>[].obs;

  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadInitialData();
  }

  Future<void> loadInitialData() async {
    //await loadBookings(selectedTab.value);
  }

  // Future<void> loadBookings(ToDoTab tab) async {
  //   try {
  //     isLoading.value = true;
  //
  //     switch (tab) {
  //       case ToDoTab.Ready:
  //         await _loadBookingsByStatus('Pending', activeBookings);
  //         break;
  //       case ToDoTab.Completed:
  //         await _loadBookingsByStatus('Complete', completedBookings);
  //         break;
  //       case ToDoTab.Pending:
  //         await _loadBookingsByStatus('Cancel', cancelledBookings);
  //         break;
  //     }
  //   } catch (e) {
  //     if (e is! EmptyResponseException) {
  //       Get.snackbar(
  //         'Error'.tr,
  //         'Failed to load worker bookings: ${e.toString()}',
  //         snackPosition: SnackPosition.BOTTOM,
  //       );
  //     }
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }




  List<ToDoModel> get currentBookings {
    switch (selectedTab.value) {
      case ToDoTab.Ready:
        return activeBookings;
      case ToDoTab.Completed:
        return completedBookings;
      case ToDoTab.Pending:
        return cancelledBookings;
    }
  }

  void changeTab(ToDoTab tab) {
    if (selectedTab.value != tab) {
      selectedTab.value = tab;
      //loadBookings(tab);
    }
  }
}

class EmptyResponseException implements Exception {
  final String message;
  EmptyResponseException(this.message);

  @override
  String toString() => message;
}
