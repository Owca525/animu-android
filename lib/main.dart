import 'package:animu/UI/defcard.dart';
import 'package:animu/utils/anilistAPI.dart';
import 'package:animu/utils/class.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Root widget
      home: Scaffold(
        body: FutureBuilder<List<AnimeData>>(
          future: an_allTimePopularAnime(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              final anime = snapshot.data![0];
              return Center(
                child: Defcard(anime: anime),
              );
            } else {
              return const Center(child: Text('Missing'));
            }
          },
        ),
        bottomNavigationBar: NavigationBar(destinations: [
          NavigationDestination(icon: Icon(Icons.home), label: "Home"),
          NavigationDestination(icon: Icon(Icons.list), label: "AnimeList"),
          NavigationDestination(icon: Icon(Icons.history), label: "History"),
          NavigationDestination(icon: Icon(Icons.event), label: "Calendary"),
          NavigationDestination(icon: Icon(Icons.settings), label: "Settings"),
        ]),
      ),
    );
  }
}
