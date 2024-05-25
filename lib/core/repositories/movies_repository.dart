import 'package:cine_favorite/core/repositories/helper/crud_api_repository.dart';
import 'package:cine_favorite/data/models/movie/movie.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class MovieRepository extends RestApiRepository {
  final Dio tmdbClient;

  MovieRepository({
    required this.tmdbClient,
  }) : super(mainRoute: '/trending/movie', client: tmdbClient);

  Future<Either<List<Movie>, dynamic>> getTopMoviesDaily() async {
    return await handlingGetResponse(
      queryRoute: "$controller/day",
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
