import 'package:http/http.dart' as http;
import 'package:surf/src/entities/rating_entity.dart';
import 'package:surf/src/entities/tide_entity.dart';
import 'package:surf/src/entities/wave_entity.dart';
import 'package:surf/src/entities/weather_entity.dart';
import 'package:surf/src/models/rating.dart';
import 'package:surf/src/entities/wind_entity.dart';
import 'package:surf/src/models/tide.dart';
import 'package:surf/src/models/wave.dart';
import 'package:surf/src/models/weather.dart';
import 'package:surf/src/models/wind.dart';
import 'package:surf/src/models/api_response.dart';
import 'dart:convert';

class ApiService {
  String endpoint = 'https://services.surfline.com';

  ApiService();

  Future<List<SuggestOption>> searchSpot(String spotId) async {
    final response = await http.get(Uri.parse(
        '$endpoint/search/site?q=$spotId&querySize=6&suggestionSize=6&newsSearch=true'));

    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      if (body is List && body.isNotEmpty) {
        var suggestsDto =
            (body.first['suggest']['spot-suggest'] as List<dynamic>).toList();

        var suggests =
            suggestsDto.map((suggestDto) => Suggest.fromJson(suggestDto));

        return suggests.first.options;
      }

      return [];
    } else {
      throw Exception('Failed to load suggests');
    }
  }

  Future<List<Rating>> getSpotRating(String spotId) async {
    final response = await http.get(Uri.parse(
        '$endpoint/kbyg/spots/forecasts/rating?spotId=$spotId&days=5&intervalHours=1&cacheEnabled=true'));

    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);

      if (body['data']['rating'] is List && body['data']['rating'].isNotEmpty) {
        List<RatingEntity> ratingEntities = (body['data']['rating'] as List)
            .map((entityJson) => RatingEntity.fromJson(entityJson))
            .toList();

        List<Rating> ratings =
            ratingEntities.map((entity) => entity.toRating()).toList();

        return ratings;
      }

      return [];
    } else {
      throw Exception('Failed to load rating');
    }
  }

  Future<List<Tide>> getSpotTides(String spotId) async {
    final response = await http.get(Uri.parse(
        '$endpoint/kbyg/spots/forecasts/tides?spotId=$spotId&days=5&intervalHours=1&&units[tideHeight]=M&cacheEnabled=true'));

    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);

      if (body['data']['tides'] is List && body['data']['tides'].isNotEmpty) {
        List<TideEntity> tideEntities = (body['data']['tides'] as List)
            .map((entityJson) => TideEntity.fromJson(entityJson))
            .toList();

        List<Tide> tides =
            tideEntities.map((entity) => entity.toTide()).toList();

        return tides;
      }

      return [];
    } else {
      throw Exception('Failed to load tides');
    }
  }

  Future<List<Wave>> getSpotWaves(String spotId) async {
    final response = await http.get(Uri.parse(
        '$endpoint/kbyg/spots/forecasts/wave?spotId=$spotId&days=5&intervalHours=1&cacheEnabled=true&units%5BswellHeight%5D=M&units%5BwaveHeight%5D=M'));

    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);

      if (body['data']['wave'] is List && body['data']['wave'].isNotEmpty) {
        List<WaveEntity> waveEntities = (body['data']['wave'] as List)
            .map((entityJson) => WaveEntity.fromJson(entityJson))
            .toList();
        print('ICI NEZGROS');
        List<Wave> waves =
            waveEntities.map((entity) => entity.toWave()).toList();

        return waves;
      }

      return [];
    } else {
      throw Exception('Failed to load waves');
    }
  }

  Future<List<Weather>> getSpotWeather(String spotId) async {
    final response = await http.get(Uri.parse(
        '$endpoint/kbyg/spots/forecasts/weather?spotId=$spotId&days=16&intervalHours=1&cacheEnabled=true&units%5Btemperature%5D=C'));

    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);

      if (body['data']['weather'] is List &&
          body['data']['weather'].isNotEmpty) {
        List<WeatherEntity> weatherEntities = (body['data']['weather'] as List)
            .map((entityJson) => WeatherEntity.fromJson(entityJson))
            .toList();

        List<Weather> weathers =
            weatherEntities.map((entity) => entity.toWeather()).toList();

        return weathers;
      }

      return [];
    } else {
      throw Exception('Failed to load weather');
    }
  }

  Future<List<Wind>> getSpotWind(String spotId) async {
    final response = await http.get(Uri.parse(
        '$endpoint/kbyg/spots/forecasts/wind?spotId=$spotId&days=5&intervalHours=1&units[windSpeed]=KTS&cacheEnabled=true'));

    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);

      if (body['data']['wind'] is List && body['data']['wind'].isNotEmpty) {
        List<WindEntity> windEntities = (body['data']['wind'] as List)
            .map((entityJson) => WindEntity.fromJson(entityJson))
            .toList();

        List<Wind> winds =
            windEntities.map((entity) => entity.toWind()).toList();

        return winds;
      }

      return [];
    } else {
      throw Exception('Failed to load wind');
    }
  }

  Future<Object> getSpotForecasts(String spotId) async {
    bool cacheEnabled = true;

    final responses = await Future.wait([
      http.get(Uri.parse(
          '$endpoint/kbyg/spots/forecasts/rating?spotId=$spotId&days=5&intervalHours=1&cacheEnabled=$cacheEnabled')),
      http.get(Uri.parse(
          '$endpoint/kbyg/spots/forecasts/wave?spotId=$spotId&days=5&intervalHours=1&units[swellHeight]=M&units[waveHeight]=M&cacheEnabled=$cacheEnabled')),
      http.get(Uri.parse(
          '$endpoint/kbyg/spots/forecasts/wind?spotId=$spotId&days=5&intervalHours=1&units[windSpeed]=KTS&cacheEnabled=$cacheEnabled')),
      http.get(Uri.parse(
          '$endpoint/kbyg/spots/forecasts/sunlight?spotId=$spotId&days=5&intervalHours=1&cacheEnabled=$cacheEnabled')),
      http.get(Uri.parse(
          '$endpoint/kbyg/spots/forecasts/tides?spotId=$spotId&days=5&intervalHours=1&&units[tideHeight]=M&cacheEnabled=$cacheEnabled')),
      http.get(Uri.parse(
          '$endpoint/kbyg/spots/forecasts/weather?spotId=$spotId&days=5&intervalHours=1&units[temperature]=C&cacheEnabled=$cacheEnabled')),
    ]);

    if (responses[0].statusCode == 200) {
      var body = jsonDecode(responses[0].body);

      if (body['data']['rating'] is List && body['data']['rating'].isNotEmpty) {
        List<RatingEntity> ratingEntities = (body['data']['rating'] as List)
            .map((entityJson) => RatingEntity.fromJson(entityJson))
            .toList();

        List<Rating> ratings =
            ratingEntities.map((entity) => entity.toRating()).toList();

        return ratings;
      }

      return [];
    } else {
      throw Exception('Failed to load forecasts');
    }
  }
}

