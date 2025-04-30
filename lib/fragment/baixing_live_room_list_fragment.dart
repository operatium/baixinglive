import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Baixing_LiveRoomListFragment extends StatelessWidget {
  final String title;

  const Baixing_LiveRoomListFragment({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.orangeAccent,
      child: Text(title),
    );
  }


}