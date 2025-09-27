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
      backgroundColor: const Color.fromARGB(255, 17, 17, 17),
      body: SingleChildScrollView(     
        child: Column(
          children: [
            Padding(padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.0),
              child: Stack(
                children: [
                  TrendingCarousel(),
                  Padding(padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.1, vertical: MediaQuery.of(context).size.height * 0.055),
                    child: SearchBar(
                      trailing: [
                        IconButton(
                          icon: const Icon(Icons.search, color: Colors.white70),
                          onPressed: () {
                            
                          },
                        ),
                      ],
                      textStyle: WidgetStateProperty.all(TextStyle(color: Colors.white)),
                      hintText: 'Search...',
                      hintStyle: WidgetStateProperty.all(TextStyle(color: Colors.white)),
                      backgroundColor: WidgetStateProperty.all(Color.fromARGB(101, 0, 0, 0)),
                      elevation: WidgetStateProperty.all(0),
                      side: WidgetStateProperty.all(
                        BorderSide(color: Color.fromARGB(255, 31, 31, 31), width: MediaQuery.of(context).size.width * 0.005),
                      ),
                    )
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.03, vertical: MediaQuery.of(context).size.height * 0.01),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Popular in this Season',
                      style: TextStyle(fontSize: MediaQuery.of(context).size.height * 0.024, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.22,
                      child: FutureBuilder<Map<String, List<AnimeData>>>(
                        future: an_getMainPage(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(child: Text('Error: ${snapshot.error}'));
                          } else if (snapshot.hasData) {
                            final data = snapshot.data!;
                            final seasonPopular = data["seasonPopular"] ?? [];
                            return ListView(
                              scrollDirection: Axis.horizontal,
                              children: seasonPopular.map((anime) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.01),
                                  child: Defcard(anime: anime),
                                );
                              }).toList(),
                            );
                          } else {
                            return const Center(child: Text('Missing'));
                          }
                        },
                      ),
                    )
                  ],
                ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.03, vertical: MediaQuery.of(context).size.height * 0.01),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'All Time Popular',
                      style: TextStyle(fontSize: MediaQuery.of(context).size.height * 0.024, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.22,
                      child: FutureBuilder<Map<String, List<AnimeData>>>(
                        future: an_getMainPage(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(child: Text('Error: ${snapshot.error}'));
                          } else if (snapshot.hasData) {
                            final data = snapshot.data!;
                            final seasonPopular = data["allTime"] ?? [];
                            return ListView(
                              scrollDirection: Axis.horizontal,
                              children: seasonPopular.map((anime) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.01),
                                  child: Defcard(anime: anime),
                                );
                              }).toList(),
                            );
                          } else {
                            return const Center(child: Text('Missing'));
                          }
                        },
                      ),
                    )
                  ],
                ),
            ),
          ],
        ),
      )
    );
  }
} 