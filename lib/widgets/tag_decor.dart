import 'package:flutter/material.dart';

class TagDecor extends StatelessWidget {
  const TagDecor({Key? key, required this.tag}) : super(key: key);
  final String tag;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 5,
      ),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.purple[200],
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        tag.split('_').join(' '),
        style: TextStyle(fontSize: 14, color: Colors.white),
      ),
    );
  }
}
