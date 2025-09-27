import 'dart:convert';
import 'package:animu/utils/class.dart';
import 'package:http/http.dart' as http;
const String graphicApi = r'''
query(
  $page: Int = 1,
  $id: Int,
  $type: MediaType,
  $isAdult: Boolean = false,
  $search: String,
  $format: [MediaFormat],
  $status: MediaStatus,
  $countryOfOrigin: CountryCode,
  $source: MediaSource,
  $season: MediaSeason,
  $seasonYear: Int,
  $year: String,
  $onList: Boolean,
  $yearLesser: FuzzyDateInt,
  $yearGreater: FuzzyDateInt,
  $episodeLesser: Int,
  $episodeGreater: Int,
  $durationLesser: Int,
  $durationGreater: Int,
  $chapterLesser: Int,
  $chapterGreater: Int,
  $volumeLesser: Int,
  $volumeGreater: Int,
  $licensedBy: [Int],
  $isLicensed: Boolean,
  $genres: [String],
  $excludedGenres: [String],
  $tags: [String],
  $excludedTags: [String],
  $minimumTagRank: Int,
  $sort: [MediaSort] = [POPULARITY_DESC, SCORE_DESC]
) {
  Page(page: $page, perPage: 15) {
    pageInfo {
      total
      perPage
      currentPage
      lastPage
      hasNextPage
    }
    media(
      id: $id,
      type: $type,
      season: $season,
      format_in: $format,
      status: $status,
      countryOfOrigin: $countryOfOrigin,
      source: $source,
      search: $search,
      onList: $onList,
      seasonYear: $seasonYear,
      startDate_like: $year,
      startDate_lesser: $yearLesser,
      startDate_greater: $yearGreater,
      episodes_lesser: $episodeLesser,
      episodes_greater: $episodeGreater,
      duration_lesser: $durationLesser,
      duration_greater: $durationGreater,
      chapters_lesser: $chapterLesser,
      chapters_greater: $chapterGreater,
      volumes_lesser: $volumeLesser,
      volumes_greater: $volumeGreater,
      licensedById_in: $licensedBy,
      isLicensed: $isLicensed,
      genre_in: $genres,
      genre_not_in: $excludedGenres,
      tag_in: $tags,
      tag_not_in: $excludedTags,
      minimumTagRank: $minimumTagRank,
      sort: $sort,
      isAdult: $isAdult
    ) {
      id
      title {
        english
        romaji
        native
      }
      coverImage {
        extraLarge
        large
      }
      startDate {
        year
        month
        day
      }
      endDate {
        year
        month
        day
      }
      bannerImage
      season
      seasonYear
      description
      type
      format
      status(version: 2)
      episodes
      duration
      genres
      source
      averageScore
      trailer {
        id
        site
      }
      nextAiringEpisode {
        airingAt
        timeUntilAiring
        episode
      }
      characters(perPage: 10) {
        edges {
          role
          node {
            id
            name {
              full
            }
            image {
              large
            }
          }
          voiceActors(language: JAPANESE) {
            id
            name {
              full
            }
            language
            image {
              large
            }
          }
        }
      }
      studios(isMain: true) {
        edges {
          isMain
          node {
            id
            name
          }
        }
      }
    }
  }
}
''';

const String graphicMainPageApi = r'''
  query (
    $season: MediaSeason,
    $seasonYear: Int,
  ) {
    trending: Page(page: 1, perPage: 15) {
      media(sort: TRENDING_DESC, type: ANIME, isAdult: false) {
        ...media
      }
    }
    season: Page(page: 1, perPage: 15) {
      media(season: $season, seasonYear: $seasonYear, sort: POPULARITY_DESC, type: ANIME, isAdult: false) {
        ...media
      }
    }
    popular: Page(page: 1, perPage: 15) {
      media(sort: POPULARITY_DESC, type: ANIME, isAdult: false) {
        ...media
      }
    }
  }

  fragment media on Media {
    id
    title { english romaji native }
    coverImage { extraLarge large }
    startDate { year month day }
    endDate { year month day }
    bannerImage
    season
    seasonYear
    description
    type
    format
    source
    status(version: 2)
    episodes
    duration
    genres
    averageScore
    popularity
    trailer {
      id
      site
    }
    nextAiringEpisode {
      airingAt
      timeUntilAiring
      episode
    }
    characters(perPage: 10) {
      edges {
        role
        node {
          id
          name {
            full
          }
          image {
            large
          }
        }
        voiceActors(language: JAPANESE) {
          id
          name {
            full
          }
          language
          image {
            large
          }
        }
      }
    }
    studios(isMain: true) {
      edges {
        isMain
        node { id name }
      }
    }
  }
''';


Future<Map<String, dynamic>> sendGraphQL(String query, Map<String, dynamic> variables) async {
  final url = Uri.parse("https://graphql.anilist.co");

  final body = jsonEncode({
    "query": query,
    "variables": variables,
  });

  final response = await http.post(
    url,
    headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
    },
    body: body,
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return { "succes": true, "data": data };
  } else {
    print("error: ${response.statusCode}");
    return { "succes": false, "data": "" };
  }
}

const allPopular = {
  "page": 1,
  "sort": "POPULARITY_DESC",
  "type": "ANIME"
};

const trendingNow = {
  "page": 1,
  "sort": ["TRENDING_DESC", "POPULARITY_DESC"],
  "type": "ANIME"
};

const thisSeasonPopular = {
  "page": 1,
  "season": "SUMMER",
  "seasonYear":	2025,
  "type": "ANIME"
};

Map<String, dynamic> getSeasonFromDate() {
  final now = DateTime.now();
  final month = now.month;
  final year = now.year;
  String season;

  if (month >= 1 && month <= 3) {
    season = "WINTER";
  } else if (month >= 4 && month <= 6) {
    season = "SPRING";
  } else if (month >= 7 && month <= 9) {
    season = "SUMMER";
  } else {
    season = "FALL";
  }

  return {
    "season": season,
    "seasonYear": year,
  };
}

Future<Map<String, List<AnimeData>>> an_getMainPage() async {
  final season = getSeasonFromDate();
  final data = await sendGraphQL(graphicMainPageApi, { "season": season.season, "seasonYear": season.seasonYear });
  if (!data["succes"]) return { "trending": [], "seasonPopular": [], "allTime": [] };

  final trending = (data["data"]["data"]["trending"]["media"] as List)
      .map((e) => AnimeData.fromJson(e))
      .toList();

  final seasonPopular = (data["data"]["data"]["season"]["media"] as List)
      .map((e) => AnimeData.fromJson(e))
      .toList();

  final allTime = (data["data"]["data"]["popular"]["media"] as List)
      .map((e) => AnimeData.fromJson(e))
      .toList();

  return { 
    "trending": trending, 
    "seasonPopular": seasonPopular, 
    "allTime": allTime
  };
}

Future<List<AnimeData>> an_searchApi(String name) async {
  final variables = {
    "page": 1,
    "sort": "SEARCH_MATCH",
    "type": "ANIME",
    "search": name
  };

  final data = await sendGraphQL(graphicApi, variables);
  if (!data["succes"]) return [];
  final animeList = data["data"]["data"]["Page"]["media"] as List<dynamic>;
  List<AnimeData> converted = []; 
  for (var i = 0; i < animeList.length; i++) {
    converted.add(AnimeData.fromJson(animeList[i]));
  }

  return converted;
}

extension on Map<String, dynamic> {
  get seasonYear => null;
  get season => null;
}

