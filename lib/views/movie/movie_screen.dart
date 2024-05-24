import 'package:auto_route/auto_route.dart';
import 'package:cine_favorite/helper/styles/app_style.dart';
import 'package:cine_favorite/model/movie/movie.dart';
import 'package:flutter/material.dart';

@RoutePage()
class MovieScreen extends StatelessWidget {
  const MovieScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //TEST
    Movie currentMovie = const Movie(
      originalTitle: "Civil War",
      title: "Civil War",
      posterPath:
          "https://image.tmdb.org/t/p/original/sh7Rg8Er3tFcN9BpKIPOMvALgZd.jpg",
      releaseDate: "10 Avril 2024",
    );
    return Scaffold(
      appBar: AppBar(title: const Text('Movies')),
      body: Center(
        child: SizedBox(
          width: 380,
          height: 150,
          child: Card(
            child: Row(
              children: [
                Expanded(
                  child: Image.network(
                    currentMovie.posterPath!,
                    fit: BoxFit.contain,
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
                            Text(
                              currentMovie.title ?? "No title",
                              style: AppTextStyles.title,
                            ),
                            const Spacer(),
                            //ICON FAVORITE WITH NO ACTION
                            //TODO ACTION FOR FAV
                            const Icon(
                              Icons.favorite_outline,
                              color: Colors.red,
                            ),
                          ],
                        ),
                        Text(
                          currentMovie.releaseDate ?? "No release date",
                          style: AppTextStyles.content.copyWith(
                            color: Colors.grey,
                          ),
                        )
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
  }
}
