import 'package:flutter/material.dart';

class Defcard extends StatelessWidget {
  final String imageUrl;
  final String title;

    const Defcard({
      Key? key,
      required this.imageUrl,
      required this.title,
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp( // Root widget
      home: Scaffold(      
        body: Container(
        width: 150,
        height: 248,
        padding: EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: const Color.fromARGB(255, 0, 0, 0),
          ),
            child: Column(
              children: [
                ClipRRect(
                borderRadius: BorderRadius.circular(16), // round all corners
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                Text(               
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14,
                    fontStyle: FontStyle.normal,
                    color: Colors.white
                  ),
                )
              ],
            ),
        ),
      ),
    );
  }
}