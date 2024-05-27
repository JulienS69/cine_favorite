import 'package:cine_favorite/data/models/tmdb/tmdb.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'avatar.freezed.dart';
part 'avatar.g.dart';

@freezed
abstract class Avatar with _$Avatar {
  const factory Avatar({
    @JsonKey(name: 'tmdb') Tmdb? tmdb,
  }) = _Avatar;
  factory Avatar.fromJson(Map<String, dynamic> json) => _$AvatarFromJson(json);
}
