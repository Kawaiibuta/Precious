import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.g.dart';
part 'user.freezed.dart';

@Freezed()
class User with _$User {
  factory User(
          {@Default(null) int? id,
          required String uid,
          required int gender,
          String? email,
          int? age,
          @JsonKey(name: "avatar_img_path_url") required String avatar_url}) =
      _User;
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
