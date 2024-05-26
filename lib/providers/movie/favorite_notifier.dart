import 'package:cine_favorite/helper/utils.dart';
import 'package:cine_favorite/providers/movie/movie_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoriteNotifier extends StateNotifier<bool> {
  FavoriteNotifier(
    this.ref, {
    required this.movieId,
    required bool isFavorite,
    this.isDissliked,
  }) : super(isFavorite);

  final StateNotifierProviderRef<FavoriteNotifier, bool> ref;
  final int movieId;
  final bool? isDissliked;

  Future<void> toggleFavorite() async {
    final newFavoriteState = !state;
    final repository = ref.read(movieRepositoryProvider);
    final bool isDisslikedMovie = isDissliked ?? false;
    await repository
        .updateMovie(
          movieId: movieId,
          isFavorite: isDisslikedMovie ? false : newFavoriteState,
        )
        .then(
          (either) => either.fold(
            (failure) {
              showSnackbar("Un problème est survenu", SnackStatusEnum.error);
            },
            (success) {
              state = newFavoriteState;
              if (isDisslikedMovie) {
                showSnackbar("Supprimé des favoris", SnackStatusEnum.success);
              } else {
                showSnackbar("Mise à jour réussi", SnackStatusEnum.success);
              }
            },
          ),
        )
        .catchError((err) {});
  }
}
