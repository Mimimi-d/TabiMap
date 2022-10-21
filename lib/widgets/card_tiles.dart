import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:tabimap/provider/card_provider.dart';

import '../domain/mapmarker.dart';
import '../repository/marker_repository.dart';

class CardTiles extends ConsumerWidget {
  CardTiles({super.key});
  Set<MapMarker> mapMarkerList = {};

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final markerAsyncValue = ref.watch(markerStreamProvider);
    final mapController = ref.watch(mapControllerProvider.state).state;
    return markerAsyncValue.when(
      data: (markerData) {
        final markerDocs = markerData.docs;

        for (var mapMakerData in markerDocs) {
          // print(mapMakerData['createat'].toDate());
          final mapMarker = MapMarker(
            position: mapMakerData['position'],
            description: mapMakerData['description'],
            starRating: mapMakerData['starRating'],
            title: mapMakerData['title'],
            reference: mapMakerData['reference'],
            createat: mapMakerData['createat'].toDate(),
          );
          mapMarkerList.add(mapMarker);
        }
        // print(markerList);
        return Container(
          margin: const EdgeInsets.only(top: 16),
          height: 220,
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
          child: PageView(
            onPageChanged: (int index) async {
              //スワイプ後のページのお店を取得
              final selectedMapMarker = mapMarkerList.elementAt(index);
              //現在のズームレベルを取得
              final zoomLevel = await mapController!.getZoomLevel();
              //スワイプ後のお店の座標までカメラを移動
              mapController.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: LatLng(
                      selectedMapMarker.position!.latitude,
                      selectedMapMarker.position!.longitude,
                    ),
                    zoom: zoomLevel,
                  ),
                ),
              );
            },
            controller: ref.watch(pageControllerProvider.state).state,
            children: _tiles(),
          ),
        );
      },
      error: ((error, stackTrace) => Text('Error: $error')),
      loading: () => Stack(
        children: const [Center(child: CircularProgressIndicator())],
      ),
    );
  }

  List<Widget> _tiles() {
    final tiles = mapMarkerList.map(
      (mapMarker) {
        return Card(
          child: SizedBox(
            height: 190,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 24, top: 16),
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
                      margin: const EdgeInsets.only(left: 24, top: 4, right: 4),
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
                      itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
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
                    margin:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
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
        );
      },
    ).toList();
    return tiles;
  }
}
