import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scheduler/ui/add_task_bar.dart';
import '../../models/task.dart';
import '../theme.dart';

class TaskTile extends StatefulWidget {
  final Task? task;
  const TaskTile(this.task);

  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(bottom: 12),
      child: Container(
        padding: EdgeInsets.all(16),
        //  width: SizeConfig.screenWidth * 0.78,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: _getBGClr(widget.task?.color ?? 0),
        ),
        child: Row(children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.access_time_rounded,
                      color: Colors.grey[200],
                      size: 18,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      "${widget.task!.startTime} - ${widget.task!.endTime}",
                      style: GoogleFonts.lato(
                        textStyle:
                            TextStyle(fontSize: 13, color: Colors.grey[100]),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  widget.task?.title ?? "",
                  style: GoogleFonts.lato(
                    textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  widget.task?.note ?? "",
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(fontSize: 15, color: Colors.grey[100]),
                  ),
                ),
              ],
            ),
          ),
          widget.task!.isCompleted == 1
              ? Container(
                  height: 40,
                  width: 40,
                  child: InkWell(
                    onTap: (() {
                      setState(() {
                        widget.task!.isCompleted = 0;
                      });
                    }),
                    child: Icon(
                      Icons.circle,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                )
              : Container(
                  height: 40,
                  width: 40,
                  child: InkWell(
                    onTap: (() {
                      setState(() {
                        widget.task!.isCompleted = 1;
                      });
                    }),
                    child: Icon(
                      size: 30,
                      Icons.circle_outlined,
                      color: Colors.white,
                    ),
                  ),
                ),
        ]),
      ),
    );
  }

  _getBGClr(int no) {
    switch (no) {
      case 0:
        return brownClr;
      case 1:
        return redClr;
      case 2:
        return pinkClr;
      case 3:
        return yellowClr;
      case 4:
        return greenClr;
      case 5:
        return selectedCol;
      default:
        return blackClr;
    }
  }
}
