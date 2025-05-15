import 'package:dartz/dartz.dart';
import 'package:our_spotify/core/usecase/usecase.dart';
import 'package:our_spotify/data/models/auth/create_user_req.dart';
import 'package:our_spotify/domain/repository/auth/auth.dart';
import 'package:our_spotify/service_locator.dart';

class SignupUseCase implements Usecase<Either, CreateUserReq> {
  @override
  Future<Either> call({CreateUserReq? params}) {
    return sl<AuthRepository>().signup(params!);
  }
}
