import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:quomia/http/constants.dart';
import 'package:quomia/models/box/box.dart';

class HttpBoxService {
  Future<void> postBox(Box box) async {
    var client = http.Client();
    var baseUrl = Constants.baseUrl;
    var url = Uri.parse("$baseUrl/v1/box/social");

    try {
      final response = await client.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: box,
      );

      if (response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        print(responseData);
      } else {
        throw Exception('Failed to post data');
      }
    } catch (e) {
      print(e);
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

      final socialBoxes = jsonResponse['boxes'];

      List<Box> boxes = socialBoxes.map((json) => Box.fromJson(json)).toList();

      return boxes;
    } catch (e) {
      print(e);
      return List.empty();
    } finally {
      client.close();
    }
  }
}
