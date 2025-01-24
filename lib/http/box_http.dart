import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:quomia/http/constants.dart';
import 'package:quomia/models/box/box.dart';
import 'package:quomia/models/box/request/box_request.dart';

class HttpBoxService {
  Future<void> createBox(BoxRequest boxRequest, String url) async {
    var client = http.Client();
    var uri = Uri.parse(url);

    try {
      final response = await client.post(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(boxRequest),
      );

      if (response.statusCode != 201) {
        throw Exception('Failed to post data');
      }

      final responseData = jsonDecode(response.body);
      print(responseData);
    } catch (e) {
      print(e);
      throw Exception(e);
    } finally {
      client.close();
    }
  }

  Future<List<Box>> fetchSocialBoxes() async {
    var client = http.Client();
    var baseUrl = Constants.baseUrl;
    var url = Uri.parse("$baseUrl/box/social");

    try {
      final response = await client.get(url);

      if (response.statusCode != 200) {
        throw Exception('Failed to load boxes');
      }

      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);

      final List<dynamic> socialBoxes = jsonResponse['boxes'];

      return socialBoxes.map((json) => Box.fromJson(json)).toList();
    } catch (e) {
      print(e);
      return List.empty();
    } finally {
      client.close();
    }
  }
}
