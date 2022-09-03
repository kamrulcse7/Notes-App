import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/note_model.dart';
import '../pages/task_editor_page.dart';

class MyListTile extends StatefulWidget {
  MyListTile(
    this.task,
    this.index, {
    Key? key,
  }) : super(key: key);
  Task task;
  int index;
  // DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");

  @override
  State<MyListTile> createState() => _MyListTileState();
}

class _MyListTileState extends State<MyListTile> {
  @override
  Widget build(BuildContext context) {
    String dateOBDCommand = '${widget.task.creation_date!}';
    DateTime date = DateTime.parse(dateOBDCommand);
    String dateTime = DateFormat('hh:mm a – yyyy-MM-dd').format(date);
    var title = widget.task.title;
    var note = widget.task.note;
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (contex) => TaskEditorPage(
              task: widget.task,
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 12.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(10.0)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${title}',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.0,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              softWrap: true,
            ),
            // Divider(),
            SizedBox(
              height: 10.0,
            ),
            Text(
              "${note}",
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w400,
                letterSpacing: 1.0,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              softWrap: true,
            ),
            Divider(
              // height: 24,
              thickness: 1.0,
            ),
            Row(
              children: [
                Text(
                  dateTime.toString(),
                ),
                Spacer(),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (contex) => TaskEditorPage(
                          task: widget.task,
                        ),
                      ),
                    );
                  },
                  child: Icon(
                    Icons.edit,
                    color: Colors.green[300],
                  ),
                ),
                SizedBox(
                  width: 22.0,
                ),
                InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) {
                        return AlertDialog(
                          backgroundColor: Colors.green[50],
                          title: Text('Confimation Delete'),
                          content: Text(
                              'Are you sure you want to delete this item?'),
                          actions: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                MaterialButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    "Cancel",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  color: Colors.green,
                                ),
                                MaterialButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    widget.task.delete();
                                  },
                                  child: Text(
                                    "Delete",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  color: Colors.red,
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Icon(
                    Icons.delete,
                    color: Colors.red[300],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
