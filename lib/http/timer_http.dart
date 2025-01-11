import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:quomia/models/box/timer.dart';

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
}
