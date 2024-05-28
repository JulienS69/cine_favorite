import 'package:cine_favorite/core/repositories/user_repository.dart';
import 'package:cine_favorite/data/models/user/user.dart';
import 'package:cine_favorite/presentation/screens/profil/profil_controller.dart';
import 'package:cine_favorite/providers/providers.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userApiClientProvider = Provider<UserRepository>((ref) {
  final tmdbClient = ref.watch(tmdbHttpClientProvider);
  return UserRepository(tmdbClient: tmdbClient);
});

// Provider for MovieRepositoryImplementation
final userRepositoryProvider = Provider<ProfilController>((ref) {
  final apiClient = ref.read(userApiClientProvider);
  return ProfilController(apiClient);
});

// Provider for fetching currrent user
final currentUserProvider = FutureProvider<Either<dynamic, User>>((ref) async {
  final repository = ref.read(userRepositoryProvider);
  return await repository.fetchCurrentUser();
});
