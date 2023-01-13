import 'package:flutter/material.dart';
import 'package:flutter_color_picker_wheel/models/button_behaviour.dart';
import 'package:flutter_color_picker_wheel/presets/animation_config_presets.dart';
import 'package:flutter_color_picker_wheel/presets/color_presets.dart';
import 'package:flutter_color_picker_wheel/widgets/flutter_color_picker_wheel.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
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
      .format(DateTime.now().add(const Duration(minutes: 30)))
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
  final List<bool> _selected = List.generate(5, (i) => false);

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
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Date & Time",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
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
                    const SizedBox(
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
                  margin: const EdgeInsets.only(top: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Alerts",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "Add Custom",
                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromRGBO(78, 91, 232, 0.06),
                  ),
                  child: alerttimeselect(),
                ),
                MyButton(
                    height: 50,
                    width: 350,
                    label: "Add more alerts",
                    onTap: () => _validateDate()),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Any Details ?",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
                NoteField(
                  hint: "Enter Notes...",
                  controller: _noteController,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "How often ?",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "Starting : 1/1/22",
                        style: TextStyle(
                          color: primaryClr,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromRGBO(78, 91, 232, 0.06),
                  ),
                  child: const howOften(),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromRGBO(78, 91, 232, 0.06),
                  ),
                  child: const weelSelect(),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _colorPallete(),
                  ],
                ),
                MyButton(
                    height: 50,
                    width: 350,
                    label: "Create Task",
                    onTap: () => _validateDate()),
                const SizedBox(height: 10),
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
          icon: const Icon(Icons.warning_amber_rounded, color: Colors.red));
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
        const SizedBox(
          height: 20,
        ),
        const Text(
          "Pick a color",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black54,
          ),
        ),
        const SizedBox(
          height: 5.0,
        ),
        Row(
          children: [
            const colorRow(),
            InkWell(
              onTap: (() {
                showDialog(
                    context: context,
                    builder: (BuildContext) {
                      return WheelColorPicker(
                        onSelect: (Color newColor) {
                          setState(() {
                            // color = newColor;
                          });
                        },
                        behaviour: ButtonBehaviour.clickToOpen,
                        animationConfig: fanLikeAnimationConfig,
                        colorList: simpleColors,
                        buttonSize: 30,
                        pieceHeight: 20,
                        innerRadius: 20,
                        defaultColor: Colors.red,
                      );
                    });
              }),
              child: Container(
                height: 35,
                width: 35,
                child: const Image(
                  image: AssetImage("assets/coloricon.png"),
                ),
              ),
            )
          ],
        ),
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
        child: const Text(
          "Create New Task",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25),
        ),
      ),
      actions: [
        IconButton(
            icon: const Icon(
              Icons.close,
              color: Colors.black,
              size: 30,
            ),
            onPressed: () {
              Navigator.pop(context, true);
            }),
        const SizedBox(width: 20),
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

class alerttimeselect extends StatefulWidget {
  @override
  _alerttimeselectState createState() => _alerttimeselectState();
}

List<String> alertList = [
  "1m",
  "3m",
  "5m",
  "8m",
  "10m",
];

class _alerttimeselectState extends State<alerttimeselect> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: List.generate(5, (index) {
        return InkWell(
          onTap: () {
            setState(() {
              selectedIndex = index;
            });
          },
          child: Container(
            margin: const EdgeInsets.only(right: 10),
            child: AppButton(
              color: selectedIndex == index ? Colors.white : Colors.black,
              backgroundColor:
                  selectedIndex == index ? primaryClr : Colors.transparent,
              size: 50,
              text: alertList[index],
            ),
          ),
        );
      }),
    );
  }
}

class howOften extends StatefulWidget {
  const howOften({super.key});

  @override
  State<howOften> createState() => _howOftenState();
}

List<String> dayList = [
  "Once",
  "Daily",
  "Weekly",
  "Monthly",
];

class _howOftenState extends State<howOften> {
  int selectedweekIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
          children: List.generate(4, (index) {
            return InkWell(
              onTap: () {
                setState(() {
                  selectedweekIndex = index;
                });
              },
              child: Container(
                margin: const EdgeInsets.only(right: 10),
                child: AppButton(
                  color:
                      selectedweekIndex == index ? Colors.white : Colors.black,
                  backgroundColor: selectedweekIndex == index
                      ? primaryClr
                      : Colors.transparent,
                  size: 67,
                  text: dayList[index],
                ),
              ),
            );
          }),
        ),
        selectedweekIndex == 2
            ? Container(
                margin: const EdgeInsets.only(top: 10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromRGBO(78, 91, 232, 0.06),
                ),
                child: Row(
                  children: [
                    const Text("Every Two Weeks"),
                    const Spacer(),
                    Container(
                      height: 35,
                      width: 50,
                      decoration: const BoxDecoration(
                        color: primaryClr,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                        ),
                      ),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      width: 1,
                    ),
                    Container(
                      height: 35,
                      width: 50,
                      decoration: const BoxDecoration(
                        color: primaryClr,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      child: const Icon(
                        Icons.remove,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              )
            : Container(),
      ],
    );
  }
}

class weelSelect extends StatefulWidget {
  const weelSelect({super.key});

  @override
  State<weelSelect> createState() => _weelSelectState();
}

List<String> weekList = [
  "Sun",
  "Mon",
  "Tue",
  "Wed",
  "Thur",
  "Fri",
  "Sat",
];

class _weelSelectState extends State<weelSelect> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: List.generate(7, (index) {
        return InkWell(
          onTap: () {
            setState(() {
              selectedIndex = index;
            });
          },
          child: Container(
            margin: const EdgeInsets.only(right: 10),
            child: SmallAppButton(
              color: selectedIndex == index ? Colors.white : Colors.black,
              backgroundColor:
                  selectedIndex == index ? primaryClr : Colors.transparent,
              size: 34,
              text: weekList[index],
            ),
          ),
        );
      }),
    );
  }
}

class colorRow extends StatefulWidget {
  const colorRow({super.key});

  @override
  State<colorRow> createState() => _colorRowState();
}

List<Color> colorList = [
  brownClr,
  redClr,
  pinkClr,
  yellowClr,
  greenClr,
  redClr
];

class _colorRowState extends State<colorRow> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: List.generate(6, (index) {
        return InkWell(
          onTap: () {
            setState(() {
              selectedIndex = index;
            });
          },
          child: Container(
            margin: const EdgeInsets.only(right: 10),
            child: selectedIndex == index
                ? UnColorButton(
                    color: colorList[index], backgroundColor: primaryClr)
                : ColorButton(color: colorList[index]),
          ),
        );
      }),
    );
  }
}
