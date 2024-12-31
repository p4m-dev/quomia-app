import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:quomia/http/constants.dart';
import 'package:quomia/models/box/box.dart';

class HttpBoxService {
  Future<void> postBox(Box box) async {
    var client = http.Client();
    var baseUrl = Constants.baseUrl;
    var url = Uri.parse("$baseUrl/v1/box");

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
}
