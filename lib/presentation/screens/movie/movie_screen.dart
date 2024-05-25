import 'package:auto_route/auto_route.dart';
import 'package:cine_favorite/data/models/movie/movie.dart';
import 'package:cine_favorite/helper/utils.dart';
import 'package:cine_favorite/presentation/screens/movie/widgets/movie_card.dart';
import 'package:cine_favorite/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class MovieScreen extends StatelessWidget {
  const MovieScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(title: "Films"),
      body: const MoviesPage(),
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
              'Error: Une erreur est survenue lors de la récupération des films'),
          (movies) {
            return ListView.builder(
              itemCount: movies.length,
              itemBuilder: (context, index) {
                Movie currentMovie = movies[index];
                return MovieCard(currentMovie: currentMovie);
              },
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Center(child: Text('Error: $error')),
    );
  }
}
