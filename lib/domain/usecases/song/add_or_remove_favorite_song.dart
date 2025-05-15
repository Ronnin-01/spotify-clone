import 'package:dartz/dartz.dart';
import 'package:our_spotify/core/usecase/usecase.dart';
import 'package:our_spotify/domain/repository/song/song.dart';
import 'package:our_spotify/service_locator.dart';

class AddOrRemoveFavoriteSongUseCase implements Usecase<Either, String> {
  @override
  Future<Either> call({String? params}) async {
    return await sl<SongsRepository>().addOrRemoveFavoriteSongs(params!);
  }
}
