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
    _timer = Timer.periodic(const Duration(seconds: 5), (_) {
      if (_pageController.hasClients && _totalPages > 0) {
        _currentPage++;
        if (_currentPage >= _totalPages) _currentPage = 0;
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 2000),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, List<AnimeData>>>(
      future: an_getMainPage(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

        final data = snapshot.data!;
        final List<AnimeData> trending = data['trending'] ?? [];

        if (_totalPages != trending.length) {
          _totalPages = trending.length;
          _currentPage = 0;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (_pageController.hasClients) {
              _pageController.jumpToPage(0);
              _startAutoScroll();
            }
          });
        }

        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.28,
          width: double.infinity,
          child: PageView.builder(
            controller: _pageController,
            itemCount: trending.length,
            itemBuilder: (context, index) {
              final anime = trending[index];
              return Defcardv2(anime: anime);
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

