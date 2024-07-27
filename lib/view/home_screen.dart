import 'package:calendar_app/utils/app_colors.dart';
import 'package:calendar_app/utils/app_texts.dart';
import 'package:calendar_app/view/event_details_screen.dart';
import 'package:calendar_app/widgets/event_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:table_calendar/table_calendar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime daySelected = DateTime.utc(
      DateTime.now().year, DateTime.now().month, DateTime.now().day);
  bool viewAll = false;
  bool filter = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
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
        child: Column(
          children: [
            TableCalendar(
              firstDay: DateTime.utc(2023, 1, 1),
              lastDay: DateTime.utc(2030, 1, 1),
              focusedDay: daySelected,
              currentDay: daySelected,
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  daySelected = selectedDay;
                });
              },
              calendarStyle: const CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: Colors.deepOrange,
                  shape: BoxShape.circle,
                ),
                holidayTextStyle: TextStyle(
                  color: Colors.green,
                ),
                outsideDaysVisible: false,
              ),
              headerStyle: const HeaderStyle(
                formatButtonVisible: true,
                titleCentered: true,
                titleTextStyle: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
                leftChevronIcon: Icon(
                  Icons.chevron_left,
                  color: AppColors.primaryColor,
                ),
                rightChevronIcon: Icon(
                  Icons.chevron_right,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 20.w),
              child: Align(
                alignment: Alignment.bottomRight,
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primaryColor
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, EventDetailsScreen.routeName,
                        arguments: EventArguments(daySelected: DateTime.utc(

                            daySelected.year, daySelected.month, daySelected.day
                        )));
                  },
                  label: const Text('Add Event'),
                  icon: const Icon(Icons.add),
                ),
              ),
            ),
            EventList(
              date: DateTime.utc(
                  daySelected.year, daySelected.month, daySelected.day),
            ),
          ],
        ),
      ),
    );
  }
}
