// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      id: json['id'] as int,
      uid: json['uid'] as String,
      avatarImgPath: json['avatar_img_path'] as String,
      gender: json['gender'] as num?,
      email: json['email'] as String?,
      age: json['age'] as int?,
      cart: json['cart'] == null
          ? null
          : Cart.fromJson(json['cart'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uid': instance.uid,
      'avatar_img_path': instance.avatarImgPath,
      'gender': instance.gender,
      'email': instance.email,
      'age': instance.age,
      'cart': instance.cart,
    };
