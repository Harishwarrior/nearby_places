import 'package:flutter/material.dart';
import 'package:nearby_places/repository/model/places.dart';
import 'package:nearby_places/repository/repository.dart';
import 'package:nearby_places/widgets/place_card.dart';
import 'package:nearby_places/widgets/shimmer.dart';

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

        backgroundColor: Colors.white,
        title: Text(
          'Nearby Places',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20),

        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16,0,16,0),
              child: TextField(
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
                  hintText: "Search",
                  suffixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(),
                  ),
                ),
              ),
            ),
            FutureBuilder<List<Places>>(
              future: locationData,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Places>? data = snapshot.data;
                  return Expanded(
                    child: ListView.builder(
                      itemCount: data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return PlaceCard(data: data[index], index: index + 1);
                      },
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                return ShimmerWidget();
              },
            ),
          ],
        ),
      ),
    );
  }
}
