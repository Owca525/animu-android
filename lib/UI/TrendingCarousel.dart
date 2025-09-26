import 'dart:async';
import 'package:flutter/material.dart';
import 'package:animu/utils/class.dart';
import 'package:animu/utils/anilistAPI.dart';
import 'defcardv2.dart';

class TrendingCarousel extends StatefulWidget {
  const TrendingCarousel({super.key});

  @override
  State<TrendingCarousel> createState() => _TrendingCarouselState();
}

class _TrendingCarouselState extends State<TrendingCarousel> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  int _totalPages = 0;
  Timer? _timer;

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoScroll() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (_pageController.hasClients && _totalPages > 0) {
        _currentPage++;
        if (_currentPage >= _totalPages) _currentPage = 0;
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 3000),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<AnimeData>>(
      future: an_trendingNow(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

        final animeList = snapshot.data!;

        if (_totalPages != animeList.length) {
          _totalPages = animeList.length;
          _currentPage = 0;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (_pageController.hasClients) {
              _pageController.jumpToPage(0);
              _startAutoScroll();
            }
          });
        }

        return SizedBox(
          height: 220,
          width: double.infinity,
          child: PageView.builder(
            controller: _pageController,
            itemCount: animeList.length,
            itemBuilder: (context, index) {
              return Defcardv2(anime: animeList[index]);
            },
            onPageChanged: (index) {
              _currentPage = index;
            },
          ),
        );
      },
    );
  }
}

