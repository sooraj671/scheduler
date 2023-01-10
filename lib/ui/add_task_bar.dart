import 'package:flutter/material.dart';
import 'package:flutter_color_picker_wheel/models/button_behaviour.dart';
import 'package:flutter_color_picker_wheel/presets/animation_config_presets.dart';
import 'package:flutter_color_picker_wheel/presets/color_presets.dart';
import 'package:flutter_color_picker_wheel/widgets/flutter_color_picker_wheel.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:scheduler/controllers/task_controller.dart';
import 'package:scheduler/ui/theme.dart';
import 'package:scheduler/ui/widgets/button.dart';
import 'package:scheduler/ui/widgets/input_field.dart';
import 'package:scheduler/ui/widgets/input_notes.dart';

import '../models/task.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TaskController _taskController = Get.put(TaskController());
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  List<bool> _list = [true, false, false, false, false];

  DateTime _selectedDate = DateTime.now();
  String endTime = DateFormat("hh:mm a")
      .format(DateTime.now().add(Duration(minutes: 30)))
      .toString();
  String startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  int _selectedRemind = 5;
  List<int> remindList = [
    5,
    10,
    15,
    20,
    30,
    45,
    60,
  ];
  String _selectedRepeat = "None";
  List<String> repeatList = ["Once", "Daily", "Weekly", "Monthly"];

  List<String> alertList = [
    "1m",
    "3m",
    "5m",
    "8m",
    "10m",
  ];
  int _selectedColor = 0;

  // String _selectedRepeat = "None";
  List<String> dayList = [
    "Sun",
    "Mon",
    "Tue",
    "Wed",
    "Thur",
    "Fri",
    "Sat",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: context.theme.bottomAppBarColor,
        appBar: _appBar(
          context,
        ),
        body: Container(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyInputField(
                  title: "Title",
                  hint: "Enter your title",
                  controller: _titleController,
                ),
                Text("Date & Time"),
                MyInputField(
                  title: "Select Date",
                  hint: DateFormat.yMd().format(_selectedDate),
                  widget: IconButton(
                    icon: const Icon(Icons.calendar_today_outlined,
                        color: Colors.black),
                    onPressed: () {
                      _getDateFromUser();
                    },
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: MyInputField(
                        title: "Start",
                        hint: startTime,
                        widget: IconButton(
                          color: Colors.black,
                          onPressed: () {
                            _getTimeFromUser(isStartTime: true);
                          },
                          icon: const Icon(
                            Icons.access_time_rounded,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: MyInputField(
                        title: "End",
                        hint: endTime,
                        widget: IconButton(
                          onPressed: () {
                            _getTimeFromUser(isStartTime: false);
                          },
                          icon: const Icon(
                            Icons.access_time_rounded,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Alerts",
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      Text("Add Custom")
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromRGBO(78, 91, 232, 0.06),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      return Container(
                          width: 55,
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 13),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5)),
                          margin: EdgeInsets.only(right: 10),
                          child: Text(
                            alertList[index],
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.grey),
                          ));
                    }),
                  ),
                ),
                MyButton(
                    height: 50,
                    width: 350,
                    label: "Add more alerts",
                    onTap: () => _validateDate()),
                NoteField(
                  hint: "Enter Notes...",
                  controller: _noteController,
                ),
                Container(
                  margin: EdgeInsets.only(top: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "How Often?",
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      Text(
                        "Starting: 1/1/22",
                        style: TextStyle(color: Colors.blue[800]),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromRGBO(78, 91, 232, 0.06),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(4, (index) {
                      return Container(
                          width: 70,
                          padding:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 13),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          margin: EdgeInsets.only(right: 10),
                          child: Text(
                            repeatList[index],
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.grey),
                          ));
                    }),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromRGBO(78, 91, 232, 0.06),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      return Container(
                          width: 50,
                          padding:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 13),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          margin: EdgeInsets.only(right: 10),
                          child: Text(
                            dayList[index],
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.grey),
                          ));
                    }),
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _colorPallete(),
                  ],
                ),
                WheelColorPicker(
                  onSelect: (Color newColor) {
                    setState(() {
                      // color = newColor;
                    });
                  },
                  behaviour: ButtonBehaviour.clickToOpen,
                  animationConfig: fanLikeAnimationConfig,
                  colorList: simpleColors,
                  buttonSize: 40,
                  pieceHeight: 25,
                  innerRadius: 100,
                  defaultColor: Colors.red,
                ),
                MyButton(
                    height: 50,
                    width: 350,
                    label: "Create Task",
                    onTap: () => _validateDate())
              ],
            ),
          ),
        ));
  }

  _validateDate() {
    if (_titleController.text.isNotEmpty && _noteController.text.isNotEmpty) {
      _addTaskToDb();
      Get.back();
    } else if (_titleController.text.isEmpty || _noteController.text.isEmpty) {
      Get.snackbar("Error", "All fields are required !",
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.only(
            bottom: 10,
          ),
          backgroundColor: Colors.white,
          colorText: pinkClr,
          icon: Icon(Icons.warning_amber_rounded, color: Colors.red));
    }
  }

  _addTaskToDb() async {
    int value = await _taskController.addTask(
        task: Task(
      note: _noteController.text,
      title: _titleController.text,
      date: DateFormat.yMd().format(_selectedDate),
      startTime: startTime,
      endTime: endTime,
      remind: _selectedRemind,
      repeat: _selectedRepeat,
      color: _selectedColor,
      isCompleted: 0,
    ));
    print("My id is " + "$value");
  }

  _colorPallete() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Pick a Color",
          style: titleStyle,
        ),
        SizedBox(
          height: 8.0,
        ),
        Wrap(
          children: List<Widget>.generate(9, (int index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedColor = (index);
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 5, left: 5.0, right: 5.0),
                child: CircleAvatar(
                  radius: 14,
                  backgroundColor: index == 0
                      ? bluishClr
                      : index == 1
                          ? redClr
                          : index == 2
                              ? pinkClr
                              : index == 3
                                  ? yellowClr
                                  : index == 4
                                      ? greenClr
                                      : index == 5
                                          ? orangeClr
                                          : index == 6
                                              ? brownClr
                                              : index == 7
                                                  ? purpleClr
                                                  : blackClr,
                  child: _selectedColor == index
                      ? Icon(Icons.done, color: Colors.white, size: 16)
                      : Container(),
                ),
              ),
            );
          }),
        )
      ],
    );
  }

  _appBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      centerTitle: false,
      titleSpacing: 0.0,
      title: Transform(
        // you can forcefully translate values left side using Transform
        transform: Matrix4.translationValues(-35.0, 4.0, 0.0),
        child: Text(
          "Create New Task",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25),
        ),
      ),
      actions: [
        IconButton(
            icon: Icon(
              Icons.close,
              color: Colors.black,
              size: 30,
            ),
            onPressed: () {
              Navigator.pop(context, true);
            }),
        SizedBox(width: 20),
      ],
    );
  }

  _getDateFromUser() async {
    DateTime? _pickerDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015),
        lastDate: DateTime(2222));

    if (_pickerDate != null) {
      setState(() {
        _selectedDate = _pickerDate;
        print(_selectedDate);
      });
    } else {
      print("It's null or something is wrong");
    }
  }

  _getTimeFromUser({required bool isStartTime}) async {
    var pickedTime = await _showTimePicker();
    String _formatedTime = pickedTime.format(context);
    if (pickedTime == null) {
      print("Time Canceled");
    } else if (isStartTime == true) {
      setState(() {
        startTime = _formatedTime;
      });
    } else if (isStartTime == false) {
      setState(() {
        endTime = _formatedTime;
      });
    }
  }

  _showTimePicker() {
    return showTimePicker(
        initialEntryMode: TimePickerEntryMode.input,
        context: context,
        initialTime: TimeOfDay(
          //_startTime --> 10:30 AM
          hour: int.parse(startTime.split(":")[0]),
          minute: int.parse(startTime.split(":")[1].split(" ")[0]),
        ));
  }

  row(
      {required MainAxisAlignment mainAxisAlignment,
      required CrossAxisAlignment crossAxisAlignment,
      required List<MyButton> children}) {}
}
