import 'package:flutter/material.dart';
import 'package:flutter_color_picker_wheel/models/button_behaviour.dart';
import 'package:flutter_color_picker_wheel/presets/animation_config_presets.dart';
import 'package:flutter_color_picker_wheel/presets/color_presets.dart';
import 'package:flutter_color_picker_wheel/widgets/flutter_color_picker_wheel.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:scheduler/controllers/task_controller.dart';
import 'package:scheduler/services/notification_services.dart';
import 'package:scheduler/ui/theme.dart';
import 'package:scheduler/ui/widgets/button.dart';
import 'package:scheduler/ui/widgets/input_field.dart';
import 'package:number_to_words/number_to_words.dart';
import 'package:scheduler/ui/widgets/input_notes.dart';
import '../models/task.dart';
import 'package:datetime_picker_formfield_new/datetime_picker_formfield_new.dart';

var selectedcustime;
int alertbefore = 0;
DateTime dateselected = DateTime.now();
late Color selectedCol;
Color addtaskcol = primaryClr;
int selectedcolIndex = -1;
int customcolor = 0;
int selectedalertIndex = -1;
int _selectedColor = 0;
String _selectedRepeat = "None";
List<int> selectedweek = [];

List<String> repeatList = [
  "None",
  "Daily",
  "Weekly",
  "Monthly",
  "Yearly",
];
List<String> weelcheck = [];
List<int> alertList = [1, 3, 5, 8];
List<int> multiplealertList = [];
int monday = 0;
int tuesday = 0;
int wednesday = 0;
int thursday = 0;
int friday = 0;
int saturday = 0;
int sunday = 0;

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  DateTime selectedDate = DateTime.now();

  DateTime fullDate = DateTime.now();
  final NotificationService _notificationService = NotificationService();
  final TaskController _taskController = Get.put(TaskController());
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  // TimeOfDay _startTime = TimeOfDay(
  //     hour: int.parse(s.split(":")[0]), minute: int.parse(s.split(":")[1]));

  DateTime _selectedDate = DateTime.now();
  get selectedDates {
    return DateFormat.yMMMd().format(_selectedDate);
  }

  final myController = TextEditingController();

  String endTime = DateFormat("hh:mm a")
      .format(DateTime.now().add(const Duration(minutes: 30)))
      .toString();
  String startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  int _selectedRemind = 5;
  TimeOfDay stringToTimeOfDay(String tod) {
    final format = DateFormat.jm();
    return TimeOfDay.fromDateTime(format.parse(tod));
  }

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
                Text(
                  "Date & Time",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Get.isDarkMode ? Colors.white : Colors.black54,
                  ),
                ),
                MyInputField(
                  title: "Select Date",
                  hint: DateFormat.yMd().format(_selectedDate),
                  widget: IconButton(
                    icon: Icon(Icons.calendar_today_outlined,
                        color: Get.isDarkMode ? Colors.white : Colors.black),
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
                          color: Get.isDarkMode ? Colors.white : Colors.black,
                          onPressed: () {
                            _getTimeFromUser(isStartTime: true);
                          },
                          icon: Icon(
                            Icons.access_time_rounded,
                            color: Get.isDarkMode ? Colors.white : Colors.black,
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
                          icon: Icon(
                            Icons.access_time_rounded,
                            color: Get.isDarkMode ? Colors.white : Colors.black,
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
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Alerts",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color:
                                Get.isDarkMode ? Colors.white : Colors.black54),
                      ),
                      Spacer(),
                      InkWell(
                        onTap: (() {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  actions: [
                                    Row(
                                      children: [
                                        InkWell(
                                          onTap: () => Get.back(),
                                          child: Text("Cancel"),
                                        ),
                                        Spacer(),
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              alertList.add(
                                                  int.parse(myController.text));
                                              // selectedalertIndex = 4;

                                              Get.back();
                                            });
                                          },
                                          child: Text("Confirm"),
                                        ),
                                      ],
                                    )
                                  ],
                                  content: Container(
                                    height: 40,
                                    width: 10,
                                    child: TextField(
                                      maxLength: 2,
                                      keyboardType: TextInputType.number,
                                      controller: myController,
                                    ),
                                  ),
                                );
                              });
                        }),
                        child: Text(
                          "Add Custom",
                          style: TextStyle(
                            color:
                                Get.isDarkMode ? Colors.white : Colors.black87,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
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
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Any Details ?",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Get.isDarkMode ? Colors.white : Colors.black54,
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
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "How often ?",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Get.isDarkMode ? Colors.white : Colors.black54,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "Starting - ${dateselected.day}/${dateselected.month}/${dateselected.year}",
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    colorPallete(),
                  ],
                ),
                MyButton(
                    height: 50,
                    width: 350,
                    label: "Create Task",
                    onTap: () async {
                      if (selectedweek.contains(0)) {
                        setState(() {
                          sunday = 1;
                        });
                      }
                      if (selectedweek.contains(1)) {
                        setState(() {
                          monday = 1;
                        });
                      }
                      if (selectedweek.contains(2)) {
                        setState(() {
                          tuesday = 1;
                        });
                      }
                      if (selectedweek.contains(3)) {
                        setState(() {
                          wednesday = 1;
                        });
                      }
                      if (selectedweek.contains(4)) {
                        setState(() {
                          thursday = 1;
                        });
                      }
                      if (selectedweek.contains(5)) {
                        setState(() {
                          friday = 1;
                        });
                      }
                      if (selectedweek.contains(6)) {
                        setState(() {
                          saturday = 1;
                        });
                      }
                      fullDate =
                          DateTimeField.combine(_selectedDate, selectedcustime);

                      for (var i = 0; i < multiplealertList.length; i++) {
                        setState(() {
                          fullDate = fullDate.subtract(
                              Duration(minutes: multiplealertList[i]));
                        });
                        print("my current fulldate is -> ${fullDate}");
                        await _notificationService.scheduleNotifications(
                            id: i,
                            title: _titleController.text,
                            body: null,
                            time: fullDate);
                      }

                      if (_titleController.text.isNotEmpty) {
                        _addTaskToDb();
                        Get.back();
                      } else if (_titleController.text.isEmpty) {
                        Get.snackbar("Error", "All fields are required !",
                            snackPosition: SnackPosition.BOTTOM,
                            margin: const EdgeInsets.only(
                              bottom: 10,
                            ),
                            backgroundColor: Colors.white,
                            colorText: pinkClr,
                            icon: const Icon(Icons.warning_amber_rounded,
                                color: Colors.red));
                      }
                      setState(() {
                        alertbefore = 0;
                        selectedcolIndex = -1;
                        customcolor = 0;
                        selectedalertIndex = -1;
                        _selectedColor = 0;
                        _selectedRepeat = "None";
                        selectedweek = [];
                        weelcheck = [];
                        multiplealertList = [];
                        monday = 0;
                        tuesday = 0;
                        wednesday = 0;
                        thursday = 0;
                        friday = 0;
                        saturday = 0;
                        sunday = 0;
                      });
                    }),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ));
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
      monday: monday,
      tuesday: tuesday,
      wednesday: wednesday,
      thursday: thursday,
      friday: friday,
      saturday: saturday,
      sunday: sunday,
      // dyz: weelcheck,
    ));
    print("My id is " + "$value");
  }

  _appBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      centerTitle: false,
      titleSpacing: 0.0,
      title: Transform(
        // you can forcefully translate values left side using Transform
        transform: Matrix4.translationValues(-35.0, 4.0, 0.0),
        child: Padding(
          padding: const EdgeInsets.only(left: 50),
          child: Text(
            "Create New Task",
            style: TextStyle(
                color: Get.isDarkMode ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 25),
          ),
        ),
      ),
      actions: [
        IconButton(
            icon: Icon(
              Icons.close,
              color: Get.isDarkMode ? Colors.white : Colors.black,
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
        dateselected = _pickerDate;
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
        selectedcustime = pickedTime;
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

class _alerttimeselectState extends State<alerttimeselect> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Wrap(
        children: List.generate(alertList.length, (index) {
          return InkWell(
            onTap: () {
              setState(() {
                multiplealertList.contains(alertList[index])
                    ? multiplealertList.remove(alertList[index])
                    : multiplealertList.add(alertList[index]);

                selectedalertIndex = index;
                alertbefore = alertList[selectedalertIndex];
                print(alertbefore);
              });
            },
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              child: AppButton(
                color: multiplealertList.contains(alertList[index])
                    ? Colors.white
                    : Get.isDarkMode
                        ? Colors.white
                        : Colors.black,
                // color: selectedalertIndex == index
                //     ? Colors.white
                //     : Get.isDarkMode
                //         ? Colors.white
                //         : Colors.black,
                backgroundColor: multiplealertList.contains(alertList[index])
                    ? primaryClr
                    : Colors.transparent,
                size: 50,
                text: "${alertList[index]}m",
              ),
            ),
          );
        }),
      ),
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
  int uniq = 1;
  int weekcounter = 2;
  int monthcounter = 2;

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
                  index == 1
                      ? setState(() {
                          _selectedRepeat = "Daily";
                        })
                      : index == 2
                          ? setState(() {
                              _selectedRepeat = "Weekly";
                            })
                          : index == 3
                              ? setState(() {
                                  _selectedRepeat = "Monthly";
                                })
                              : _selectedRepeat = "None";
                });
              },
              child: Container(
                margin: const EdgeInsets.only(right: 10),
                child: AppButton(
                  color: selectedweekIndex == index
                      ? Colors.white
                      : Get.isDarkMode
                          ? Colors.white
                          : Colors.black,
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
                    Row(
                      children: [
                        Text("Every "),
                        Text(NumberToWord().convert('en-in', weekcounter)),
                        Text("Week"),
                      ],
                    ),
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
                      child: InkWell(
                        onTap: (() {
                          setState(() {
                            weekcounter++;
                          });
                        }),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
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
                      child: InkWell(
                        onTap: (() {
                          setState(() {
                            weekcounter == 2 ? weekcounter = 2 : weekcounter--;
                          });
                        }),
                        child: const Icon(
                          Icons.remove,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : selectedweekIndex == 3
                ? Container(
                    margin: const EdgeInsets.only(top: 10),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromRGBO(78, 91, 232, 0.06),
                    ),
                    child: Row(
                      children: [
                        Row(
                          children: [
                            Text("Every "),
                            Text(NumberToWord().convert('en-in', monthcounter)),
                            Text("Month"),
                          ],
                        ),
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
                          child: InkWell(
                            onTap: (() {
                              setState(() {
                                monthcounter++;
                              });
                            }),
                            child: const Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
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
                          child: InkWell(
                            onTap: (() {
                              setState(() {
                                monthcounter == 2
                                    ? monthcounter = 2
                                    : monthcounter--;
                              });
                            }),
                            child: const Icon(
                              Icons.remove,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : selectedweekIndex == 1
                    ? Column(children: [
                        SizedBox(height: 8),
                        Container(
                          alignment: Alignment.center,
                          height: 50,
                          // margin: const EdgeInsets.only(top: 10),
                          // padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color.fromRGBO(78, 91, 232, 0.06),
                          ),
                          child: const weelSelect(),
                        ),
                      ])
                    : Container()
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
// List<String> fullweekList = [
//   "Sunday",
//   "Monday",
//   "Tuesday",
//   "Wednesday",
//   "Thursday",
//   "Friday",
//   "Saturday",
// ];

class _weelSelectState extends State<weelSelect> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: List.generate(7, (index) {
        return InkWell(
          child: Container(
            margin: const EdgeInsets.only(right: 10),
            child: selectedweek.contains(index)
                ? InkWell(
                    onTap: () {
                      setState(() {
                        selectedweek.remove(index);
                      });
                    },
                    child: SmallAppButton(
                      color: selectedweek.contains(index)
                          ? Colors.white
                          : Get.isDarkMode
                              ? Colors.white
                              : Colors.black,
                      backgroundColor: selectedweek.contains(index)
                          ? primaryClr
                          : Colors.transparent,
                      size: 34,
                      text: weekList[index],
                    ),
                  )
                : InkWell(
                    onTap: () {
                      setState(() {
                        selectedweek.add(index);
                      });
                    },
                    child: SmallAppButton(
                      color: selectedweek.contains(index)
                          ? Colors.white
                          : Get.isDarkMode
                              ? Colors.white
                              : Colors.black,
                      backgroundColor: selectedweek.contains(index)
                          ? primaryClr
                          : Colors.transparent,
                      size: 34,
                      text: weekList[index],
                    ),
                  ),
          ),
        );
      }),
    );
  }
}

class colorPallete extends StatefulWidget {
  const colorPallete({super.key});

  @override
  State<colorPallete> createState() => _colorPalleteState();
}

List<Color> colorList = [
  brownClr,
  redClr,
  pinkClr,
  yellowClr,
  greenClr,
];

class _colorPalleteState extends State<colorPallete> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20,
        ),
        Text(
          "Pick a color",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Get.isDarkMode ? Colors.white : Colors.black54,
          ),
        ),
        const SizedBox(
          height: 5.0,
        ),
        Row(
          children: [
            Wrap(
              children: List.generate(5, (index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      customcolor = -1;
                      _selectedColor = (index);
                      selectedcolIndex = index;
                      addtaskcol = colorList[selectedcolIndex];
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: selectedcolIndex == index
                        ? UnColorButton(
                            color: colorList[index],
                            backgroundColor: primaryClr)
                        : ColorButton(color: colorList[index]),
                  ),
                );
              }),
            ),
            customcolor == 1
                ? Container(
                    height: 40,
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: primaryClr,
                    ),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 6,
                        ),
                        InkWell(
                          onTap: () => showDialog(
                              context: context,
                              builder: (BuildContext) {
                                return WheelColorPicker(
                                  onSelect: (Color newColor) {
                                    setState(() {
                                      _selectedColor = 5;
                                      customcolor = 1;
                                      selectedCol = newColor;
                                      addtaskcol = newColor;
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
                              }),
                          child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 6, left: 1.5, right: 3, bottom: 6),
                              child: CircleAvatar(
                                radius: 12,
                                backgroundColor: selectedCol,
                              )),
                        ),
                        const Icon(
                          Icons.done,
                          size: 18,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  )
                : InkWell(
                    onTap: (() {
                      selectedcolIndex = -1;
                      showDialog(
                          context: context,
                          builder: (BuildContext) {
                            return WheelColorPicker(
                              onSelect: (Color newColor) {
                                setState(() {
                                  _selectedColor = 5;
                                  customcolor = 1;
                                  selectedCol = newColor;
                                  addtaskcol = newColor;
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
}
