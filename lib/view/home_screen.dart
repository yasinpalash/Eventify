import 'package:calendar_app/utils/app_colors.dart';
import 'package:calendar_app/utils/app_texts.dart';
import 'package:calendar_app/view/event_details_screen.dart';
import 'package:calendar_app/widgets/event_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:table_calendar/table_calendar.dart';

import '../main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime daySelected = DateTime.utc(
      DateTime.now().year, DateTime.now().month, DateTime.now().day);
  bool search = false;
  final TextEditingController searchTEController = TextEditingController();
  bool viewAll = false;
  bool filter = false;

  // Function to get a map of events for marking the days on the calendar
  Map<DateTime, List> _getEventMarkers() {
    final events = eventBox.values.toList(); // Get all events
    Map<DateTime, List> eventMarkers = {};

    for (var event in events) {
      DateTime eventDay = DateTime.utc(event.date.year, event.date.month, event.date.day);
      if (eventMarkers[eventDay] == null) {
        eventMarkers[eventDay] = [event];
      } else {
        eventMarkers[eventDay]!.add(event);
      }
    }
    return eventMarkers;
  }

  @override
  Widget build(BuildContext context) {
    final eventMarkers = _getEventMarkers(); // Get markers for events

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: (search)
            ? TextField(
          controller: searchTEController,
          cursorColor: AppColors.whiteColor,
          decoration: InputDecoration(
              hintText: "Search here",
              hintStyle: TextStyle(
                  color: AppColors.whiteColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold)),
          onChanged: (value) {
            setState(() {
              viewAll = false;
              filter = true;
            });
          },
        )
            : Text(
          AppTexts.homeScreenAppBar,
          style: TextStyle(
              fontSize: 16.sp,
              color: AppColors.whiteColor,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
        actions: [
          (search)
              ? IconButton(
            onPressed: () {
              setState(() {
                search = false;
              });
            },
            icon: const Icon(
              Icons.cancel,
              color: AppColors.whiteColor,
            ),
          )
              : IconButton(
            onPressed: () {
              setState(() {
                search = true;
                viewAll = true;
              });
            },
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
            Visibility(
              visible: !search,
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
                    calendarBuilders: CalendarBuilders(
                      defaultBuilder: (context, day, focusedDay) {
                        if (eventMarkers.containsKey(day)) {
                          return Container(
                            margin: const EdgeInsets.all(4.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.red, // Marking the day with events in red
                            ),
                            child: Center(
                              child: Text(
                                '${day.day}',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          );
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 20.w),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.primaryColor),
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            EventDetailsScreen.routeName,
                            arguments: EventArguments(
                              daySelected: DateTime.utc(daySelected.year,
                                  daySelected.month, daySelected.day),
                              view: false,
                            ),
                          );
                        },
                        label: const Text('Add Event'),
                        icon: const Icon(Icons.add),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            EventList(
              date: DateTime.utc(
                  daySelected.year, daySelected.month, daySelected.day),
              all: viewAll,
              filter: filter,
              searchWord: searchTEController.text,
            ),
          ],
        ),
      ),
    );
  }
}
