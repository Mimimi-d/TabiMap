import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:tabimap/provider/add_marker_provider.dart';
import 'package:tabimap/provider/card_provider.dart';

import '../domain/mapmarker.dart';
import '../repository/marker_repository.dart';

class CardTiles extends ConsumerWidget {
  CardTiles({super.key});
  final Set<MapMarker> mapMarkerList = {};

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final markerAsyncValue = ref.watch(markerStreamProvider);
    final mapController = ref.watch(mapControllerProvider.state).state;
    final deviceIdAsyncValue = ref.watch(deviceIdProvider);
    final markerRepository = ref.watch(markersRepositoryProvider);
    late String deviceId;
    deviceIdAsyncValue.when(
      data: ((data) {
        deviceId = data;
      }),
      error: ((error, stackTrace) => Text('Error: $error')),
      loading: () {},
    );
    return markerAsyncValue.when(
      data: (markerData) {
        final markerDocs = markerData.docs;
        for (var mapMarkerData in markerDocs) {
          // firestoreから取得したデータのうちdeviceIdが一致するものをmapMarkerListに追加
          if (mapMarkerData['deviceId'] == deviceId) {
            final mapMarker = MapMarker(
              position: mapMarkerData['position'],
              description: mapMarkerData['description'],
              starRating: mapMarkerData['starRating'],
              title: mapMarkerData['title'],
              reference: mapMarkerData['reference'],
              createat: mapMarkerData['createat'].toDate(),
              deviceId: mapMarkerData['deviceId'],
            );
            mapMarkerList.add(mapMarker);
          }
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
            children: _tiles(markerRepository),
          ),
        );
      },
      error: ((error, stackTrace) => Text('Error: $error')),
      loading: () => Stack(
        children: const [Center(child: CircularProgressIndicator())],
      ),
    );
  }

  List<Widget> _tiles(MarkerRepository markerRepository) {
    final tiles = mapMarkerList.map(
      (mapMarker) {
        return Card(
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    markerRepository.deleteMarkerCorrection(mapMarker);
                  },
                ),
              ),
              SizedBox(
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
        );
      },
    ).toList();
    return tiles;
  }
}
