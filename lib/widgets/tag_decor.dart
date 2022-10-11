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
        color: Color.fromARGB(255, 90, 167, 245).withOpacity(0.2),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        tag.split('_').join(' '),
        style: TextStyle(fontSize: 14, color: Color.fromARGB(255, 18, 128, 217),fontWeight:FontWeight.w400),
      ),
    );
  }
}
