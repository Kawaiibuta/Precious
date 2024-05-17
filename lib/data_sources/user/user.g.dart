// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      id: (json['id'] as num?)?.toInt() ?? null,
      uid: json['uid'] as String,
      gender: (json['gender'] as num).toInt(),
      email: json['email'] as String?,
      age: (json['age'] as num?)?.toInt(),
      avatar_url: json['avatar_img_path_url'] as String,
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uid': instance.uid,
      'gender': instance.gender,
      'email': instance.email,
      'age': instance.age,
      'avatar_img_path_url': instance.avatar_url,
    };
