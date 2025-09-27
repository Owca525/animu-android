import 'package:animu/utils/class.dart';
import 'package:flutter/material.dart';

class Defcard extends StatelessWidget {
  final AnimeData anime;

  const Defcard({Key? key, required this.anime}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.height * 0.12,
      height: MediaQuery.of(context).size.height * 0.22,
      padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.006),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(anime.coverImage ?? "", fit: BoxFit.fill, height: MediaQuery.of(context).size.height * 0.16),
          ),
          SizedBox(height: 4),
          Text(
            anime.title.romaji,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.height * 0.015,
              fontStyle: FontStyle.normal,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
