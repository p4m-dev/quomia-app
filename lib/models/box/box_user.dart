class BoxUser {
  String sender;
  String? receiver;

  BoxUser({required this.sender, this.receiver});

  factory BoxUser.fromJson(Map<String, dynamic> json) {
    return BoxUser(sender: json['sender'], receiver: json['receiver']);
  }
}
