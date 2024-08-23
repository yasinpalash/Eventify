import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../view/event_details_screen.dart';

class HomeController extends GetxController {
  var daySelected = DateTime.utc(DateTime.now().year, DateTime.now().month, DateTime.now().day).obs;
  var search = false.obs;
  var searchTEController = TextEditingController().obs;
  var viewAll = false.obs;
  var filter = false.obs;
  var focusedDay = DateTime.utc(DateTime.now().year, DateTime.now().month, DateTime.now().day).obs;

  // List of events (for demonstration)
  final Map<DateTime, List<String>> events = {
    DateTime.utc(2023, 8, 20): ['Event 1', 'Event 2'],
    DateTime.utc(2023, 8, 22): ['Event 3'],
    // Add more events as needed
  };

  void toggleSearch() {
    search.value = !search.value;
    viewAll.value = search.value;
    if (!search.value) {
      searchTEController.value.clear();
    }
  }

  void onDaySelected(DateTime selectedDay, DateTime focusDay) {
    daySelected.value = selectedDay;
    focusedDay.value = focusDay;
  }

  void onSearchChanged(String value) {
    viewAll.value = false;
    filter.value = true;
  }

  void onMonthChanged(DateTime focusDay) {
    focusedDay.value = focusDay;
  }

  void navigateToAddEvent(BuildContext context) {
    Navigator.pushNamed(
      context,
      EventDetailsScreen.routeName,
      arguments: EventArguments(
        daySelected: DateTime.utc(daySelected.value.year, daySelected.value.month, daySelected.value.day),
        view: false,
      ),
    );
  }

  bool hasEvents(DateTime day) {
    return events[DateTime.utc(day.year, day.month, day.day)] != null;
  }
}
