import 'package:animu/UI/defcardv2.dart';
import 'package:flutter/material.dart';
import 'package:animu/UI/defcard.dart';
import 'package:animu/utils/anilistAPI.dart';
import 'package:animu/utils/class.dart';

class AnimeList extends StatelessWidget {
  const AnimeList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(     
          body: FutureBuilder<List<AnimeData>>(
          future: an_allTimePopularAnime(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              final anime = snapshot.data![0];
              return Align(
                alignment: Alignment.topCenter,
                child: Defcardv2(anime: anime),
              );
            } else {
              return const Center(child: Text('Missing'));
            }
          },
        ),
      );
  }
}