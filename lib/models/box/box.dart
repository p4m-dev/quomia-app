import 'package:quomia/models/box/box_user.dart';
import 'package:quomia/models/box/content.dart';
import 'package:quomia/models/box/dates.dart';
import 'package:quomia/models/box/info.dart';
import 'package:quomia/models/box/nft.dart';
import 'package:quomia/models/box/location.dart';

class Box {
  Info info;
  Content content;
  Dates dates;
  BoxUser user;
  NFT nft;
  Location location;

  Box(
      {required this.info,
      required this.content,
      required this.dates,
      required this.user,
      required this.nft,
      required this.location});

  factory Box.fromJson(Map<String, dynamic> json) {
    return Box(
        info: Info.fromJson(json['info']),
        content: Content.fromJson(json['content']),
        dates: Dates.fromJson(json['dates']),
        user: BoxUser.fromJson(json['user']),
        nft: NFT.fromJson(json['nft']),
        location: Location.fromJson(json['location']));
  }
}
