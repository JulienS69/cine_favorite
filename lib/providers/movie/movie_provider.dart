// Provider for MovieRepository
import 'package:cine_favorite/core/repositories/movies_repository.dart';
import 'package:cine_favorite/data/models/movie/movie.dart';
import 'package:cine_favorite/data/repository_impl/movie_repository_impl.dart';
import 'package:cine_favorite/providers/movie/favorite_notifier.dart';
import 'package:cine_favorite/providers/providers.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieApiClientProvider = Provider<MovieRepository>((ref) {
  final tmdbClient = ref.watch(tmdbHttpClientProvider);
  return MovieRepository(tmdbClient: tmdbClient);
});

// Provider for MovieController
final movieRepositoryProvider = Provider<MovieRepositoryImpl>((ref) {
  final apiClient = ref.read(movieApiClientProvider);
  return MovieRepositoryImpl(apiClient);
});

// Provider for fetching movies
final moviesProvider =
    FutureProvider<Either<List<Movie>, dynamic>>((ref) async {
  final repository = ref.read(movieRepositoryProvider);
  return await repository.fetchMovies();
});

//Provider for adding movies to a favorites list
final favoriteNotifierProvider =
    StateNotifierProvider.family<FavoriteNotifier, bool, int>(
  (ref, movieId) {
    const isFavorite = false;
    return FavoriteNotifier(ref, movieId: movieId, isFavorite: isFavorite);
  },
);
