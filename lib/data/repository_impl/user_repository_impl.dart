import 'package:cine_favorite/core/repositories/user_repository.dart';
import 'package:cine_favorite/data/models/user/user.dart';
import 'package:dartz/dartz.dart';

class UserRepositoryImpl {
  final UserRepository userRepository;

  UserRepositoryImpl(this.userRepository);

// GETTING CURRENT USER
  Future<Either<dynamic, User>> fetchCurrentUser() async {
    return await userRepository.getCurrentUser();
  }
}
