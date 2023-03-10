import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
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
          _showTasks(),
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
              // print(task.toJson());
              if (task.repeat == 'Daily') {
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
    Get.bottomSheet(
      Container(
          padding: const EdgeInsets.only(
            top: 4,
          ),
          height: task.isCompleted == 1
              ? MediaQuery.of(context).size.height * 0.24
              : MediaQuery.of(context).size.height * 0.32,
          color: Get.isDarkMode ? darkGreyClr : Colors.white,
          child: Column(
            children: [
              Container(
                  height: 6,
                  width: 120,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Get.isDarkMode
                          ? Colors.grey[600]
                          : Colors.grey[300])),
              Spacer(),
              task.isCompleted == 1
                  ? Container()
                  : _bottomSheetButton(
                      label: "Task Completed",
                      onTap: () {
                        _taskController.markTaskCompleted(task.id!);
                        Get.back();
                      },
                      clr: primaryClr,
                      context: context,
                    ),
              _bottomSheetButton(
                label: "Delete Task",
                onTap: () {
                  _taskController.delete(task);
                  Get.back();
                },
                clr: Colors.red[300]!,
                context: context,
              ),
              const SizedBox(
                height: 20,
              ),
              _bottomSheetButton(
                label: "Close",
                onTap: () {
                  Get.back();
                },
                clr: Colors.red[300]!,
                isClose: true,
                context: context,
              ),
              const SizedBox(
                height: 25,
              )
            ],
          )),
    );
  }

  _bottomSheetButton({
    required String label,
    required Function()? onTap,
    required Color clr,
    bool isClose = false,
    required BuildContext context,
  }) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 4),
          height: 55,
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: BoxDecoration(
            border: Border.all(
                width: 2,
                color: isClose == true
                    ? Get.isDarkMode
                        ? Colors.grey[600]!
                        : Colors.grey[300]!
                    : clr),
            borderRadius: BorderRadius.circular(20),
            color: isClose == true ? Colors.transparent : clr,
          ),
          child: Center(
            child: Text(
              label,
              style: isClose
                  ? titleStyle
                  : titleStyle.copyWith(color: Colors.white),
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
                        : Color.fromRGBO(0, 0, 0, 0.5),
                  ),
                ),
                Text(
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
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
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
          child: CircleAvatar(
            backgroundImage: AssetImage("images/profile.png"),
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
                  margin: EdgeInsets.only(top: 15, bottom: 5, right: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Get.isDarkMode
                        ? Colors.grey[600]
                        : Color.fromRGBO(255, 124, 50, 1),
                  ),
                  width: 70,
                ),
                AnimatedPositioned(
                  duration: Duration(seconds: 1),
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
