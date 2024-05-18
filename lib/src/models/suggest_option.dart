import 'package:surf/src/models/location.dart';

class Source {
  String name;
  Location location;
  String href;
  String address;

  Source({
    required this.name,
    required this.location,
    required this.href,
    required this.address,
  });

  factory Source.fromJson(Map<String, dynamic> json) {
    return Source(
      name: json['name'],
      location: Location.fromJson(json['location']),
      href: json['href'],
      address: json['address'],
    );
  }
}

class SuggestOption {
  String text;
  String type;
  String id;
  Source source;
  Map<String, dynamic> contexts;

  SuggestOption({
    required this.text,
    required this.type,
    required this.id,
    required this.source,
    required this.contexts,
  });

  factory SuggestOption.fromJson(Map<String, dynamic> json) {
    return SuggestOption(
      text: json['text'],
      type: json['_type'],
      id: json['_id'],
      source: Source.fromJson(json['_source']),
      contexts: Map<String, dynamic>.from(json['contexts']),
    );
  }

  String toString() {
    return 'SuggestOption($text $id)';
  }
}

class Suggest {
  String text;
  List<SuggestOption> options;

  Suggest({
    required this.text,
    required this.options,
  });

  factory Suggest.fromJson(Map<String, dynamic> json) {
    var optionsList = json['options'] as List<dynamic>;
    List<SuggestOption> options =
        optionsList.map((e) => SuggestOption.fromJson(e)).toList();

    return Suggest(
      text: json['text'],
      options: options,
    );
  }
}
