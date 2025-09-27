import 'dart:ui';

import 'package:animu/utils/class.dart';
import 'package:flutter/material.dart';

class Defcardv2 extends StatelessWidget {
  final AnimeData anime;

  const Defcardv2({Key? key, required this.anime}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.4,
      child: Stack(
        children: [
          // Banner
          ClipRRect(
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 2, sigmaY: 3),
                child: Image.network(
                  anime.bannerImage ?? "",
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                  Transform.scale(
                    scale: MediaQuery.of(context).size.height * 0.003,
                    child: Image.network(
                      anime.coverImage ?? "",
                      width: MediaQuery.of(context).size.width,
                    )
                  )    
                ),
              ),
          ),

          // Gradient
          Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Color.fromARGB(159, 17, 17, 17),
                  Color.fromARGB(193, 17, 17, 17),
                  Color.fromARGB(255, 17, 17, 17),
                ],
              ),
            ),
          ),

          // Cover + Tekst
          Padding(
            padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.06, right: MediaQuery.of(context).size.width * 0.02, bottom: MediaQuery.of(context).size.height * 0.02, top: MediaQuery.of(context).size.height * 0.13),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Cover Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    anime.coverImage ?? "",
                    width: MediaQuery.of(context).size.width * 0.21,
                    height: MediaQuery.of(context).size.height * 0.28,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        Container(width: MediaQuery.of(context).size.width * 0.21, height: MediaQuery.of(context).size.height * 0.28, color: const Color.fromARGB(255, 105, 105, 105)),
                  ),
                ),

                SizedBox(width: MediaQuery.of(context).size.width * 0.04),

                // Tekst
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        anime.title.romaji,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: MediaQuery.of(context).size.height * 0.02,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.008),
                      Text(
                        anime.title.english ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: MediaQuery.of(context).size.height * 0.015,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
