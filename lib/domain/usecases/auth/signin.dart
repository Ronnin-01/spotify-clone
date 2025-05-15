import 'package:dartz/dartz.dart';
import 'package:our_spotify/core/usecase/usecase.dart';
import 'package:our_spotify/data/models/auth/signin_user_req.dart';
import 'package:our_spotify/domain/repository/auth/auth.dart';
import 'package:our_spotify/service_locator.dart';

class SigninUseCase implements Usecase<Either, SigninUserReq> {
  @override
  Future<Either> call({SigninUserReq? params}) {
    return sl<AuthRepository>().signin(params!);
  }
}
