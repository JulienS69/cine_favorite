import 'package:freezed_annotation/freezed_annotation.dart';

part 'movie.freezed.dart';
part 'movie.g.dart';

@freezed
abstract class Movie with _$Movie {
  const factory Movie({
    @JsonKey(name: 'id') int? id,
    @JsonKey(name: 'title') String? title,
    @JsonKey(name: 'original_title') String? originalTitle,
    @JsonKey(name: 'overview') String? description,
    @JsonKey(name: 'poster_path') String? posterPath,
    @JsonKey(name: 'release_date') String? releaseDate,
  }) = _Movie;
  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);
}
