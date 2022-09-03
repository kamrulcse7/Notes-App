import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../model/note_model.dart';
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
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    TextEditingController _taskTitle = TextEditingController(
        text: widget.task == null ? null : widget.task!.title!);
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
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Note Save Successfully')),
                  );
                  if (widget.task != null) {
                    widget.task!.title = newTask.title;
                    widget.task!.note = newTask.note;
                    widget.task!.save();
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                  } else {
                    await taskBox.add(newTask);
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Please enter some text'),
                      duration: Duration(milliseconds: 700),
                      backgroundColor: Colors.red.shade300,
                    ),
                  );
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
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    controller: _taskTitle,
                    decoration: InputDecoration(
                      hintText: "Title",
                      hintStyle: TextStyle(
                        fontSize: 20.0,
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some title';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextFormField(
                    controller: _taskNote,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Start typing..",
                      hintStyle: TextStyle(
                        fontSize: 18.0,
                        letterSpacing: 1.2,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    maxLines: (MediaQuery.of(context).size.height * 0.04).toInt(),
                    // minLines: 50,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
