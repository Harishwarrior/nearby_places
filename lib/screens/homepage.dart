import 'package:flutter/material.dart';
import 'package:nearby_places/repository/model/places.dart';
import 'package:nearby_places/repository/repository.dart';

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
    return MaterialApp(
      title: 'Nearby Places',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Nearby Places'),
        ),
        body: Center(
          child: FutureBuilder<List<Places>>(
            future: locationData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Places>? data = snapshot.data;
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
