import 'dart:convert';
import 'package:http/http.dart' as http;

class HttpMapboxService {
  Future<Map<String, double>?> getCoordinates(String query) async {
    const accessToken =
        "pk.eyJ1IjoiemFubmE5MjciLCJhIjoiY2toOTAxNXliMHBubDJ4bzh0Y2trNXRoOSJ9.UvaTov5Rw2_ZGJejF91lcg";

    final url =
        "https://api.mapbox.com/geocoding/v5/mapbox.places/${Uri.encodeComponent(query)}.json?access_token=$accessToken&limit=1";

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data["features"].isNotEmpty) {
          final coords = data["features"][0]["geometry"]["coordinates"];
          final double lng = coords[0];
          final double lat = coords[1];

          return {"lng": lng, "lat": lat};
        }
      } else {
        print("Errore geocoding: ${response.body}");
      }
    } catch (e) {
      print("Errore ricerca: $e");
    }
  }
}
