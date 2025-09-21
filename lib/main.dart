import 'package:animu/UI/defcard.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

@override
  Widget build(BuildContext context) {
    return MaterialApp( // Root widget
      home: Scaffold(      
        body: Container(
          child: Defcard(
            imageUrl: 'https://s4.anilist.co/file/anilistcdn/media/anime/cover/large/bx178788-zm3gtpB9TpRt.jpg',
            title: 'Kimetsu no Yaiba: Mugenjou-hen Movie 1 - Akaza Sairai'
          ),
        ),
      ),
    );
  }
}
