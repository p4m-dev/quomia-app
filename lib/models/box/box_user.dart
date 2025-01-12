class BoxUser {
  String sender;
  String? receiver;
  String location;

  BoxUser({required this.sender, this.receiver, required this.location});

  factory BoxUser.fromJson(Map<String, dynamic> json) {
    return BoxUser(
        sender: json['sender'],
        receiver: json['receiver'],
        location: json['location']);
  }
}
