// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moment_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MomentVOAdaptor extends TypeAdapter<MomentVO> {
  @override
  final int typeId = 1;

  @override
  MomentVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MomentVO(
      id: fields[0] as String?,
      description: fields[1] as String?,
      postImages: (fields[2] as List?)?.cast<String>(),
      profilePicture: fields[3] as String?,
      userName: fields[4] as String?,
      timeStamp: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, MomentVO obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.postImages)
      ..writeByte(3)
      ..write(obj.profilePicture)
      ..writeByte(4)
      ..write(obj.userName)
      ..writeByte(5)
      ..write(obj.timeStamp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MomentVOAdaptor &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MomentVO _$MomentVOFromJson(Map<String, dynamic> json) => MomentVO(
      id: json['id'] as String?,
      description: json['description'] as String?,
      postImages: (json['post_images'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      profilePicture: json['profile_picture'] as String?,
      userName: json['user_name'] as String?,
      timeStamp: json['time_stamp'] as String?,
      reactions: (json['reactions'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      bookmarks: (json['bookmarks'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    )
      ..isLike = json['isLike'] as bool?
      ..isBookMarks = json['isBookMarks'] as bool?;

Map<String, dynamic> _$MomentVOToJson(MomentVO instance) => <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'post_images': instance.postImages,
      'profile_picture': instance.profilePicture,
      'user_name': instance.userName,
      'time_stamp': instance.timeStamp,
      'reactions': instance.reactions,
      'bookmarks': instance.bookmarks,
      'isLike': instance.isLike,
      'isBookMarks': instance.isBookMarks,
    };
