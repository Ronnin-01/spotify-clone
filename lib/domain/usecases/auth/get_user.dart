import 'package:dartz/dartz.dart';
import 'package:our_spotify/core/usecase/usecase.dart';
import 'package:our_spotify/domain/repository/auth/auth.dart';
import 'package:our_spotify/service_locator.dart';

class GetUserUseCase implements Usecase<Either, dynamic> {
  @override
  Future<Either> call({params}) async {
    return await sl<AuthRepository>().getUser();
  }
}
