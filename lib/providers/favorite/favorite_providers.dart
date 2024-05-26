import 'package:cine_favorite/core/repositories/favorite_repository.dart';
import 'package:cine_favorite/data/models/movie/movie.dart';
import 'package:cine_favorite/data/repository_impl/favorite_movie_repository_impl.dart';
import 'package:cine_favorite/providers/providers.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final favoritesMovieApiClientProvider = Provider<FavoriteRepository>((ref) {
  final tmdbClient = ref.watch(tmdbHttpClientProvider);
  return FavoriteRepository(tmdbClient: tmdbClient);
});

// Provider for FavoriteRepositoryImplementation
final favoriteMovieRepositoryProvider = Provider<FavoriteRepositoryImpl>((ref) {
  final apiClient = ref.read(favoritesMovieApiClientProvider);
  return FavoriteRepositoryImpl(apiClient);
});

// Provider for fetching favorites movies
final favortiesMoviesProvider =
    FutureProvider<Either<List<Movie>, dynamic>>((ref) async {
  final repository = ref.read(favoriteMovieRepositoryProvider);
  return await repository.fetchFavoritesMovies();
});
