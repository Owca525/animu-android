import 'package:animu/utils/class.dart';
import 'package:flutter/material.dart';

class Defcard extends StatelessWidget {
  final AnimeData anime;

  const Defcard({Key? key, required this.anime}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 115,
      height: 205,
      padding: EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(anime.coverImage ?? "", fit: BoxFit.fill, height: 150,),
          ),
          SizedBox(height: 8),
          Text(
            anime.title.romaji,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 14,
              fontStyle: FontStyle.normal,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
