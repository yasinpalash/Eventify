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
    return eventBox.values
        .where((event) =>
            event.eventName.contains(searchWord) ||
            event.eventDescription.contains(searchWord) ||
            event.category[0].name.contains(searchWord))
        .toList();
  }

  List<Event> getByCategory(String category) {
    return eventBox.values
        .where((event) => event.category[0].name.contains(category))
        .toList();
  }
}
