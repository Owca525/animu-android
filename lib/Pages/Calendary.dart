import 'package:flutter/material.dart';

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
