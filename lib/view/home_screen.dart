import 'package:calendar_app/utils/app_colors.dart';
import 'package:calendar_app/utils/app_texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Text(
          AppTexts.homeScreenAppBar,
          style: TextStyle(
              fontSize: 16.sp,
              color: AppColors.whiteColor,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              color: AppColors.whiteColor,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          
        ],),
      ),
    );
  }
}
