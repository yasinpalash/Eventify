import 'dart:io';
import 'dart:typed_data';
import 'package:calendar_app/main.dart';
import 'package:calendar_app/model/hive_objects/category.dart';
import 'package:calendar_app/model/hive_objects/event.dart';
import 'package:calendar_app/utils/app_colors.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import '../utils/functions.dart';

class EventDetailsScreen extends StatefulWidget {
  const EventDetailsScreen({super.key});
  static const routeName = "event";

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> with Func {
  final _formKey = GlobalKey<FormState>();
  Category? dropDownValue;
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController eventNameController = TextEditingController();
  final TextEditingController eventDescriptionController =
  TextEditingController();
  Uint8List? imageBytes;
  bool completed = false;
  bool viewed=false;

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as EventArguments;
    if(args.view&&!viewed){
      setState(() {
        dropDownValue=args.event?.category[0];
        eventNameController.text=args.event!.eventName;
        eventDescriptionController.text=args.event!.eventDescription;
        imageBytes =args.event!.file;
        completed =args.event!.completed;
        viewed=true;
      });
    }
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        foregroundColor: AppColors.whiteColor,
        backgroundColor: AppColors.primaryColor,
        title: Text(
          'Event',
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              onPressed:(args.view)? () {
            updateExisitngEvent(args, context);
              }:null, icon: const Icon(Icons.save_as_outlined)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.delete)),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(20.h),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Selected Category",
                  style: TextStyle(color: AppColors.primaryColor),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: ValueListenableBuilder<Box<Category>>(
                            valueListenable: categoryBox.listenable(),
                            builder: (context, box, widget) {
                              return DropdownButton(
                                  focusColor: const Color(0xffffffff),
                                  dropdownColor: const Color(0xffffffff),
                                  isExpanded: true,
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  value: dropDownValue,
                                  items: box.values
                                      .toList()
                                      .map<DropdownMenuItem<Category>>(
                                          (Category value) {
                                        return DropdownMenuItem(
                                            value: value, child: Text(value.name));
                                      }).toList(),
                                  onChanged: (Category? newValue) {
                                    setState(() {
                                      dropDownValue = newValue!;
                                    });
                                  });
                            }),
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: const CircleBorder(),
                              backgroundColor: AppColors.primaryColor,
                              foregroundColor: AppColors.whiteColor),
                          onPressed: () {
                            createNewCategory(context);
                          },
                          child: const Icon(Icons.add))
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20.h, bottom: 20.h),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.calendar_month,
                        color: AppColors.primaryColor,
                      ),
                      Text(
                        DateFormat("EEEE d MMMM").format(args.daySelected),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryColor),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20.h),
                  child: TextFormField(
                    controller: eventNameController,
                    decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: AppColors.primaryColor)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: AppColors.primaryColor)),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.primaryColor),
                        ),
                        labelText: "Enter Event name",
                        labelStyle: TextStyle(color: AppColors.primaryColor)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20.h),
                  child: TextFormField(
                    controller: eventDescriptionController,
                    decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: AppColors.primaryColor)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: AppColors.primaryColor)),
                        border: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: AppColors.primaryColor)),
                        labelText: "Enter Event description",
                        labelStyle: TextStyle(color: AppColors.primaryColor)),
                  ),
                ),
                ListTile(
                  tileColor: AppColors.primaryColor,
                  textColor: AppColors.whiteColor,
                  iconColor: AppColors.whiteColor,
                  title: const Text("Upload file"),
                  trailing: const Icon(Icons.upload),
                  onTap: () async {
                    FilePickerResult? result =
                    await FilePicker.platform.pickFiles();

                    if (result != null) {
                      File file = File(result.files.single.path!);
                      imageBytes = await file.readAsBytes();
                      setState(() {});
                    }
                  },
                ),
                (imageBytes != null)
                    ? Image.memory(
                  imageBytes!,
                  width: 150.h,
                )
                    : const SizedBox.shrink(),
                SwitchListTile(
                    value: completed,
                    title: Text(
                      "Event completed?",
                      style: TextStyle(
                          color: AppColors.primaryColor, fontSize: 14.sp),
                    ),
                    onChanged: (bool? value) {
                      setState(() {
                        completed = value!;
                      });
                    }),
                Padding(
                  padding: EdgeInsets.only(top: 20.h),
                  child: Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                        onPressed: (args.view)?null:() {
                          if (_formKey.currentState!.validate() &&
                              dropDownValue != null) {
                            addEvent(
                                Event(
                                    HiveList(categoryBox),
                                    args.daySelected,
                                    eventNameController.text,
                                    eventDescriptionController.text,
                                    imageBytes ,
                                    completed),
                                dropDownValue!);
                            if (context.mounted) {
                              Navigator.pop(context);
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            foregroundColor: AppColors.whiteColor,
                            backgroundColor: AppColors.primaryColor,
                            shape: const RoundedRectangleBorder(),
                            fixedSize:
                            Size(MediaQuery.of(context).size.width, 50)),
                        child: const Text("Add")),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  createNewCategory(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "New Category",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14.sp,
            ),
          ),
          content: TextFormField(
            decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.primaryColor),
                ),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.primaryColor)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.primaryColor)),
                labelText: "Add Category",
                labelStyle: TextStyle(color: AppColors.primaryColor)),
            controller: categoryController,
          ),
          actions: [
            OutlinedButton(
                style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primaryColor),
                onPressed: () {
                  Get.back();
                },
                child: const Text('Cancel')),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  foregroundColor: AppColors.whiteColor,
                  backgroundColor: AppColors.primaryColor),
              onPressed: () {
                if (categoryController.text.isNotEmpty) {
                  addCategory(Category(categoryController.text));
                  categoryController.clear();
                  Get.back();
                }
              },
              child: const Text("Add"),
            )
          ],
        );
      },
    );
  }
  void updateExisitngEvent(EventArguments args, BuildContext context) {
    args.event?.category = HiveList(categoryBox);
    args.event?.date = args.daySelected;
    args.event?.eventName = eventNameController.text;
    args.event?.eventDescription = eventDescriptionController.text;
    args.event?.file = imageBytes;
    args.event?.completed = completed;
    updateEvent(args.event!, dropDownValue!);
    if (context.mounted) {
      Navigator.pop(context);
    }
  }



}

class EventArguments {
  final DateTime daySelected;
  final Event? event;
  final bool view;
  EventArguments({required this.daySelected, this.event,required this.view});
}

