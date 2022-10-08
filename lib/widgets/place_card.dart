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
    return Card(
      margin: EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 20,
      ),
      elevation: 3.0,
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
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500,
                      color: index % 3 == 0
                          ? Colors.lightBlueAccent
                          : index % 2 == 0
                              ? Colors.pink[300]
                              : Colors.yellow[800],
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: data.rate < 3
                        ? Colors.grey[400]
                        : data.rate < 6
                            ? Colors.yellow[600]
                            : Colors.green,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    children: [
                      Text(
                        (data.rate.round() / 1).toString(),
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                      SizedBox(width: 2),
                      Icon(
                        Icons.star,
                        color: Colors.white,
                        size: 14,
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
    );
  }
}
