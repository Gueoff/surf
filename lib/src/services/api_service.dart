import 'package:http/http.dart' as http;
import 'package:surf/src/models/api_response.dart';
import 'dart:convert';

class ApiService {
  final String endpoint;

  const ApiService({
    required this.endpoint,
  });

  Future<List<SuggestOption>> searchSpot(String spot) async {
    final response = await http.get(Uri.parse(
        'https://services.surfline.com/search/site?q=${spot}&querySize=10&suggestionSize=10&newsSearch=true'));

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
}

// https://services.surfline.com/kbyg/spots/forecasts/rating?spotId=584204204e65fad6a770901d&days=5&intervalHours=1&cacheEnabled=true
// https://services.surfline.com/kbyg/regions/forecasts/conditions?subregionId=58581a836630e24c448790a7&days=5
// https://services.surfline.com/kbyg/spots/forecasts/wave?spotId=584204204e65fad6a770901d&days=5&intervalHours=1&cacheEnabled=true&units%5BswellHeight%5D=M&units%5BwaveHeight%5D=M
// https://services.surfline.com/kbyg/spots/forecasts/wind?spotId=584204204e65fad6a770901d&days=5&intervalHours=1&corrected=false&cacheEnabled=true&units%5BwindSpeed%5D=KTS
// https://services.surfline.com/kbyg/spots/forecasts/sunlight?spotId=584204204e65fad6a770901d&days=16&intervalHours=1
// https://services.surfline.com/kbyg/spots/forecasts/tides?spotId=584204204e65fad6a770901d&days=6&cacheEnabled=true&units%5BtideHeight%5D=M
// https://services.surfline.com/kbyg/spots/forecasts/weather?spotId=584204204e65fad6a770901d&days=16&intervalHours=1&cacheEnabled=true&units%5Btemperature%5D=C
// https://services.surfline.com/kbyg/buoys/nearby?cacheEnabled=true&units[swellHeight]=M&latitude=46.687&longitude=-1.942&limit=10&distance=200
// https://services.surfline.com/kbyg/events/taxonomy?id=584204204e65fad6a770901d&type=spot