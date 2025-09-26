class Location {
  double longitude;
  double latitude;
  String street;

  Location({
    required this.longitude,
    required this.latitude,
    required this.street,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      longitude: (json['longitude'] as num).toDouble(),
      latitude: (json['latitude'] as num).toDouble(),
      street: json['street'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'longitude': longitude,
      'latitude': latitude,
      'street': street,
    };
  }
}
