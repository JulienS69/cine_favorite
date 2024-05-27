import 'package:cine_favorite/core/helper/crud_api_repository.dart';
import 'package:cine_favorite/data/models/movie/movie.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class FavoriteRepository extends RestApiRepository {
  final Dio tmdbClient;

  FavoriteRepository({
    required this.tmdbClient,
  }) : super(mainRoute: '/account', client: tmdbClient);

  Future<Either<List<Movie>, dynamic>> getFavoritesMovies() async {
    return await handlingGetResponse(
      queryRoute: "$controller/21286836/favorite/movies",
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
}
