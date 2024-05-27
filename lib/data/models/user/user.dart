import 'package:cine_favorite/data/models/avatar/avatar.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
abstract class User with _$User {
  const factory User({
    @JsonKey(name: 'id') int? id,
    @JsonKey(name: 'username') String? userName,
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'avatar') Avatar? avatar,
  }) = _User;
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
