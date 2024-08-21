import 'package:calendar_app/main.dart';
import 'package:calendar_app/model/hive_objects/category.dart';
import 'package:calendar_app/model/hive_objects/event.dart';

mixin Func {
  addEvent(Event event, Category cat) async {
    //Create a new event
    event.category.add(cat);

    await eventBox.add(event);
    event.save();
  }

  //Create new category
  addCategory(Category category) async {
    await categoryBox.add(category);
  }

  //read event
  List<Event> getEventsByDate(DateTime dataTime) {
    return eventBox.values.where((event) => event.date == dataTime).toList();
  }

  updateEvent(Event event, Category cat) async {
    event.category.clear();
    event.category.add(cat);
    await eventBox.put(event.key, event);
    event.save();
  }

  deleteEven(Event event) async {
    await eventBox.delete(event.key);
  }

  List<Event> searchEvent(String searchWord) {
    // Convert searchWord to lowercase for case-insensitive comparison
    String searchWordLower = searchWord.toLowerCase();

    return eventBox.values.where((event) {
      // Convert event fields to lowercase for comparison
      String eventNameLower = event.eventName.toLowerCase();
      String eventDescriptionLower = event.eventDescription.toLowerCase();
      String categoryLower = event.category[0].name.toLowerCase();

      // Check if any of the fields contain the search word
      return eventNameLower.contains(searchWordLower) ||
          eventDescriptionLower.contains(searchWordLower) ||
          categoryLower.contains(searchWordLower);
    }).toList();
  }



  List<Event> getByCategory(String category) {
    return eventBox.values
        .where((event) => event.category[0].name.contains(category))
        .toList();
  }
}
