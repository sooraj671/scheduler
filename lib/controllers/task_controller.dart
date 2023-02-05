import 'package:get/get.dart';
import 'package:scheduler/db/db_helper.dart';

import '../models/task.dart';

class TaskController extends GetxController {
  @override
  void onReady() {
    super.onReady();
  }

  var taskList = <Task>[].obs;

  Future<int> addTask({Task? task}) async {
    return await DBHelper.insert(task);
  }

// get all the data from table
  void getTasks() async {
    List<Map<String, dynamic>> tasks = await DBHelper.query();
    taskList.assignAll(tasks.map((data) => new Task.fromJson(data)).toList());
  }

  void delete(Task task) {
    DBHelper.delete(task);
    getTasks();
  }

  void deleteall() {
    for (var task = 0; task < taskList.length; task++) {
      DBHelper.delete(taskList[task]);
    }

    getTasks();
  }

  void deleteallfuture(Task task) {
    for (var i = 0; i < taskList.length; i++) {
      if (taskList[i] == task) {
        continue;
      } else {
        DBHelper.delete(taskList[i]);
      }
    }

    getTasks();
  }

  void markTaskCompleted(int id) async {
    await DBHelper.update(id);
    getTasks();
  }
}
