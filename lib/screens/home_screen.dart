import 'package:flutter/material.dart';

import '../widgets/my_note_add_button.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double topPadding = MediaQuery.of(context).padding.top;
    return SafeArea(
      child: Scaffold(
        floatingActionButton: MyNoteAddButton(topPadding: topPadding),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          // child: ,
        ),
      ),
    );
  }
}
