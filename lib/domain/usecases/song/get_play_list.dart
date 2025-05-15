import 'package:dartz/dartz.dart';
import 'package:our_spotify/core/usecase/usecase.dart';
import 'package:our_spotify/domain/repository/song/song.dart';
import 'package:our_spotify/service_locator.dart';

class GetPlayListUseCase implements Usecase<Either, dynamic> {
  @override
  Future<Either> call({params}) async {
    return await sl<SongsRepository>().getPlayList();
  }
}
