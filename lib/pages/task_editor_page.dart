import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hive/hive.dart';
import 'package:notes_app/madel/note_model.dart';

import 'home_page.dart';

class TaskEditorPage extends StatefulWidget {
  final double? topPadding;
  Task? task;
  TaskEditorPage({
    Key? key,
    this.task,
    this.topPadding,
  }) : super(key: key);

  @override
  State<TaskEditorPage> createState() => _TaskEditorPageState();
}

class _TaskEditorPageState extends State<TaskEditorPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _taskTitle = TextEditingController(
        text: widget.task == null ? null : widget.task!.title!
        );
    TextEditingController _taskNote = TextEditingController(
        text: widget.task == null ? null : widget.task!.note!);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 60.0,
          backgroundColor: Colors.green[400],
          leadingWidth: 100.0,
          leading: GestureDetector(
            onTap: () => Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => HomePage())),
            child: Chip(
              backgroundColor: Colors.white,
              avatar: CircleAvatar(
                backgroundColor: Colors.redAccent,
                child: Icon(Icons.close),
              ),
              label: Text("Cancel"),
            ),
          ),
          actions: [
            GestureDetector(
              onTap: () async {
                var newTask = Task(
                  title: _taskTitle.text,
                  note: _taskNote.text,
                  creation_date: DateTime.now(),
                  done: false,
                );
                Box<Task> taskBox = Hive.box<Task>("tasks");
                // if(widget.task == null ){
                //   ScaffoldMessenger.of(context).showSnackBar(
                //     SnackBar(
                //       content: Text("Notes are empty! write something", style: TextStyle(fontSize: 16.0),),
                //       duration: Duration(milliseconds: 500),
                //       backgroundColor: Colors.red[300],
                //     ),
                //   );
                // }
                if (widget.task != null) {
                  widget.task!.title = newTask.title;
                  widget.task!.note = newTask.note;
                  // widget.task!.save();
                   Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                } 
                
                else {
                  await taskBox.add(newTask);
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                }
              },
              child: Chip(
                backgroundColor: Colors.white,
                avatar: CircleAvatar(
                  child: Icon(Icons.check),
                ),
                label: Text(widget.task == null ? "Save" : "Update"),
              ),
            ),
            SizedBox(
              width: 12.0,
            ),
          ],
        ),
        //
        body: Container(
          width: double.infinity,
          height: double.infinity,
          padding: EdgeInsets.only(top: 10.0, left: 12.0, right: 12.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: _taskTitle,
                  decoration: InputDecoration(
                    // border:InputBorder.none,
                    // fillColor: Colors.black12,
                    // filled: true,
                    hintText: "Title",
                    hintStyle: TextStyle(
                      fontSize: 20.0,
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                  controller: _taskNote,
                  decoration: InputDecoration(
                    // fillColor: Colors.green,
                    // filled: true,
                    border: InputBorder.none,
                    hintText: "Start typing..",
                    hintStyle: TextStyle(
                      fontSize: 18.0,
                      letterSpacing: 1.2,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  maxLines: MediaQuery.of(context).size.height.toInt(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
