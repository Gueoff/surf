import 'package:http/http.dart' as http;
import 'package:surf/src/entities/rating_entity.dart';
import 'package:surf/src/entities/suggest_option_entity.dart';
import 'package:surf/src/entities/sunlight_entity.dart';
import 'package:surf/src/entities/surf_entity.dart';
import 'package:surf/src/entities/swell_entity.dart';
import 'package:surf/src/entities/tide_entity.dart';
import 'package:surf/src/entities/water_temperature_entity.dart';
import 'package:surf/src/entities/wave_entity.dart';
import 'package:surf/src/entities/weather_entity.dart';
import 'package:surf/src/models/rating.dart';
import 'package:surf/src/entities/wind_entity.dart';
import 'package:surf/src/models/spot_weather_response.dart';
import 'package:surf/src/models/suggest_option.dart';
import 'package:surf/src/models/sunlight.dart';
import 'package:surf/src/models/surf.dart';
import 'package:surf/src/models/swell.dart';
import 'package:surf/src/models/tide.dart';
import 'package:surf/src/models/unit.dart';
import 'package:surf/src/models/water_temperature.dart';
import 'package:surf/src/models/wave.dart';
import 'package:surf/src/models/weather.dart';
import 'package:surf/src/models/wind.dart';
import 'dart:convert';

// https://services.surfline.com/kbyg/spots/batch?cacheEnabled=true&units%5BswellHeight%5D=M&units%5Btemperature%5D=C&units%5BtideHeight%5D=M&units%5BwaveHeight%5D=M&units%5BwindSpeed%5D=KPH&spotIds=5842041f4e65fad6a7708c8b

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
class ApiService {
  String endpoint = 'https://surf.leaff.me/api';
  int _days = 5;
  int _intervalHours = 3;
  Height _unitHeight = Height.M;
  Temperature _unitTemperature = Temperature.C;
  WindSpeed _unitWindSpeed = WindSpeed.KPH;

  ApiService();

  setDayHours(int value) {
    _days = value;
  }

  setIntervalHours(int value) {
    _intervalHours = value;
  }

  setUnitHeight(Height value) {
    _unitHeight = value;
  }

  setUnitTemperature(Temperature value) {
    _unitTemperature = value;
  }

  setUnitWindSpeed(WindSpeed value) {
    _unitWindSpeed = value;
  }

