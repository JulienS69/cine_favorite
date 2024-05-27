import 'package:auto_route/auto_route.dart';
import 'package:cine_favorite/data/models/user/user.dart';
import 'package:cine_favorite/helper/styles/app_colors.dart';
import 'package:cine_favorite/providers/user/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
                    (error) => Text("Erreur: $error"),
                    (user) => _buildUserContent(user),
                  );
                },
                loading: () => _buildUserContent(const User()),
                error: (error, stack) => Text("Erreur: $error"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text(
                      'Déconnexion',
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildUserContent(User user) {
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
                  'https://image.tmdb.org/t/p/w300/${user.avatar?.tmdb?.avatarPath ?? ""}',
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
              Text(
                user.name ??
                    user.userName ??
                    "Aucun nom ou pseudonyme renseigné sur votre compte",
              ),
            ],
          ),
        ),
      ],
    );
  }
}
