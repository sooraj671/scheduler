import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:scheduler/ui/add_task.dart';
import 'package:scheduler/ui/add_task_bar.dart';
import 'package:scheduler/ui/theme.dart';
import 'package:scheduler/ui/widgets/button.dart';
import 'package:scheduler/ui/widgets/task_tile.dart';
import '../controllers/task_controller.dart';
import '../models/task.dart';
import '../services/theme_services.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

DateTime _selectedDate = DateTime.now();

class _HomePageState extends State<HomePage> {
  DateTime _selectedDate = DateTime.now();
  final _taskController = Get.put(TaskController());

  double left = 50;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      backgroundColor: context.theme.bottomAppBarColor,
      body: Column(
        children: [
          _addTaskBar(),
          _addDateBar(),
          const SizedBox(
            height: 20,
          ),
          _showTasks()
        ],
      ),
    );
  }

  _showTasks() {
    return Expanded(
      child: Obx(() {
        return ListView.builder(
            itemCount: _taskController.taskList.length,
            itemBuilder: (_, index) {
              Task task = _taskController.taskList[index];
              if (task.repeat == 'Daily') {
                if (task.monday == 1 &&
                    DateFormat('EEEE').format(_selectedDate) == "Monday") {
                  return AnimationConfiguration.staggeredList(
                      position: index,
                      child: SlideAnimation(
                          child: FadeInAnimation(
                              child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              _showBottomSheet(context, task);
                            },
                            child: TaskTile(task),
                          )
                        ],
                      ))));
                }
                if (task.tuesday == 1 &&
                    DateFormat('EEEE').format(_selectedDate) == "Tueday") {
                  return AnimationConfiguration.staggeredList(
                      position: index,
                      child: SlideAnimation(
                          child: FadeInAnimation(
                              child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              _showBottomSheet(context, task);
                            },
                            child: TaskTile(task),
                          )
                        ],
                      ))));
                }
                if (task.wednesday == 1 &&
                    DateFormat('EEEE').format(_selectedDate) == "Wednesday") {
                  return AnimationConfiguration.staggeredList(
                      position: index,
                      child: SlideAnimation(
                          child: FadeInAnimation(
                              child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              _showBottomSheet(context, task);
                            },
                            child: TaskTile(task),
                          )
                        ],
                      ))));
                }
                if (task.thursday == 1 &&
                    DateFormat('EEEE').format(_selectedDate) == "Thursday") {
                  return AnimationConfiguration.staggeredList(
                      position: index,
                      child: SlideAnimation(
                          child: FadeInAnimation(
                              child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              _showBottomSheet(context, task);
                            },
                            child: TaskTile(task),
                          )
                        ],
                      ))));
                }
                if (task.friday == 1 &&
                    DateFormat('EEEE').format(_selectedDate) == "Friday") {
                  return AnimationConfiguration.staggeredList(
                      position: index,
                      child: SlideAnimation(
                          child: FadeInAnimation(
                              child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              _showBottomSheet(context, task);
                            },
                            child: TaskTile(task),
                          )
                        ],
                      ))));
                }
                if (task.saturday == 1 &&
                    DateFormat('EEEE').format(_selectedDate) == "Saturday") {
                  return AnimationConfiguration.staggeredList(
                      position: index,
                      child: SlideAnimation(
                          child: FadeInAnimation(
                              child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              _showBottomSheet(context, task);
                            },
                            child: TaskTile(task),
                          )
                        ],
                      ))));
                }
                if (task.sunday == 1 &&
                    DateFormat('EEEE').format(_selectedDate) == "Sunday") {
                  return AnimationConfiguration.staggeredList(
                      position: index,
                      child: SlideAnimation(
                          child: FadeInAnimation(
                              child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              _showBottomSheet(context, task);
                            },
                            child: TaskTile(task),
                          )
                        ],
                      ))));
                }
              }
              // if (task.repeat == 'Weekly') {
              //   if (task.dyz!
              //       .contains(DateFormat('EEEE').format(_selectedDate))) {
              //     return AnimationConfiguration.staggeredList(
              //         position: index,
              //         child: SlideAnimation(
              //             child: FadeInAnimation(
              //                 child: Row(
              //           children: [
              //             GestureDetector(
              //               onTap: () {
              //                 _showBottomSheet(context, task);
              //               },
              //               child: TaskTile(task),
              //             )
              //           ],
              //         ))));
              //   }
              // }
              print("upar jo select kiya woh ");
              print(DateFormat('EEEE').format(_selectedDate));

              if (task.date == DateFormat.yMd().format(_selectedDate)) {
                return AnimationConfiguration.staggeredList(
                    position: index,
                    child: SlideAnimation(
                        child: FadeInAnimation(
                            child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            _showBottomSheet(context, task);
                          },
                          child: TaskTile(task),
                        )
                      ],
                    ))));
              } else {
                return Container();
              }
            });
      }),
    );
  }

  _showBottomSheet(BuildContext context, Task task) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(30),
        ),
      ),
      builder: (context) {
        return Container(
            // color: Colors.transparent,
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.only(
              top: 4,
            ),
            height: MediaQuery.of(context).size.height * 0.24,
            color: Get.isDarkMode ? darkGreyClr : Colors.transparent,
            child: Column(
              children: [
                const Spacer(),
                Row(
                  children: [
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        Get.back();

                        _showdeleteBottomSheet(context, task);
                      },
                      child: Column(
                        children: const [
                          Icon(
                            Icons.delete,
                            color: primaryClr,
                            size: 35,
                          ),
                          Text(
                            "Delete",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: primaryClr,
                            ),
                          )
                        ],
                      ),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        _taskController.delete(task);
                        Get.back();
                      },
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              _taskController.delete(task);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => EditTaskPage()));
                            },
                            child: const Icon(
                              Icons.edit,
                              color: primaryClr,
                              size: 35,
                            ),
                          ),
                          const Text(
                            "Edit",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: primaryClr,
                            ),
                          )
                        ],
                      ),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        _taskController.markTaskCompleted(task.id!);
                        Get.back();
                      },
                      child: Column(
                        children: const [
                          Icon(
                            Icons.done,
                            color: primaryClr,
                            size: 35,
                          ),
                          Text(
                            "Completed",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: primaryClr,
                            ),
                          )
                        ],
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                _bottomSheetButton(
                  label: "Cancel",
                  onTap: () {
                    Get.back();
                  },
                  clr: Colors.white,
                  isClose: true,
                  context: context,
                ),
                const SizedBox(
                  height: 25,
                )
              ],
            ));
      },
    );
  }

  _showdeleteBottomSheet(BuildContext context, Task task) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(30),
        ),
      ),
      builder: (context) {
        return Container(
            // color: Colors.transparent,
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.only(
              top: 4,
            ),
            height: MediaQuery.of(context).size.height * 0.34,
            color: Get.isDarkMode ? darkGreyClr : Colors.transparent,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      _bottomSheetButton(
                          label: "Delete this task only",
                          onTap: () {
                            _taskController.delete(task);
                            Get.back();
                          },
                          clr: const Color.fromRGBO(78, 91, 232, 0.06),
                          textcolor: Colors.black,
                          context: context),
                      _bottomSheetButton(
                          label: "Delete all future tasks",
                          onTap: () {
                            _taskController.deleteallfuture(task);
                          },
                          clr: const Color.fromRGBO(78, 91, 232, 0.06),
                          textcolor: Colors.black,
                          context: context),
                      _bottomSheetButton(
                          label: "Delete all tasks",
                          onTap: () {
                            _taskController.deleteall();
                          },
                          clr: const Color.fromRGBO(78, 91, 232, 0.06),
                          textcolor: Colors.black,
                          context: context),
                      _bottomSheetButton(
                        label: "Cancel",
                        onTap: () {
                          Get.back();
                        },
                        clr: Colors.white,
                        isClose: true,
                        context: context,
                      ),
                    ],
                  ),
                )
              ],
            ));
      },
    );
  }

  _bottomSheetButton({
    required String label,
    required Function()? onTap,
    required Color clr,
    bool isClose = false,
    required BuildContext context,
    Color textcolor = Colors.white,
  }) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 4),
          height: 55,
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: isClose == true ? primaryClr : clr,
          ),
          child: Center(
            child: Text(
              label,
              style: titleStyle.copyWith(
                  color: textcolor, fontWeight: FontWeight.bold),
              // style: isClose
              //     ? titleStyle
              //     : titleStyle.copyWith(color: Colors.white),
            ),
          ),
        ));
  }

  _addTaskBar() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat("dd MMMM, yyyy").format(DateTime.now()),
                  style: TextStyle(
                    fontSize: 12,
                    color: Get.isDarkMode
                        ? Colors.white
                        : const Color.fromRGBO(0, 0, 0, 0.5),
                  ),
                ),
                const Text(
                  "Today",
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          MyButton(
              height: 50,
              width: 130,
              label: "+  Create Task",
              onTap: () async {
                await Get.to(const AddTaskPage());
                _taskController.getTasks();
              })
        ],
      ),
    );
  }

  _addDateBar() {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 15, right: 15),
      child: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: const BoxDecoration(
            color: Color.fromRGBO(78, 91, 232, 0.06),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: DatePicker(
          DateTime.now(),
          height: 90,
          width: 70,
          initialSelectedDate: DateTime.now(),
          selectionColor: primaryClr,
          selectedTextColor: Colors.white,
          dateTextStyle: GoogleFonts.lato(
              textStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey)),
          dayTextStyle: GoogleFonts.lato(
              textStyle: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey)),
          monthTextStyle: GoogleFonts.lato(
              textStyle: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey)),
          onDateChange: (date) {
            setState(() {
              _selectedDate = date;
            });
          },
        ),
      ),
    );
  }

  _appBar() {
    return AppBar(
        elevation: 0,
        title: Container(
          child: Row(
            children: [
              const CircleAvatar(
                backgroundImage: AssetImage("images/profile.png"),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                "Welcome",
                style: TextStyle(
                    color: Get.isDarkMode ? Colors.white : Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: 22),
              ),
            ],
          ),
        ),
        actions: [
          InkWell(
            onTap: () {
              setState(() {
                ThemeService().switchTheme();

                left = left != 50 ? 50 : 10;
              });
            },
            child: Stack(
              children: [
                Container(
                  child: Container(
                    margin: const EdgeInsets.only(
                        top: 15, bottom: 5, right: 10, left: 9),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Get.isDarkMode
                          ? Colors.grey[600]
                          : const Color.fromRGBO(255, 124, 50, 1),
                    ),
                    width: 70,
                  ),
                ),
                AnimatedPositioned(
                  duration: const Duration(seconds: 1),
                  left: left,
                  top: 20,
                  child: Icon(
                      Get.isDarkMode
                          ? Icons.nightlight_round
                          : Icons.wb_sunny_outlined,
                      size: 25,
                      color: Get.isDarkMode ? Colors.black : Colors.white),
                ),
              ],
            ),
          )
        ]);
  }
}