  Future<List<SuggestOption>> searchSpot(String query) async {
    final response = await http.get(Uri.parse(
        'https://services.surfline.com/search/site?q=$query&querySize=6&suggestionSize=6&newsSearch=true'));
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      if (body is List && body.isNotEmpty) {
        var suggestsDto =
            (body.first['suggest']['spot-suggest'] as List<dynamic>).toList();

        var suggestsEntities =
            suggestsDto.map((suggestDto) => SuggestEntity.fromJson(suggestDto));

        return suggestsEntities.first.options
            .map((c) => c.toSuggestOption())
            .toList();
      }

      return [];
    } else {
      throw Exception('Failed to load suggests');
    }
  }

  Future<WaterTemperature> getSpotWaterTemperature(String spotId) async {
    final response = await http.get(Uri.parse(
        '$endpoint/forecast/surf/$spotId?units[waveHeight]=${_unitHeight.name}&units[swellHeight]=${_unitHeight.name}&units[tideHeight]=${_unitHeight.name}&units[temperature]=${_unitTemperature.name}&units[windSpeed]=${_unitWindSpeed.name}&cacheEnabled=true'));

    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      if (body['data'] is List && body['data'].isNotEmpty) {
        WaterTemperatureEntity waterTemperatureEntity =
            WaterTemperatureEntity.fromJson(body['data'][0]);

        return waterTemperatureEntity.toWaterTemperature();
      }

      return WaterTemperature(min: 0, max: 0);
    } else {
      throw Exception('Failed to load water temperature');
    }
  }

  Future<List<Rating>> getSpotRating(String spotId) async {
    final response = await http.get(Uri.parse(
        '$endpoint/forecast/rating/$spotId?days=$_days&intervalHours=$_intervalHours&cacheEnabled=true'));

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

  Future<List<Surf>> getSpotSurf(String spotId) async {
    final response = await http.get(Uri.parse(
        '$endpoint/forecast/surf/$spotId?days=$_days&intervalHours=$_intervalHours&units[waveHeight]=${_unitHeight.name}&cacheEnabled=true'));

    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);

      if (body['data']['surf'] is List && body['data']['surf'].isNotEmpty) {
        List<SurfEntity> surfEntities = (body['data']['surf'] as List)
            .map((entityJson) => SurfEntity.fromJson(entityJson))
            .toList();

        List<Surf> surfs =
            surfEntities.map((entity) => entity.toSurf()).toList();

        return surfs;
      }

      return [];
    } else {
      throw Exception('Failed to load surfs');
    }
  }

  Future<List<Swell>> getSpotSwells(String spotId) async {
    final response = await http.get(Uri.parse(
        '$endpoint/forecast/swell/$spotId?days=$_days&intervalHours=$_intervalHours&units[swellHeight]=${_unitHeight.name}&cacheEnabled=true'));

    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);

      if (body['data']['swells'] is List && body['data']['swells'].isNotEmpty) {
        List<SwellEntity> swellEntities = (body['data']['swells'] as List)
            .map((entityJson) => SwellEntity.fromJson(entityJson))
            .toList();

        List<Swell> swells =
            swellEntities.map((entity) => entity.toSwell()).toList();

        return swells;
      }

      return [];
    } else {
      throw Exception('Failed to load swells');
    }
  }

  Future<List<Tide>> getSpotTides(String spotId) async {
    final response = await http.get(Uri.parse(
        '$endpoint/forecast/tides/$spotId?days=$_days&intervalHours=$_intervalHours&units[tideHeight]=${_unitHeight.name}&cacheEnabled=true'));

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
        '$endpoint/forecast/wave/$spotId?days=$_days&intervalHours=$_intervalHours&units[swellHeight]=${_unitHeight.name}&units[waveHeight]=${_unitHeight.name}&cacheEnabled=true'));

    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);

      if (body['data']['wave'] is List && body['data']['wave'].isNotEmpty) {
        List<WaveEntity> waveEntities = (body['data']['wave'] as List)
            .map((entityJson) => WaveEntity.fromJson(entityJson))
            .toList();

        List<Wave> waves =
            waveEntities.map((entity) => entity.toWave()).toList();

        return waves;
      }

      return [];
    } else {
      throw Exception('Failed to load waves');
    }
  }

  Future<SpotWeatherResponse> getSpotWeather(String spotId) async {
    final response = await http.get(Uri.parse(
        '$endpoint/forecast/weather/$spotId?days=$_days&intervalHours=$_intervalHours&units[temperature]=${_unitTemperature.name}&cacheEnabled=true'));
    late List<Weather> weathers;
    late List<Sunlight> sunlights;

    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);

      if (body['data']['weather'] is List &&
          body['data']['weather'].isNotEmpty) {
        List<WeatherEntity> weatherEntities = (body['data']['weather'] as List)
            .map((entityJson) => WeatherEntity.fromJson(entityJson))
            .toList();

        weathers = weatherEntities.map((entity) => entity.toWeather()).toList();
      }

      if (body['data']['sunlightTimes'] is List &&
          body['data']['sunlightTimes'].isNotEmpty) {
        List<SunlightEntity> sunlightEntities =
            (body['data']['sunlightTimes'] as List)
                .map((entityJson) => SunlightEntity.fromJson(entityJson))
                .toList();

        sunlights =
            sunlightEntities.map((entity) => entity.toSunlight()).toList();
      }

      return SpotWeatherResponse(sunlight: sunlights, weather: weathers);
    } else {
      throw Exception('Failed to load weather');
    }
  }

  Future<List<Wind>> getSpotWind(String spotId) async {
    final response = await http.get(Uri.parse(
        '$endpoint/forecast/wind/$spotId?days=$_days&intervalHours=$_intervalHours&units[windSpeed]=${_unitWindSpeed.name}&cacheEnabled=true'));

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
}
