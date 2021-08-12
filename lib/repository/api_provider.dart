import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' show Client;

import 'model/places.dart';
import 'package:nearby_places/service/service.dart';

class ApiProvider {
  Client client = Client();
  Future<List<Places>> fetchData() async {
    Position _locationData = await determinePosition();
    final String _apikey =
        '5ae2e3f221c38a28845f05b60c0c6745c70108439773505405f23e8c';
    final double _lat = _locationData.latitude;
    final double _lon = _locationData.longitude;
    final _url =
        'https://api.opentripmap.com/0.1/en/places/radius?radius=10000&lon=$_lon&lat=$_lat&rate=1&format=json&apikey=$_apikey';

    final response = await client.get(Uri.parse(_url));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Places.fromMap(data)).toList();
    } else {
      throw Exception('Unexpected error occurred!');
    }
  }
}
