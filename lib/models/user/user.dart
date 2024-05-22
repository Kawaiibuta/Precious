import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.g.dart';
part 'user.freezed.dart';

@Freezed()
class User with _$User {
  factory User(
      {@Default(null) int? id,
      String? name,
      required String uid,
      required int gender,
      String? email,
      int? age,
      @JsonKey(name: "phone_number") String? phoneNumber,
      required String userRole,
      @Default([]) List<String> addresses,
      @JsonKey(name: "avatar_img_path_url") String? avatar_url}) = _User;
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
