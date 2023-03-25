import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_place/google_place.dart';

import '../const.dart';
import '../domain/place.dart';

final googlePlaceRepositoryProvider = Provider((ref) {
  return GooglePlaceRepository();
});

class GooglePlaceRepository {
  final String apiKey = Const.placeapiKey;
  final googlePlace = GooglePlace(Const.placeapiKey);
  Place? place;
  Future<String?> placeSearch(double lat, double lng) async {
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
      place = Place('', '', '');
    }
    return place?.photoReference;
  }
}
