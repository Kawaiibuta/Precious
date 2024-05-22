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
      phoneNumber: json['phone_number'] as String?,
      userRole: json['userRole'] as String,
      addresses: (json['addresses'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      avatar_url: json['avatar_img_path_url'] as String?,
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uid': instance.uid,
      'gender': instance.gender,
      'email': instance.email,
      'age': instance.age,
      'phone_number': instance.phoneNumber,
      'userRole': instance.userRole,
      'addresses': instance.addresses,
      'avatar_img_path_url': instance.avatar_url,
    };
