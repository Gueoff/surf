import 'package:surf/src/entities/location_entity.dart';
import 'package:surf/src/models/suggest_option.dart';

class SourceEntity {
  String name;
  LocationEntity location;
  String href;
  List<dynamic> breadCrumbs;

  SourceEntity({
    required this.name,
    required this.location,
    required this.href,
    required this.breadCrumbs,
  });

  factory SourceEntity.fromJson(Map<String, dynamic> json) {
    return SourceEntity(
      name: json['name'],
      location: LocationEntity.fromJson(json['location']),
      href: json['href'],
      breadCrumbs: json['breadCrumbs'],
    );
  }

  Source toSource() {
    return Source(
        name: name,
        location: location.toLocation(),
        href: href,
        address: breadCrumbs.join(', '));
  }

  @override
  String toString() {
    return 'SourceEntity ($name)';
  }
}

class SuggestOptionEntity {
  String text;
  String type;
  String id;
  SourceEntity source;
  Map<String, dynamic> contexts;

  SuggestOptionEntity({
    required this.text,
    required this.type,
    required this.id,
    required this.source,
    required this.contexts,
  });

  factory SuggestOptionEntity.fromJson(Map<String, dynamic> json) {
    return SuggestOptionEntity(
      text: json['text'],
      type: json['_type'],
      id: json['_id'],
      source: SourceEntity.fromJson(json['_source']),
      contexts: Map<String, dynamic>.from(json['contexts']),
    );
  }

  SuggestOption toSuggestOption() {
    return SuggestOption(
      text: text,
      type: type,
      id: id,
      source: source.toSource(),
      contexts: contexts,
    );
  }

  @override
  String toString() {
    return 'SuggestOptionEntity ($text)';
  }
}

class SuggestEntity {
  String text;
  List<SuggestOptionEntity> options;

  SuggestEntity({
    required this.text,
    required this.options,
  });

  factory SuggestEntity.fromJson(Map<String, dynamic> json) {
    var optionsList = json['options'] as List<dynamic>;
    List<SuggestOptionEntity> options =
        optionsList.map((e) => SuggestOptionEntity.fromJson(e)).toList();

    return SuggestEntity(
      text: json['text'],
      options: options,
    );
  }

  Suggest toSuggest() {
    return Suggest(
      text: text,
      options: options.map((element) => element.toSuggestOption()).toList(),
    );
  }

  @override
  String toString() {
    return 'SuggestEntity ($text : $options)';
  }
}
