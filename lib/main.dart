import 'package:flutter/material.dart';
import 'Pages/Home.dart';
import 'Pages/AnimeList.dart';
import 'Pages/History.dart';
import 'Pages/Calendary.dart';
import 'Pages/Settings.dart';
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
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home", backgroundColor: Color.fromARGB(255, 23, 23, 23), ),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "AnimeList", backgroundColor: Color.fromARGB(255, 23, 23, 23)),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: "History", backgroundColor: Color.fromARGB(255, 23, 23, 23)),
          BottomNavigationBarItem(icon: Icon(Icons.event), label: "Calendary", backgroundColor: Color.fromARGB(255, 23, 23, 23)),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings", backgroundColor: Color.fromARGB(255, 23, 23, 23)),        
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

 


