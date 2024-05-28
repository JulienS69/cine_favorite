import 'package:auto_route/auto_route.dart';
import 'package:cine_favorite/core/helper/styles/app_colors.dart';
import 'package:cine_favorite/core/helper/utils.dart';
import 'package:cine_favorite/core/helper/widgets/empty_content.dart';
import 'package:cine_favorite/data/models/user/user.dart';
import 'package:cine_favorite/providers/user/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';

@RoutePage()
class ProfilScreen extends ConsumerWidget {
  const ProfilScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUserAsyncValue = ref.watch(currentUserProvider);
    return Scaffold(
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
        child: Column(
          children: [
            const SizedBox(height: 50),
            Expanded(
              child: currentUserAsyncValue.when(
                data: (userOrError) {
                  return userOrError.fold(
                    (error) => const EmptyContent(
                      title:
                          "Une erreur est survenue lors de la récupération de vos informations",
                      lottie: errorLottie,
                    ),
                    (user) => _buildUserContent(user: user),
                  );
                },
                loading: () => Skeletonizer(
                    child:
                        _buildUserContent(user: const User(), isloading: true)),
                error: (error, stack) => const EmptyContent(
                  title: "Une erreur est survenue",
                  lottie: errorLottie,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserContent({required User user, bool? isloading}) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(6),
                ),
                child: Image.network(
                  isloading ?? false
                      ? 'https://picsum.photos/200/300'
                      : 'https://image.tmdb.org/t/p/w300/${user.avatar?.tmdb?.avatarPath ?? ""}',
                  width: 150,
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  user.name ??
                      user.userName ??
                      "Aucun nom ou pseudonyme renseigné sur votre compte",
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        const EmptyContent(title: "Aucunes données", lottie: emptyLottie)
      ],
    );
  }
}
