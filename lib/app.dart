import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/binding/binding.dart';
import 'core/route/app_route.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          initialBinding: AppBinding(),
          debugShowCheckedModeBanner: false,
          title: 'To Do Assignment',
          themeMode: ThemeMode.light,
          initialRoute: AppRoute.todo,
          getPages: AppRoute.route,
        );
      },
    );
  }
}
