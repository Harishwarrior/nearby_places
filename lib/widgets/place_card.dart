import 'package:flutter/material.dart';
import 'package:nearby_places/repository/model/places.dart';
import 'package:nearby_places/widgets/tag_decor.dart';

class PlaceCard extends StatelessWidget {
  const PlaceCard({Key? key, required this.data, required this.index})
      : super(key: key);
  final Places data;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.4),
          spreadRadius: -15,
          blurRadius: 10,
          offset: Offset(1, 8), // changes position of shadow
        ),
      ]),
      child: Card(
        margin: EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 20,
        ),
        // elevation: 3.0,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      data.name,
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.w700,
                        color: Color.fromARGB(255, 50, 50, 50)
                        // color: index % 3 == 0
                        //     ? Colors.lightBlueAccent
                        //     : index % 2 == 0
                        //         ? Color.fromARGB(255, 239, 54, 115)
                        //         : Color.fromARGB(255, 246, 160, 22),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: 
                         Colors.yellow.withOpacity(0.2),
                        
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      children: [
                        Text(
                          (data.rate.round() / 1).toString(),
                          style: TextStyle(fontSize: 18, color: Color.fromARGB(255, 225, 203, 2)),
                        ),
                        SizedBox(width: 2),
                        Icon(
                          Icons.star,
                          color:  Color.fromARGB(255, 225, 203, 2),
                          size: 18,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Icon(
                    Icons.location_on,
                    color: Colors.red[700],
                    size: 18,
                  ),
                  SizedBox(width: 4),
                  Text(
                    '${(data.dist.round() / 1000).toString()} km',
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Wrap(
                children: data.kinds.toString().split(',').map((tag) {
                  return TagDecor(tag: tag);
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
