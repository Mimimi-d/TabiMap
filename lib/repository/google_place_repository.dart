import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_place/google_place.dart';

import '../const.dart';
import '../domain/place.dart';

final googlePlaceRepositoryProvider = Provider((ref) {
  return GooglePlaceRepository();
});

class GooglePlaceRepository {
  final String apiKey = Const.placeapi_key;
  final googlePlace = GooglePlace(Const.placeapi_key);
  Place? place;
  Future<String?> placeSearch(double lat, double lng) async {
    print(lat);
    print(lng);
    final response = await googlePlace.search.getNearBySearch(
        Location(lat: lat, lng: lng), 5000,
        rankby: RankBy.Distance, language: 'ja');

    if (response != null &&
        response.results != null &&
        response.results!.isNotEmpty) {
      final firstResponse = response.results!.first;
      final photoRef = firstResponse.photos?.first.photoReference;

      place = Place(
          firstResponse.name,
          "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photo_reference=$photoRef&key=$apiKey",
          firstResponse.placeId);
    } else {
      print('null');
      place = Place('', '', '');
    }
    return place?.photoReference;
  }
}
