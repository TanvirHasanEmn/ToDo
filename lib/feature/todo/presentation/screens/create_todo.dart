import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/global_widget/custom_button.dart';
import '../../../../core/utility/app_colors.dart';
import '../../controller/create_todo_controller.dart';

class CreateTodo extends StatelessWidget {
  final CreateServiceController controller = Get.put(CreateServiceController());

  CreateTodo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 50.h),
              Row(
                children: [
                  InkWell(onTap: () => Get.back(), child: Icon(Icons.arrow_back, color: Colors.black)),
                  SizedBox(width: 75.w),
                  Text(
                    "Create ToDo",
                    style: GoogleFonts.inter(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),

              /// Title
              labelText("Title"),
              textField(controller.serviceNameController, "Enter To Do Title"),
              SizedBox(height: 20.h),

              /// Description
              labelText("Description"),
              textField(controller.descriptionController, "Description", maxLines: 5),
              SizedBox(height: 20.h),

              SizedBox(height: 8.h),
              Text(
                'Status',
                style: GoogleFonts.inter(fontSize: 14.sp, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 8.h),
              Obx(
                    () => Row(
                  children: CreateServiceController.statusOptions.map((s) {
                    final isSelected = controller.selectedStatus.value == s;
                    return GestureDetector(
                      onTap: () => controller.selectedStatus.value = s,
                      child: Container(
                        margin: EdgeInsets.only(right: 8.w),
                        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                        decoration: BoxDecoration(
                          color: isSelected ? AppColor.primaryColor : Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Text(
                          s.name.capitalize!,
                          style: GoogleFonts.inter(
                            color: isSelected ? Colors.white : Colors.black87,
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),

              SizedBox(height: 32.h),
              CustomButton(
                text: "Create",
                onPressed: () async {
                  await controller.submitService();
                  // go back after creation
                  Get.back();
                },
              ),
              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget labelText(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6.h),
      child: Text(text, style: GoogleFonts.inter(fontSize: 14.sp, fontWeight: FontWeight.w500)),
    );
  }

  Widget textField(TextEditingController controller, String hint, {int maxLines = 1, TextInputType keyboardType = TextInputType.text}) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      validator: (value) => value!.isEmpty ? "Field required" : null,
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.r), borderSide: BorderSide(color: Colors.grey.shade300)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20.r), borderSide: BorderSide(color: AppColor.primaryColor)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20.r), borderSide: BorderSide(color: Colors.grey.shade200)),
      ),
    );
  }
}
