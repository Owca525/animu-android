import 'package:animu/UI/defcard.dart';
import 'package:animu/utils/anilistAPI.dart';
import 'package:animu/utils/class.dart';
import 'package:flutter/material.dart';
import 'package:animu/UI/TrendingCarousel.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(     
        child: Column(
          children: [
            Padding(padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.0),
              child: Stack(
                children: [
                  TrendingCarousel(),
                  Padding(padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.1, vertical: MediaQuery.of(context).size.width * 0.1),
                    child: SearchBar(
                      trailing: [
                        IconButton(
                          icon: const Icon(Icons.search, color: Colors.white70),
                          onPressed: () {
                    
                          },
                        ),
                      ],
                      textStyle: MaterialStateProperty.all(TextStyle(color: Colors.white)),
                      hintText: 'Search...',
                      hintStyle: MaterialStateProperty.all(TextStyle(color: Colors.white)),
                      backgroundColor: WidgetStateProperty.all(Color.fromARGB(101, 0, 0, 0)),
                      elevation: WidgetStateProperty.all(0),
                      side: WidgetStateProperty.all(
                        BorderSide(color: Color.fromARGB(255, 17, 17, 17), width: 1),
                      ),
                    )
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Popular in this Season',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    SizedBox(height: 8),
                    SizedBox(
                      height: 210,
                      child: FutureBuilder<List<AnimeData>>(
                      future: an_thisSeasonPopular(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(child: Text('Error: ${snapshot.error}'));
                        } else if (snapshot.hasData) {
                          final anime = snapshot.data!;
                          return ListView(
                            scrollDirection: Axis.horizontal,
                            children: anime.map((anime) => Padding(padding: const EdgeInsets.only(right: 8.0), child: Defcard(anime: anime),
                            )).toList(),
                          );
                        } else {
                          return const Center(child: Text('Missing'));
                        }
                      },
                    ),)
                  ],
                ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'All Time Popular',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    SizedBox(height: 8),
                    SizedBox(
                      height: 210,
                      child: FutureBuilder<List<AnimeData>>(
                      future: an_allTimePopularAnime(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(child: Text('Error: ${snapshot.error}'));
                        } else if (snapshot.hasData) {
                          final anime = snapshot.data!;
                          return ListView(
                            scrollDirection: Axis.horizontal,
                            children: anime.map((anime) => Padding(padding: const EdgeInsets.only(right: 8.0), child: Defcard(anime: anime),
                            )).toList(),
                          );
                        } else {
                          return const Center(child: Text('Missing'));
                        }
                      },
                    ),)
                  ],
                ),
            ),
          ],
        ),
      )
    );
  }
} 