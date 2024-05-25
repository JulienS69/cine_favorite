import 'package:cine_favorite/core/repositories/movies_repository.dart';
import 'package:cine_favorite/data/models/movie/movie.dart';
import 'package:dartz/dartz.dart';

class MovieRepositoryImpl {
  final MovieRepository apiClient;

  MovieRepositoryImpl(this.apiClient);

// GETTING MOVIES LIST
  Future<Either<List<Movie>, dynamic>> fetchMovies() async {
    return await apiClient.getTopMoviesDaily();
  }
}