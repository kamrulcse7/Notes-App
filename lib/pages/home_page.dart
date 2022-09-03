import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hive_flutter/adapters.dart';

import '../model/note_model.dart';
import '../widgets/my_list_tile.dart';
import 'task_editor_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isVisible = true;
  var box = Hive.box<Task>("tasks");
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
        body: box.isNotEmpty
            ? ValueListenableBuilder<Box<Task>>(
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
              )
            : Center(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Opacity(
                    opacity: 0.5,
                    child: Image.asset(
                      'assets/images/logo.png',
                      width: 80,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    "No notes hete yet",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w300,
                    ),
                  )
                ],
              )),
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
