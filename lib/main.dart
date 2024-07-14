import 'package:calendar_app/model/hive_objects/category.dart';
import 'package:calendar_app/model/hive_objects/event.dart';
import 'package:calendar_app/utils/app_texts.dart';
import 'package:calendar_app/utils/app_theme_data.dart';
import 'package:calendar_app/view/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hive_flutter/hive_flutter.dart';

// Boxes
late Box<Category> categoryBox;
late Box<Event> eventBox;

const String categoryBoxName = "categories";
const String eventBoxName = "events";

void main() async {
  // initializing hive database
  await Hive.initFlutter();
  // register adapter
  Hive.registerAdapter<Category>(CategoryAdapter());
  Hive.registerAdapter<Event>(EventAdapter());

  categoryBox = await Hive.openBox<Category>(categoryBoxName);
  eventBox = await Hive.openBox<Event>(eventBoxName);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: AppTexts.appName,
          theme: AppThemeData.lightThemeData,
          initialRoute: "/",
          routes: {"/": (context) => const HomeScreen()},
        );
      },
    );
  }
}
