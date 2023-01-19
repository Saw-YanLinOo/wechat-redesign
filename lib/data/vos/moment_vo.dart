// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:wechat_redesign/persistence/hive_constants.dart';

part 'moment_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_MOMENT_VO, adapterName: 'MomentVOAdaptor')
class MomentVO {
  @HiveField(0)
  @JsonKey(name: 'id')
  String? id;

  @HiveField(1)
  @JsonKey(name: 'description')
  String? description;

  @HiveField(2)
  @JsonKey(name: 'post_images')
  List<String>? postImages;

  @HiveField(3)
  @JsonKey(name: 'profile_picture')
  String? profilePicture;

  @HiveField(4)
  @JsonKey(name: 'user_name')
  String? userName;

  @HiveField(5)
  @JsonKey(name: 'time_stamp')
  String? timeStamp;

  @JsonKey(name: 'reactions')
  Map<String, String>? reactions; // id,type

  @JsonKey(name: 'bookmarks')
  List<String>? bookmarks;

  bool? isLike;

  bool? isBookMarks;

  MomentVO({
    this.id,
    this.description,
    this.postImages,
    this.profilePicture,
    this.userName,
    this.timeStamp,
    this.reactions,
    this.bookmarks,
  });

  updateReaction(String uid) {
    isLike = reactions?.containsKey(uid);
    isBookMarks = bookmarks?.contains(uid);
  }

  factory MomentVO.fromJson(Map<String, dynamic> json) =>
      _$MomentVOFromJson(json);
  Map<String, dynamic> toJson() => _$MomentVOToJson(this);

  @override
  String toString() {
    return 'MomentVO(id: $id, description: $description, postImages: $postImages, profilePicture: $profilePicture, userName: $userName, timeStamp: $timeStamp, reactions: $reactions, bookmarts: $bookmarks, isLike: $isLike, isBookMarks: $isBookMarks)';
  }
}
