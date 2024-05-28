import 'package:cine_favorite/core/helper/utils.dart';
import 'package:cine_favorite/providers/movie/movie_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoriteNotifier extends StateNotifier<bool> {
  FavoriteNotifier(
    this.ref, {
    required this.movieId,
    required bool isFavorite,
    this.isDisliked,
  }) : super(isFavorite);

  final StateNotifierProviderRef<FavoriteNotifier, bool> ref;
  final int movieId;
  // FROM FAVORITE PAGE
  final bool? isDisliked;

//Method executing the API call and updating the state of the boolean
  Future<void> toggleFavorite() async {
    final newFavoriteState = !state;
    final repository = ref.read(movieRepositoryProvider);
    final bool isDislikedMovie = isDisliked ?? false;
    await repository
        .updateMovie(
          movieId: movieId,
          isFavorite: isDislikedMovie ? false : newFavoriteState,
        )
        .then(
          (either) => either.fold(
            (failure) {
              showSnackbar("Un problème est survenu", SnackStatusEnum.error);
            },
            (success) {
              updateFavoriteStatus(
                isDislikedMovie: isDislikedMovie,
                newFavoriteState: newFavoriteState,
                success: success,
              );
            },
          ),
        )
        .catchError((err) {});
  }

//Method to display the appropriate message based on the status code when updating the movie
  void updateFavoriteStatus({
    required bool isDislikedMovie,
    required dynamic success,
    required var newFavoriteState,
  }) {
    String message;

    if (isDislikedMovie || success['status_code'] == 13) {
      message = "Supprimé des favoris";
      state = newFavoriteState;
      showSnackbar(message, SnackStatusEnum.success);
    } else if (success['status_code'] == 12) {
      message = "Ce film fait déjà partie de vos favoris";
      showSnackbar(message, SnackStatusEnum.warning);
    } else {
      message = "Film ajouté aux favoris";
      state = newFavoriteState;
      showSnackbar(message, SnackStatusEnum.success);
    }
  }
}
