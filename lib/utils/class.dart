class AnimeData {
  final int? averageScore;
  final String? bannerImage;
  final String? coverImage;
  final String? description;
  final int? duration;

  final DateInfo? endDate;
  final int? episodes;
  final String? format;
  final List<String>? genres;

  final NextAiringEpisode? nextAiringEpisode;
  final int? popularity;
  final String? season;
  final int? seasonYear;
  final DateInfo? startDate;

  final List<CharacterEdge> characters;
  final String? source;
  final String? status;
  final List<String> studios;
  final Title title;
  final String? type;

  final List<EpisodesList>? episodesList;
  final String? playerId;
  final String id;
  final String? malId;
  final Trailer? trailer;

  AnimeData({
    this.averageScore,
    this.bannerImage,
    this.coverImage,
    this.description,
    this.duration,
    this.endDate,
    this.episodes,
    this.format,
    this.genres,
    this.nextAiringEpisode,
    this.popularity,
    this.season,
    this.seasonYear,
    this.startDate,
    required this.characters,
    this.source,
    this.status,
    required this.studios,
    required this.title,
    this.type,
    this.episodesList,
    this.playerId,
    required this.id,
    this.malId,
    this.trailer,
  });

  factory AnimeData.fromJson(Map<String, dynamic> json) {
    return AnimeData(
      averageScore: json['averageScore'],
      bannerImage: json['bannerImage'],
      coverImage: json['coverImage'] != null
          ? json['coverImage']['extraLarge'] ?? json['coverImage']['large']
          : null,
      description: json['description'],
      duration: json['duration'],
      endDate: json['endDate'] != null ? DateInfo.fromJson(json['endDate']) : null,
      episodes: json['episodes'],
      format: json['format'],
      genres: (json['genres'] as List?)?.map((e) => e.toString()).toList(),
      nextAiringEpisode: json['nextAiringEpisode'] != null
          ? NextAiringEpisode.fromJson(json['nextAiringEpisode'])
          : null,
      popularity: json['popularity'],
      season: json['season'],
      seasonYear: json['seasonYear'],
      startDate: json['startDate'] != null ? DateInfo.fromJson(json['startDate']) : null,
      characters: (json['characters']?['edges'] as List? ?? [])
          .map((e) => CharacterEdge.fromJson(e))
          .toList(),
      source: json['source'],
      status: json['status'],
      studios: (json['studios']?['edges'] as List? ?? [])
          .map((e) => e['node']['name'].toString())
          .toList(),
      title: Title.fromJson(json['title']),
      type: json['type'],
      episodesList: (json['episodesList'] as List?)
          ?.map((e) => EpisodesList.fromJson(e))
          .toList(),
      playerId: json['player_ID'],
      id: json['id'].toString(),
      malId: json['malID']?.toString(),
      trailer: json['trailer'] != null ? Trailer.fromJson(json['trailer']) : null,
    );
  }
}

class DateInfo {
  final int? day;
  final int? month;
  final int? year;

  DateInfo({this.day, this.month, this.year});

  factory DateInfo.fromJson(Map<String, dynamic> json) {
    return DateInfo(
      day: json['day'],
      month: json['month'],
      year: json['year'],
    );
  }
}

class NextAiringEpisode {
  final int airingAt;
  final int episode;
  final int timeUntilAiring;

  NextAiringEpisode({
    required this.airingAt,
    required this.episode,
    required this.timeUntilAiring,
  });

  factory NextAiringEpisode.fromJson(Map<String, dynamic> json) {
    return NextAiringEpisode(
      airingAt: json['airingAt'],
      episode: json['episode'],
      timeUntilAiring: json['timeUntilAiring'],
    );
  }
}

class CharacterEdge {
  final String role;
  final Character character;
  final VoiceActor? voiceActor;

  CharacterEdge({
    required this.role,
    required this.character,
    this.voiceActor,
  });

  factory CharacterEdge.fromJson(Map<String, dynamic> json) {
    return CharacterEdge(
      role: json['role'],
      character: Character.fromJson(json['node']),
      voiceActor: (json['voiceActors'] != null && (json['voiceActors'] as List).isNotEmpty)
          ? VoiceActor.fromJson((json['voiceActors'] as List).first)
          : null,
    );
  }
}

class Character {
  final String id;
  final String name;
  final String image;

  Character({required this.id, required this.name, required this.image});

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      id: json['id'].toString(),
      name: json['name']['full'],
      image: json['image']['large'],
    );
  }
}

class VoiceActor {
  final String id;
  final String name;
  final String image;

  VoiceActor({required this.id, required this.name, required this.image});

  factory VoiceActor.fromJson(Map<String, dynamic> json) {
    return VoiceActor(
      id: json['id'].toString(),
      name: json['name']['full'],
      image: json['image']['large'],
    );
  }
}

class Title {
  final String? english;
  final String native;
  final String romaji;

  Title({this.english, required this.native, required this.romaji});

  factory Title.fromJson(Map<String, dynamic> json) {
    return Title(
      english: json['english'],
      native: json['native'],
      romaji: json['romaji'],
    );
  }
}

class EpisodesList {
  final List<Episode> episodes;
  final String type;
  final String? name;

  EpisodesList({required this.episodes, required this.type, this.name});

  factory EpisodesList.fromJson(Map<String, dynamic> json) {
    return EpisodesList(
      episodes: (json['episodes'] as List)
          .map((e) => Episode.fromJson(e))
          .toList(),
      type: json['type'],
      name: json['name'],
    );
  }
}

class Episode {
  final String ep;
  final String? img;
  final String? title;

  Episode({required this.ep, this.img, this.title});

  factory Episode.fromJson(Map<String, dynamic> json) {
    return Episode(
      ep: json['ep'],
      img: json['img'],
      title: json['title'],
    );
  }
}

class Trailer {
  final String id;
  final String site;

  Trailer({required this.id, required this.site});

  factory Trailer.fromJson(Map<String, dynamic> json) {
    return Trailer(
      id: json['id'],
      site: json['site'],
    );
  }
}

class CoverImage {
  final String url;

  CoverImage({required this.url});

  factory CoverImage.fromJson(Map<String, dynamic> json) {
    return CoverImage(
      url: json['extraLarge'] ?? json['large'] ?? '',
    );
  }
}