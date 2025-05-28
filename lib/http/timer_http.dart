import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:quomia/http/constants.dart';
import 'package:quomia/models/box/box.dart';
import 'package:quomia/models/crypto/balance.dart';
import 'package:quomia/models/timers/timer.dart';

class HttpTimerService {
  Future<List<Timer>> fetchTimers() async {
    final url = Uri.parse('https://api-arluua2rla-ey.a.run.app/timers');
    final response = await http.get(url);
    print('Response: $response');

    if (response.statusCode != 200) {
      throw Exception('Failed to load boxes');
    }

    final Map<String, dynamic> jsonResponse = jsonDecode(response.body);

    final List<dynamic> timersList = jsonResponse['timers'];

    return timersList.take(20).map((json) => Timer.fromJson(json)).toList();
  }

  Future<List<Box>> fetchBoxesByType(String username, String boxType) async {
    var client = http.Client();
    var baseUrl = Constants.baseUrl;
    var url = Uri.parse("$baseUrl/timers?username=$username&boxType=$boxType");

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

  Future<Balance?> fetchCryptoBalance() async {
    var client = http.Client();
    var baseUrl = Constants.baseUrl;
    var url = Uri.parse("$baseUrl/user/balance");

    try {
      final response = await client.get(url);

      if (response.statusCode != 200) {
        throw Exception('Failed to load boxes');
      }

      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);

      return Balance.fromJson(jsonResponse['balance']);
    } catch (e) {
      print(e);
      return null;
    } finally {
      client.close();
    }
  }
}
