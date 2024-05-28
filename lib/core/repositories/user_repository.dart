import 'package:cine_favorite/core/helper/crud_api_repository.dart';
import 'package:cine_favorite/data/models/user/user.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class UserRepository extends RestApiRepository {
  final Dio tmdbClient;

  UserRepository({
    required this.tmdbClient,
  }) : super(mainRoute: '/account', client: tmdbClient);

  Future<Either<dynamic, User>> getCurrentUser() async {
    return await handlingGetResponse(
      queryRoute: "$controller/21286836",
    ).then(
      (value) => value.fold(
        (failure) => left(failure),
        (success) {
          return right(
            User.fromJson(success),
          );
        },
      ),
    );
  }
}
