import 'package:animu/UI/defcard.dart';
import 'package:animu/utils/anilistAPI.dart';
import 'package:animu/utils/class.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}
class Homepage extends StatefulWidget {
   const Homepage({super.key});

   @override
  State<Homepage> createState() => _Homepage();
}
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Root widget
      home: Homepage()
    );
  }
}
class _Homepage extends State<Homepage> {
  int _currentIndex = 0;
  List<Widget> pages = [
    Home(),
    AnimeList(),
    History(),
    Calendary(),
    Settings()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: pages[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home", backgroundColor: Color.fromARGB(255, 0, 0, 0), ),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "AnimeList", backgroundColor: Color.fromARGB(255, 0, 0, 0)),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: "History", backgroundColor: Color.fromARGB(255, 0, 0, 0)),
          BottomNavigationBarItem(icon: Icon(Icons.event), label: "Calendary", backgroundColor: Color.fromARGB(255, 0, 0, 0)),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings", backgroundColor: Color.fromARGB(255, 0, 0, 0)),        
        ],
        selectedItemColor: Color.fromARGB(255, 255, 255, 255),
        currentIndex: _currentIndex,
        onTap: (index){
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      backgroundColor: Color.fromARGB(255, 228, 204, 99),
    );
  }
} 
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
              return Center(
                child: Defcard(anime: anime),
              );
            } else {
              return const Center(child: Text('Missing'));
            }
          },
        ),
    );
  }
} 
class History extends StatelessWidget {
  const History({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
      ),
      backgroundColor: Color.fromARGB(255, 18, 201, 110),
    );
  }
} 
class Calendary extends StatelessWidget {
  const Calendary({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar'),
      ),
      backgroundColor: Color.fromARGB(255, 151, 52, 218),
    );
  }
} 
class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      backgroundColor: Color.fromARGB(255, 27, 221, 255),
    );
  }
} 
