class TimerComment {
  String username;
  String message;
  DateTime createdAt;

  TimerComment(
      {required this.username, required this.message, required this.createdAt});

  factory TimerComment.fromJson(Map<String, dynamic> json) {
    return TimerComment(
        username: json['username'],
        message: json['message'],
        createdAt: json['createdAt']);
  }
}
