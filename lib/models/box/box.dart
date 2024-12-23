import 'package:quomia/models/box/box_user.dart';
import 'package:quomia/models/box/content.dart';
import 'package:quomia/models/box/dates.dart';
import 'package:quomia/models/box/info.dart';

class Box {
  Info info;
  Content content;
  Dates dates;
  BoxUser user;

  Box(
      {required this.info,
      required this.content,
      required this.dates,
      required this.user});
}
