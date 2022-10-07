import 'package:flutter/material.dart';
import 'package:nearby_places/repository/model/places.dart';
import 'package:nearby_places/repository/repository.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var locationData;
  Repository _repository = Repository();

  @override
  void initState() {
    super.initState();
    locationData = _repository.fetchNearbyPlaces();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFF6D8A),
        title: Text('Nearby Places'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Center(
          child: FutureBuilder<List<Places>>(
            future: locationData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Places>? data = snapshot.data;
                return ListView.builder(
                  itemCount: data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return placeCard(data[index], index + 1);
                  },
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return shimmer();
            },
          ),
        ),
      ),
    );
  }

  Widget shimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 100,
            width: 100,
            margin: EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 20,
            ),
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(10),
            ),
          );
        },
      ),
    );
  }

  Widget placeCard(Places data, int index) {
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
                return tagDecor(tag);
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget tagDecor(String tag) {
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
