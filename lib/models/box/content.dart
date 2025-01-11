class Content {
  String? message;
  String? filePath;

  Content({this.message, this.filePath});

  factory Content.fromJson(Map<String, dynamic> json) {
    return Content(message: json['message'], filePath: json['filePath']);
  }
}
