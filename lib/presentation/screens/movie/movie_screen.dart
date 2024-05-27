import 'package:auto_route/auto_route.dart';
import 'package:cine_favorite/data/models/movie/movie.dart';
import 'package:cine_favorite/helper/styles/app_colors.dart';
import 'package:cine_favorite/helper/utils.dart';
import 'package:cine_favorite/presentation/screens/movie/widgets/movie_card.dart';
import 'package:cine_favorite/providers/movie/movie_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class MovieScreen extends StatelessWidget {
  const MovieScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(title: "Films"),
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
          child: const MoviesPage()),
    );
  }
}

class MoviesPage extends ConsumerWidget {
  const MoviesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final moviesAsyncValue = ref.watch(moviesProvider);
    return moviesAsyncValue.when(
      data: (eitherMovies) {
        return eitherMovies.fold(
          (failure) => const Text(
              'Erreur: Une erreur est survenue lors de la récupération des films'),
          (movies) {
            return ListView.builder(
              itemCount: movies.length,
              itemBuilder: (context, index) {
                Movie currentMovie = movies[index];
                final favoriteNotifier = ref.watch(
                    favoriteNotifierProvider(currentMovie.id ?? 0).notifier);
                final isFavorite =
                    ref.watch(favoriteNotifierProvider(currentMovie.id ?? 0));
                return MovieCard(
                  currentMovie: currentMovie,
                  onTapFav: () async {
                    await HapticFeedback.vibrate();
                    await favoriteNotifier.toggleFavorite();
                  },
                  isFavorite: isFavorite,
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
    );
  }
}
