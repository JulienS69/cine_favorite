// Provider for MovieRepository
import 'package:cine_favorite/core/repositories/movies_repository.dart';
import 'package:cine_favorite/data/models/movie/movie.dart';
import 'package:cine_favorite/presentation/screens/movie/movie_controller.dart';
import 'package:cine_favorite/providers/movie/favorite_notifier.dart';
import 'package:cine_favorite/providers/providers.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieApiClientProvider = Provider<MovieRepository>((ref) {
  final tmdbClient = ref.read(tmdbHttpClientProvider);
  return MovieRepository(tmdbClient: tmdbClient);
});

// Provider for MovieRepositoryImplementation
final movieRepositoryProvider = Provider<MovieController>((ref) {
  final apiClient = ref.read(movieApiClientProvider);
  return MovieController(apiClient);
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

//Provider when disliking a movie from a favorites list
final dislikeMovieNotifierProvider =
    StateNotifierProvider.family<FavoriteNotifier, bool, int>(
  (ref, movieId) {
    return FavoriteNotifier(ref,
        movieId: movieId, isFavorite: false, isDisliked: true);
  },
);
