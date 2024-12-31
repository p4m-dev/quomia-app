import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:quomia/models/box/timer.dart';

class HttpTimerService {
  Future<List<Timer>> fetchTimers() async {
    final url = Uri.parse('https://jsonplaceholder.typicode.com/photos');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.take(20).map((json) => Timer.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load boxes');
    }
  }
}
