import 'package:auto_route/auto_route.dart';
import 'package:cine_favorite/data/models/movie/movie.dart';
import 'package:cine_favorite/helper/utils.dart';
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
      appBar: getAppBar(title: "Favorite"),
      body: const Center(
        child: FavoritePage(),
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
              return ListView.builder(
                itemCount: favoritesMovies.length,
                itemBuilder: (context, index) {
                  Movie currentMovie = favoritesMovies[index];
                  final favoriteNotifier = ref.watch(
                      disslikeMovieNotifierProvider(currentMovie.id ?? 0)
                          .notifier);
                  return MovieCard(
                    currentMovie: currentMovie,
                    onTapFav: () async {
                      await HapticFeedback.vibrate();
                      await favoriteNotifier.toggleFavorite();
                      // REFRESH API CALL FOR FETCHING MOVIE AFTER UPDATE
                      await ref.refresh(favortiesMoviesProvider.future);
                    },
                    isFavorite: true,
                  );
                },
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => const Center(
            child: Row(
          children: [
            Expanded(
              child: Text(
                'Erreur: Une erreur est survenue lors de la récupération des films',
                textAlign: TextAlign.center,
              ),
            ),
          ],
        )),
      ),
    );
  }
}
