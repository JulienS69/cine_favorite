import 'package:cine_favorite/core/repositories/favorite_repository.dart';
import 'package:cine_favorite/data/models/movie/movie.dart';
import 'package:dartz/dartz.dart';

class FavoriteRepositoryImpl {
  final FavoriteRepository apiClient;

  FavoriteRepositoryImpl(this.apiClient);

// GETTING FAVORITE MOVIES
  Future<Either<List<Movie>, dynamic>> fetchFavoritesMovies() async {
    return await apiClient.getFavoritesMovies();
  }
}
