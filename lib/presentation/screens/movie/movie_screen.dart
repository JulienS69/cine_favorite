import 'package:auto_route/auto_route.dart';
import 'package:cine_favorite/data/models/movie/movie.dart';
import 'package:cine_favorite/helper/styles/app_colors.dart';
import 'package:cine_favorite/helper/styles/app_style.dart';
import 'package:cine_favorite/helper/utils.dart';
import 'package:cine_favorite/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';

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
          (failure) => Text('Error: $failure'),
          (movies) {
            return ListView.builder(
              itemCount: movies.length,
              itemBuilder: (context, index) {
                Movie currentMovie = movies[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 150,
                    child: Card(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              AppColors.primary,
                              Colors.purple,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Image.network(
                                    'https://image.tmdb.org/t/p/original/${currentMovie.posterPath ?? ""}',
                                    gaplessPlayback: true,
                                    loadingBuilder: (BuildContext context,
                                        Widget child,
                                        ImageChunkEvent? loadingProgress) {
                                      if (loadingProgress == null) {
                                        return child;
                                      } else {
                                        return Skeletonizer(
                                          child: Image.network(
                                            'https://picsum.photos/200/300',
                                          ),
                                        );
                                      }
                                    },
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        //TITLE OF THE MOVIE
                                        Expanded(
                                          child: Text(
                                            currentMovie.title ?? "No title",
                                            style: AppTextStyles.title.copyWith(
                                                color: AppColors.white),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        //ICON FAVORITE WITH NO ACTION
                                        //TODO ACTION FOR FAV
                                        InkWell(
                                          onTap: () async {
                                            await HapticFeedback.vibrate();
                                          },
                                          child: const Icon(
                                            Icons.favorite_outline,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      currentMovie.releaseDate ??
                                          "No release date",
                                      style: AppTextStyles.content.copyWith(
                                        color: Colors.black87,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 12.0),
                                      child: Text(
                                        currentMovie.description ??
                                            "No description found for this movie",
                                        style: AppTextStyles.content.copyWith(
                                          color: AppColors.white,
                                        ),
                                        maxLines: 3,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        );
      },
      loading: () => Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Center(child: Text('Error: $error')),
    );
  }
}
