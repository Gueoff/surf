import 'dart:developer';
import 'dart:convert';

class ApiResponse {
  int took;
  // bool timedOut;
  //Shards shards;
  //Hits hits;
  List<Suggest> suggest;
  //int status;

  ApiResponse({
    required this.took,
    //required this.timedOut,
    //required this.shards,
    //required this.hits,
    required this.suggest,
    //required this.status,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      took: json['took'],
      //timedOut: json['timed_out'],
      //shards: Shards.fromJson(json['_shards']),
      //hits: Hits.fromJson(json['hits']),
      suggest: (json['suggest']['spot-suggest'] as List<dynamic>)
          .map((e) => Suggest.fromJson(e))
          .toList(),
      //status: json['status'],
    );
  }

  String toString() {
    return 'toString';
    //return 'Api Response ${this.status}';
  }
}

class Shards {
  int total;
  int successful;
  int failed;

  Shards({
    required this.total,
    required this.successful,
    required this.failed,
  });

  factory Shards.fromJson(Map<String, dynamic> json) {
    return Shards(
      total: json['total'],
      successful: json['successful'],
      failed: json['failed'],
    );
  }
}

class Hits {
  int total;
  double maxScore;
  List<Hit> hits;

  Hits({
    required this.total,
    required this.maxScore,
    required this.hits,
  });

  factory Hits.fromJson(Map<String, dynamic> json) {
    var hitsList = json['hits'] as List<dynamic>;
    List<Hit> hits = hitsList.map((e) => Hit.fromJson(e)).toList();

    return Hits(
      total: json['total'],
      maxScore: json['max_score'],
      hits: hits,
    );
  }

  String toString() {
    return 'total: ${total} ${maxScore} ${hits}';
  }
}

class Hit {
  String index;
  String type;
  String id;
  double score;
  Source source;

  Hit({
    required this.index,
    required this.type,
    required this.id,
    required this.score,
    required this.source,
  });

  factory Hit.fromJson(Map<String, dynamic> json) {
    return Hit(
      index: json['_index'],
      type: json['_type'],
      id: json['_id'],
      score: json['_score'],
      source: Source.fromJson(json['_source']),
    );
  }
}

class Source {
  String name;
  Location location;
  String href;

  Source({
    required this.name,
    required this.location,
    required this.href,
  });

  factory Source.fromJson(Map<String, dynamic> json) {
    return Source(
      name: json['name'],
      location: Location.fromJson(json['location']),
      href: json['href'],
    );
  }
}

class Location {
  double longitude;
  double latitude;

  Location({
    required this.longitude,
    required this.latitude,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      longitude: json['lon'],
      latitude: json['lat'],
    );
  }
}

class Suggest {
  String text;
  //int offset;
  //int length;
  List<SuggestOption> options;

  Suggest({
    required this.text,
    //required this.offset,
    //required this.length,
    required this.options,
  });

  factory Suggest.fromJson(Map<String, dynamic> json) {
    var optionsList = json['options'] as List<dynamic>;
    List<SuggestOption> options =
        optionsList.map((e) => SuggestOption.fromJson(e)).toList();

    return Suggest(
      text: json['text'],
      // offset: json['offset'],
      // length: json['length'],
      options: options,
    );
  }

  String toString() {
    return '${text} and options...';
  }
}

class SuggestOption {
  String text;
  // String index;
  String type;
  String id;
  //double score;
  Source source;
  Map<String, dynamic> contexts;

  SuggestOption({
    required this.text,
    //required this.index,
    required this.type,
    required this.id,
    //required this.score,
    required this.source,
    required this.contexts,
  });

  factory SuggestOption.fromJson(Map<String, dynamic> json) {
    return SuggestOption(
      text: json['text'],
      // index: json['_index'],
      type: json['_type'],
      id: json['_id'],
      // score: json['_score'],
      source: Source.fromJson(json['_source']),
      contexts: Map<String, dynamic>.from(json['contexts']),
    );
  }

  String toString() {
    return '${id}: ${text} - ${type}';
  }
}
