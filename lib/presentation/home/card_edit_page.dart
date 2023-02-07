import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:spring_button/spring_button.dart';
import 'package:tabimap/domain/mapmarker.dart';

import '../../provider/add_marker_provider.dart';

class CardEditPage extends ConsumerWidget {
  const CardEditPage({super.key, required this.mapMarker});
  final MapMarker mapMarker;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titleControllerProvider =
        ref.watch(titleControllerStateProvider.state);
    final titleDetailControllerProvider =
        ref.watch(titleDescriptionControllerStateProvider.state);

    titleControllerProvider.state.text = mapMarker.title!;
    titleDetailControllerProvider.state.text = mapMarker.description!;

    final markerRepository = ref.watch(markersRepositoryProvider);

    return Scaffold(
      backgroundColor: const Color.fromARGB(236, 212, 231, 255),
      appBar: AppBar(
        title: const Text('編集'),
      ),
      body: Center(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 24,
          child: Container(
            height: 350,
            width: MediaQuery.of(context).size.width * 0.88,
            padding: const EdgeInsets.only(top: 20, left: 24, right: 24),
            child: Column(
              children: [
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: titleControllerProvider.state,
                  decoration: InputDecoration(
                    fillColor: Colors.grey[300],
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                        color: Colors.blue,
                        width: 1.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        color: Colors.blue[600]!,
                        width: 1.0,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: titleDetailControllerProvider.state,
                  minLines: 3,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  textInputAction: TextInputAction.newline,
                  decoration: InputDecoration(
                    fillColor: Colors.grey[300],
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                        color: Colors.blue,
                        width: 1.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        color: Colors.blue[600]!,
                        width: 1.0,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                RatingBar.builder(
                  initialRating: mapMarker.starRating!.toDouble(),
                  minRating: 0,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    //rateが変わったら処理を走らす
                    ref.read(rateStateProvider.state).update((state) => rating);
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  height: 40,
                  width: 200,
                  child: SpringButton(
                    SpringButtonType.WithOpacity,
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.all(Radius.circular(24)),
                      ),
                      child: const Center(
                        child: Text(
                          '編集',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      markerRepository.updateMarkerCorrection(mapMarker);
                      context.pop();
                    },
                    onLongPress: null,
                    onLongPressEnd: null,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
