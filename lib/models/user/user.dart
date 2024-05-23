import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:precious/models/cart/cart.dart';

part 'user.freezed.dart';

part 'user.g.dart';


@Freezed()
class User with _$User {
  const factory User({
    required int id,
    required String uid,
    String? name,
    @JsonKey(name: 'avatar_img_path') required String avatarImgPath,
    required num? gender,
    required String? email,
    required int? age,
    required Cart? cart,
    @JsonKey(name: 'phone_number') required String phoneNumber,
    required String userRole
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
