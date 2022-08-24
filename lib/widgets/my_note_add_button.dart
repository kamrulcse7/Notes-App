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
      onPressed: () {
        showModalBottomSheet(
          context: context,
          // useRootNavigator: true,
          isScrollControlled: true,
          builder: (context) {
            return Container(
              height: MediaQuery.of(context).size.height - topPadding!,
              child: Scaffold(
                appBar: AppBar(),
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
