import 'package:our_spotify/core/usecase/usecase.dart';
import 'package:our_spotify/domain/repository/song/song.dart';
import 'package:our_spotify/service_locator.dart';

class IsFavoriteSongUseCase implements Usecase<bool, String> {
  @override
  Future<bool> call({String? params}) async {
    return await sl<SongsRepository>().isFavoriteSong(params!);
  }
}
