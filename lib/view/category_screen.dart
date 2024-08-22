import 'package:calendar_app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';

import '../main.dart';
import '../model/hive_objects/event.dart';
import '../utils/functions.dart';
import 'event_details_screen.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});
  static const routeName="categoryScreen";
  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> with Func {
  @override
  Widget build(BuildContext context) {
    final args=ModalRoute.of(context)!.settings.arguments as CategoryArgument;
    return  Scaffold(
      appBar: AppBar(
        foregroundColor: AppColors.whiteColor,
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
        title: Text("Category : ${args.category}",style: TextStyle(
            fontWeight: FontWeight.bold,fontSize: 16.sp,color: AppColors.whiteColor
        ),),
      ),
      body:  ValueListenableBuilder<Box<Event>>(
        valueListenable: eventBox.listenable(),
        builder: (context, box, widget) {
          List<Event> events = getByCategory(args.category);

          return Padding(
            padding: EdgeInsets.only(left: 10.h, right: 10.h, top: 20.h),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: events.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, EventDetailsScreen.routeName,
                        arguments: EventArguments(
                            daySelected: events[index].date,
                            view: true,
                            event: events[index]));
                  },
                  child: Card(
                    color: AppColors.whiteColor,
                    child: Container(
                      padding: EdgeInsets.all(20.h),
                      child: IntrinsicHeight(
                        child: Row(
                          children: [
                            Column(
                              children: [
                                Text(
                                  DateFormat.E().format(events[index].date),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  DateFormat.d().format(events[index].date),
                                  style: TextStyle(
                                      fontSize: 20.sp,
                                      color: AppColors.primaryColor),
                                )
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10.h),
                              child: VerticalDivider(
                                color: AppColors.primaryColor,
                                thickness: 2,
                                indent: 10.h,
                                endIndent: 10.h,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(events[index].eventName),
                                  ActionChip.elevated(
                                    label: Text(
                                      events[index].category[0].name,
                                      style: const TextStyle(
                                          color: AppColors.whiteColor),
                                    ),
                                    onPressed: () {
                                    },
                                    backgroundColor: AppColors.primaryColor,
                                    color: const WidgetStatePropertyAll<Color>(
                                        AppColors.primaryColor),
                                  )
                                ],
                              ),
                            ),
                            const Spacer(),
                            const Icon(
                              Icons.keyboard_arrow_right,
                              color: AppColors.primaryColor,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );

        },
      ),
    );
  }
}
class CategoryArgument{
  final String category;

  CategoryArgument({required this.category});


}