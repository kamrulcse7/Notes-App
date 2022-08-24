import 'package:flutter/material.dart';

class MyNoteAddButton extends StatelessWidget {
  const MyNoteAddButton({
    Key? key,
    required this.topPadding,
  }) : super(key: key);

  final double topPadding;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      // backgroundColor: Colors.green,
      onPressed: () {
        showModalBottomSheet(
          context: context,
          // useRootNavigator: true,
          isScrollControlled: true,
          builder: (context) {
            return Container(
              height: MediaQuery.of(context).size.height - topPadding!,
              child: Scaffold(
                appBar: AppBar(
                  elevation: 0,
                  toolbarHeight: 60.0,
                  backgroundColor: Colors.green[200],
                  leadingWidth: 100.0,
                  leading: GestureDetector(
                    onTap: () => Navigator.pop(context),
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
                      onTap: () {},
                      child: Chip(
                        backgroundColor: Colors.white,
                        avatar: CircleAvatar(
                          child: Icon(Icons.check),
                        ),
                        label: Text("Save"),
                      ),
                    ),
                    SizedBox(
                      width: 12.0,
                    ),
                  ],
                ),
                // 
              ),
            );
          },
        );
      },
      child: Icon(
        Icons.add,
        color: Colors.white,
        size: 30.0,
      ),
    );
  }
}
