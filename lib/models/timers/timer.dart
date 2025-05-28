class Timer {
  final String username;
  final String location;
  final String avatar;

  const Timer(
      {required this.username, required this.location, required this.avatar});

  factory Timer.fromJson(Map<String, dynamic> json) {
    return Timer(
        username: json['username'],
        location: json['location'],
        avatar: json['avatar']);
  }
}
