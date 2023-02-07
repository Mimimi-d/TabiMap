import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:spring_button/spring_button.dart';

import '../../provider/add_marker_provider.dart';

class CardEditPage extends ConsumerWidget {
  const CardEditPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titleControllerProvider =
        ref.watch(titleControllerStateProvider.state);
    final titleDetailControllerProvider =
        ref.watch(titleDescriptionControllerStateProvider.state);
    final markerRepository = ref.watch(markersRepositoryProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('TabiMap'),
      ),
      body: Center(
        child: Container(
          height: 400,
          padding: const EdgeInsets.only(top: 32, left: 24, right: 24),
          child: Column(
            children: [
              const Text(
                "編集",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: titleControllerProvider.state,
                decoration: InputDecoration(
                  hintText: 'タイトル',
                  hintStyle: const TextStyle(fontSize: 16, color: Colors.black),
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
                  hintText: '感想',
                  hintStyle: const TextStyle(fontSize: 16, color: Colors.black),
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
                initialRating: 0,
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
                        '投稿',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  onTap: () {},
                  onLongPress: null,
                  onLongPressEnd: null,
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add,
        ),
        onPressed: () {
          context.pop();
        },
      ),
    );
  }
}
