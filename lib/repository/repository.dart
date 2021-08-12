import 'package:nearby_places/repository/model/places.dart';

import 'api_provider.dart';

class Repository {
  ApiProvider _apiProvider = ApiProvider();
  Future<List<Places>> fetchNearbyPlaces() => _apiProvider.fetchData();
}
