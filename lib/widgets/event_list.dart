import 'package:calendar_app/main.dart';
import 'package:calendar_app/model/hive_objects/event.dart';
import 'package:calendar_app/utils/app_colors.dart';
import 'package:calendar_app/utils/assets_path.dart';
import 'package:calendar_app/utils/functions.dart';
import 'package:calendar_app/view/event_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class EventList extends StatelessWidget with Func {
  final DateTime date;
  final bool all;
  final bool filter;
  final String searchWord;
  const EventList({super.key, required this.date, required this.all, required this.filter, required this.searchWord});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<Event>>(
      valueListenable: eventBox.listenable(),
      builder: (context, box, widget) {
        List<Event> events =(all)?box.values.toList():(filter)?searchEvent(searchWord): getEventsByDate(date);
        if (events.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(
                  AssetsPath.emptyState,
                  width: 180.w,
                  height: 180.h,
                ),
                SizedBox(height: 20.h),
                Text(
                  "No events scheduled for this date!",
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  "Tap the + button to add a new event.",
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: AppColors.greyColor,
                  ),
                ),
              ],
            ),
          );
        } else {
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
        }
      },
    );
  }
}
