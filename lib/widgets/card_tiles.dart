import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
          final mapMarker = MapMarker(
            position: mapMakerData['position'],
            description: mapMakerData['description'],
            starRating: mapMakerData['starRating'],
            title: mapMakerData['title'],
            reference: mapMakerData['reference'],
          );
          mapMarkerList.add(mapMarker);
        }
        // print(markerList);
        return Container(
          margin: const EdgeInsets.only(top: 16),
          height: 148,
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
            height: 100,
            child: Center(
              child: Text(mapMarker.title.toString()),
            ),
          ),
        );
      },
    ).toList();
    return tiles;
  }
}
