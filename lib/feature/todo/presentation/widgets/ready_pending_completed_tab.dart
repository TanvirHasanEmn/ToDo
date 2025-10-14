import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/utility/app_colors.dart';
import '../../models/ready_pending_completed_model.dart';

class TabCard extends StatelessWidget {
  final ToDoModel todo;
  final VoidCallback onDelete;
  final ValueChanged<ToDoStatus> onChangeStatus;

  const TabCard({
    super.key,
    required this.todo,
    required this.onDelete,
    required this.onChangeStatus,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: Row(
        children: [
          // Placeholder circle avatar (no network image dependency)
          Container(
            width: 56.w,
            height: 56.h,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Center(
              child: Text(
                todo.title.isNotEmpty ? todo.title[0].toUpperCase() : '?',
                style: GoogleFonts.inter(fontSize: 20.sp, fontWeight: FontWeight.w600),
              ),
            ),
          ),

          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(todo.title, style: GoogleFonts.inter(fontSize: 14.sp, fontWeight: FontWeight.w600, color: Colors.black)),
                SizedBox(height: 4.h),
                Text(
                  todo.description,
                  style: GoogleFonts.inter(fontSize: 12.sp, fontWeight: FontWeight.w400, color: Colors.grey.shade700),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Icon(Icons.calendar_today_outlined, size: 14.sp, color: Colors.grey.shade600),
                    SizedBox(width: 4.w),
                    Text(todo.readableDate, style: GoogleFonts.inter(fontSize: 12.sp, color: Colors.grey.shade700)),
                    SizedBox(width: 12.w),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: _statusColor(todo.status).withOpacity(0.12),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Text(
                        todo.status.name.capitalize!,
                        style: GoogleFonts.inter(fontSize: 12.sp, color: _statusColor(todo.status), fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),

          // Actions
          Column(
            children: [
              PopupMenuButton<String>(
                itemBuilder: (ctx) => [
                  PopupMenuItem(value: 'ready', child: Text('Mark Ready')),
                  PopupMenuItem(value: 'pending', child: Text('Mark Pending')),
                  PopupMenuItem(value: 'completed', child: Text('Mark Completed')),
                  PopupMenuItem(value: 'delete', child: Text('Delete', style: TextStyle(color: Colors.red))),
                ],
                onSelected: (value) {
                  if (value == 'delete') {
                    onDelete();
                  } else {
                    final newStatus = ToDoStatus.values.firstWhere((e) => e.name == value);
                    onChangeStatus(newStatus);
                  }
                },
                child: Icon(Icons.more_vert),
              ),
              SizedBox(height: 4.h),
              //Text(todo.id.toString(), style: GoogleFonts.inter(fontSize: 10.sp, color: Colors.grey.shade500)),
            ],
          ),
        ],
      ),
    );
  }

  Color _statusColor(ToDoStatus status) {
    switch (status) {
      case ToDoStatus.ready:
        return AppColor.ready;
      case ToDoStatus.pending:
        return AppColor.pending;
      case ToDoStatus.completed:
        return AppColor.primaryColor;
    }
  }
}
