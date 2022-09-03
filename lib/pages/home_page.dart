import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:notes_app/pages/task_editor_page.dart';

import '../madel/note_model.dart';
import '../widgets/my_list_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isVisible = true;
  @override
  Widget build(BuildContext context) {
    
    return SafeArea(
      child: Scaffold(
        appBar: _isVisible
            ? AppBar(
                title: Text("My Notes"),
                backgroundColor: Colors.green[400],
                centerTitle: true,
                automaticallyImplyLeading: false,
              )
            : null,
        body: ValueListenableBuilder<Box<Task>>(
          valueListenable: Hive.box<Task>("tasks").listenable(),
          builder: (context, box, _) {
            return Container(
              padding: EdgeInsets.all(12.0),
              child: NotificationListener<UserScrollNotification>(
                onNotification: (notification) {
                  if (notification.direction == ScrollDirection.forward) {
                    if (!_isVisible) setState(() => _isVisible = true);
                  } else if (notification.direction ==
                      ScrollDirection.reverse) {
                    if (_isVisible) setState(() => _isVisible = false);
                  }
                  return true;
                },
                child: ListView.builder(
                  itemCount: box.values.length,
                  itemBuilder: (context, index) {
                    Task currentTask = box.getAt(index)!;
                    return MyListTile(currentTask, index);
                  },
                ),
              ),
            );
          },
        ),
        floatingActionButton: AnimatedSlide(
          duration: Duration(milliseconds: 300),
          offset: _isVisible ? Offset.zero : Offset(0, 2),
          child: AnimatedOpacity(
            duration: Duration(milliseconds: 300),
            opacity: _isVisible ? 1 : 0,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TaskEditorPage(),
                  ),
                );
              },
              child: Icon(
                Icons.add,
                color: Colors.white,
                size: 30.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
