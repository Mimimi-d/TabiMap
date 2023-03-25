import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../domain/mapmarker.dart';
import '../provider/add_marker_provider.dart';
import '../provider/card_provider.dart';
import '../provider/map_marker_provider.dart';
import '../repository/google_place_repository.dart';
import '../repository/marker_repository.dart';

class CardTiles extends ConsumerWidget {
  const CardTiles({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mapMarkerList = ref.watch(mapMarkersListProvider);
    final placeProvider = ref.watch(googlePlaceRepositoryProvider);
    final markerRepository = ref.watch(markersRepositoryProvider);

    return Container(
      margin: const EdgeInsets.only(top: 16),
      height: 300,
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
      child: PageView(
        onPageChanged: (int index) async {
          //現在のズームレベルを取得
          ref.read(onPageChangedProvider)(index);
        },
        controller: ref.watch(pageControllerProvider.state).state,
        children: [
          for (final mapMarker in mapMarkerList)
            FutureBuilder<InkWell>(
              future:
                  _tile(mapMarker, markerRepository, context, placeProvider),
              builder: (BuildContext context, AsyncSnapshot<InkWell> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return snapshot.data!;
                }
                return const SizedBox.shrink();
              },
            ),
        ],
      ),
    );
  }

  Future<InkWell> _tile(MapMarker mapMarker, MarkerRepository markerRepository,
      BuildContext context, GooglePlaceRepository placeRepository) async {
    final imageUrl = await placeRepository.placeSearch(
        mapMarker.position!.geopoint!.latitude,
        mapMarker.position!.geopoint!.longitude);
    final response = await http.head(Uri.parse(imageUrl!));
    return InkWell(
      onTap: () {
        //　編集画面へ
        context.push('/edit', extra: mapMarker);
      },
      child: Card(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  FirebaseCrashlytics.instance.log("clear icon button pressed");
                  markerRepository.deleteMarkerCorrection(mapMarker);
                },
              ),
            ),
            response.statusCode == 200
                ? Container(
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                      image: DecorationImage(
                        image: NetworkImage(imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                : Container(
                    height: 120,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                      image: DecorationImage(
                        image: NetworkImage(
                            'https://www.gtn-co.com/cms/wp-content/uploads/2020/06/noimage.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
            SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 24, top: 126),
                    child: Text(
                      maxLines: 1,
                      mapMarker.title.toString(),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        margin:
                            const EdgeInsets.only(left: 24, top: 4, right: 4),
                        child: Text(
                          mapMarker.starRating.toString(),
                          style: const TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 14),
                        ),
                      ),
                      RatingBar.builder(
                        initialRating: mapMarker.starRating!,
                        minRating: 0,
                        direction: Axis.horizontal,
                        ignoreGestures: true,
                        itemSize: 24,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding:
                            const EdgeInsets.symmetric(horizontal: 1.0),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {},
                      ),
                    ],
                  ),
                  Center(
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 8),
                      height: 1,
                      color: Colors.grey,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(left: 24),
                      child: Text(
                        maxLines: 2,
                        mapMarker.description.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      alignment: Alignment.bottomRight,
                      margin: const EdgeInsets.only(right: 16, bottom: 16),
                      child: Text(
                        maxLines: 1,
                        '編集日時:${DateFormat("yyyy/MM/dd HH:mm").format(mapMarker.createat!)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
