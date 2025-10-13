import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_assignment/core/global_widget/custom_button_small.dart';
import '../../../../core/route/app_route.dart';
import '../../../../core/utility/app_colors.dart';
import '../../controller/todo_controller.dart';
import '../../models/ready_pending_completed_model.dart';
import '../widgets/ready_pending_completed_tab.dart';

class TodoScreen extends StatelessWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TodoController());

    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 40.h),
            Center(
              child: Text(
                "To Do",
                style: GoogleFonts.inter(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),

            // Top white container with buttons
            SizedBox(height: 12.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24.r),
                  topRight: Radius.circular(24.r),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(height: 4.h),

                  // Upload + Create
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomButtonSmall(
                        text: "Upload json",
                        onTap: () async {
                          // Open a dialog to paste JSON or enter file path
                          controller.pickAndImportJson();
                        },
                      ),
                      SizedBox(width: 16.w),
                      CustomButtonSmall(
                        text: "Create ToDo",
                        onTap: () async {
                          // navigate to create screen
                          Get.toNamed(AppRoute.create);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Tabs
            Obx(
                  () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: ToDoStatus.values.map((tab) {
                  final isSelected = controller.selectedStatus.value == tab;
                  return GestureDetector(
                    onTap: () => controller.changeStatus(tab),
                    child: Container(
                      width: MediaQuery.of(context).size.width / 3.5,
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: 2,
                            color: isSelected ? AppColor.primaryColor : Colors.transparent,
                          ),
                        ),
                      ),
                      child: Text(
                        tab.name.capitalize! ,
                        style: GoogleFonts.inter(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: isSelected ? AppColor.primaryColor : Colors.black54,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

            SizedBox(height: 10.h),
            Text(
              "My Todos",
              style: GoogleFonts.inter(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),

            // List
            Expanded(
              child: Obx(() {
                final items = controller.currentTodos;
                if (items.isEmpty) {
                  return Center(
                    child: Text(
                      "No ToDo's found",
                      style: GoogleFonts.inter(fontSize: 14.sp),
                    ),
                  );
                }
                return ListView.separated(
                  padding: EdgeInsets.only(top: 8.h, bottom: 20.h),
                  itemCount: items.length,
                  separatorBuilder: (_, __) => SizedBox(height: 12.h),
                  itemBuilder: (_, index) {
                    final todo = items[index];
                    return TabCard(
                      todo: todo,
                      onDelete: () => controller.deleteTodo(todo.id),
                      onChangeStatus: (newStatus) => controller.updateTodoStatus(todo.id, newStatus),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
