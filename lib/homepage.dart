import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:nearby_places/places.dart';
import 'service.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Data>> futureData;

  var locationData;
  Future<List<Data>> fetchData() async {
    Position locationData = await determinePosition();

    double lat = locationData.latitude;
    double lon = locationData.longitude;

    final response = await http.get(Uri.parse(
        'https://api.opentripmap.com/0.1/en/places/radius?radius=10000&lon=$lon&lat=$lat&rate=1&format=json&apikey=5ae2e3f221c38a28845f05b60c0c6745c70108439773505405f23e8c'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Data.fromMap(data)).toList();
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  @override
  void initState() {
    super.initState();
    locationData = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nearby Places',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Nearby Places'),
        ),
        body: Center(
          child: FutureBuilder<List<Data>>(
            future: locationData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Data>? data = snapshot.data;
                return ListView.builder(
                    itemCount: data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        elevation: 5.0,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data[index].name,
                                style: TextStyle(fontSize: 20.0),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                'Distance: ${(data[index].dist.round() / 1000).toString()} km',
                                style: TextStyle(
                                    fontSize: 18.0, color: Colors.black54),
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
