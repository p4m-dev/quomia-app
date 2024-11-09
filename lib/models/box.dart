import 'package:quomia/models/box_type.dart';
import 'package:quomia/models/user.dart';

class Box {
  User user;
  late String imgUrl;
  int totalLikes;
  int totalComments;
  BoxType boxType;

  Box(
      {required this.user,
      required this.totalLikes,
      required this.totalComments,
      required this.boxType});
}