// https://services.surfline.com/kbyg/spots/details?spotId=5842041f4e65fad6a7708c8b
// https://services.surfline.com/kbyg/spots/forecasts/rating?spotId=584204204e65fad6a770901d&days=5&intervalHours=1&cacheEnabled=true
// https://services.surfline.com/kbyg/spots/forecasts/wave?spotId=584204204e65fad6a770901d&days=5&intervalHours=1&cacheEnabled=true&units%5BswellHeight%5D=M&units%5BwaveHeight%5D=M
// https://services.surfline.com/kbyg/spots/forecasts/wind?spotId=584204204e65fad6a770901d&days=5&intervalHours=1&corrected=false&cacheEnabled=true&units%5BwindSpeed%5D=KTS
// https://services.surfline.com/kbyg/spots/forecasts/sunlight?spotId=584204204e65fad6a770901d&days=16&intervalHours=1
// https://services.surfline.com/kbyg/spots/forecasts/tides?spotId=584204204e65fad6a770901d&days=6&cacheEnabled=true&units%5BtideHeight%5D=M
// https://services.surfline.com/kbyg/spots/forecasts/weather?spotId=584204204e65fad6a770901d&days=16&intervalHours=1&cacheEnabled=true&units%5Btemperature%5D=C

// https://services.surfline.com/kbyg/buoys/nearby?cacheEnabled=true&units[swellHeight]=M&latitude=46.687&longitude=-1.942&limit=10&distance=200
// https://services.surfline.com/kbyg/events/taxonomy?id=584204204e65fad6a770901d&type=spot
// https://services.surfline.com/kbyg/regions/forecasts/conditions?subregionId=58581a836630e24c448790a7&days=5
