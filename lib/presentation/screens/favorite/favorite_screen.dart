import 'package:auto_route/auto_route.dart';
import 'package:cine_favorite/core/helper/styles/app_colors.dart';
import 'package:cine_favorite/core/helper/utils.dart';
import 'package:cine_favorite/core/helper/widgets/empty_content.dart';
import 'package:cine_favorite/data/models/movie/movie.dart';
import 'package:cine_favorite/presentation/screens/movie/widgets/movie_card.dart';
import 'package:cine_favorite/providers/favorite/favorite_providers.dart';
import 'package:cine_favorite/providers/movie/movie_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(title: "Films favoris"),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white60,
              AppColors.primary,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: const Center(
          child: FavoritePage(),
        ),
      ),
    );
  }
}

class FavoritePage extends ConsumerWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoritesMoviesAsyncValue = ref.watch(favortiesMoviesProvider);

    return RefreshIndicator(
      onRefresh: () => ref.refresh(favortiesMoviesProvider.future),
      child: favoritesMoviesAsyncValue.when(
        data: (eitherMovies) {
          return eitherMovies.fold(
            (failure) => const Text(
                'Erreur: Une erreur est survenue lors de la récupération des films'),
            (favoritesMovies) {
              List<Movie> favoriteMoviesList = favoritesMovies;
              if (favoriteMoviesList.isEmpty) {
                return RefreshIndicator(
                  onRefresh: () => ref.refresh(favortiesMoviesProvider.future),
                  child: ListView(
                    shrinkWrap: true,
                    children: const [
                      Center(
                        child: EmptyContent(
                          title: "Aucun film favori trouvé",
                          lottie: notFoundLottie,
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return ListView.builder(
                  itemCount: favoriteMoviesList.length,
                  itemBuilder: (context, index) {
                    Movie currentMovie = favoriteMoviesList[index];
                    final favoriteNotifier = ref.watch(
                        dislikeMovieNotifierProvider(currentMovie.id ?? 0)
                            .notifier);
                    return MovieCard(
                      currentMovie: currentMovie,
                      onTapFav: () async {
                        await HapticFeedback.vibrate();
                        await favoriteNotifier.toggleFavorite();
                        // REFRESH API CALL FOR FETCHING MOVIE AFTER UPDATE
                        // RESET THE PROVIDER SET
                        ref.invalidate(favortiesMoviesProvider);
                        ref.read(favortiesMoviesProvider);
                      },
                      isFavorite: true,
                    );
                  },
                );
              }
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => const EmptyContent(
          title:
              "Une erreur est survenue lors de la récupération de vos films favoris",
          lottie: errorLottie,
        ),
      ),
    );
  }
}
