import 'package:quomia/models/box/timer_comment.dart';

class Comments {
  int totalOfComments;
  List<TimerComment> timerComments;

  Comments({required this.totalOfComments, required this.timerComments});

  factory Comments.fromJson(Map<String, dynamic> json) {
    return Comments(
        totalOfComments: json['totalOfComments'],
        timerComments: json['timerComments']);
  }
}
