import 'package:quomia/models/box/timer_comment.dart';

class Comments {
  int totalOfComments;
  List<TimerComment> timerComments;

  Comments({required this.totalOfComments, required this.timerComments});

  factory Comments.fromJson(Map<String, dynamic> json) {
    var list = json['timerComments'] as List;
    List<TimerComment> timerComments =
        list.map((i) => TimerComment.fromJson(i)).toList();

    return Comments(
        totalOfComments: json['totalOfComments'], timerComments: timerComments);
  }
}
