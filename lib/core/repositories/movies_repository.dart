import 'package:cine_favorite/core/helper/crud_api_repository.dart';
import 'package:cine_favorite/data/models/movie/movie.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class MovieRepository extends RestApiRepository {
  final Dio tmdbClient;

  MovieRepository({
    required this.tmdbClient,
  }) : super(mainRoute: '/movie', client: tmdbClient);

  Future<Either<List<Movie>, dynamic>> getTopMoviesDaily() async {
    return await handlingGetResponse(
      queryRoute: "$controller/upcoming",
      queryParameters: {
        'language': 'fr',
      },
    ).then(
      (value) => value.fold(
        (failure) => left(failure),
        (success) {
          final results = success['results'];
          final movies =
              results.map<Movie>((e) => Movie.fromJson(e)).take(10).toList();
          return right(movies);
        },
      ),
    );
  }

  Future<Either<Map<String, dynamic>, dynamic>> addFavoriteMovie({
    required bool isFavorite,
    required int movieId,
  }) async {
    return await handlingPostResponse(
        queryRoute: "/account/21286836/favorite",
        body: {
          "media_type": "movie",
          "media_id": movieId,
          "favorite": isFavorite,
        }).then(
      (value) => value.fold(
        (failure) => left(failure),
        (success) {
          return right(success);
        },
      ),
    );
  }
}
