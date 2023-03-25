import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tabimap/repository/marker_repository.dart';

class StarListPage extends ConsumerWidget {
  const StarListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncStarList = ref.watch(starListSteamProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('TabiMap'),
      ),
      body: asyncStarList.when(
        data: (data) {
          final documents = data.docs;
          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: EdgeInsets.only(
                  top: 16,
                  right: MediaQuery.of(context).size.width * 0.05,
                  left: MediaQuery.of(context).size.width * 0.05,
                ),
                height: 100,
                width: MediaQuery.of(context).size.width,
                child: Card(
                  elevation: 8,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 24, top: 16),
                        child: Text(
                          maxLines: 1,
                          documents[index]['title'].toString(),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 24),
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                                left: 24, top: 4, right: 4),
                            child: Text(
                              documents[index]['starRating'].toString(),
                              style: const TextStyle(
                                  fontWeight: FontWeight.normal, fontSize: 14),
                            ),
                          ),
                          RatingBar.builder(
                            initialRating: documents[index]['starRating'],
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
                    ],
                  ),
                ),
              );
            },
          );
        },
        error: (e, stackTrace) {
          return Text('error: $e');
        },
        loading: CircularProgressIndicator.new,
      ),
    );
  }
}
