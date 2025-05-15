import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:our_spotify/domain/usecases/song/get_news_songs.dart';
import 'package:our_spotify/presentation/home/bloc/news_song_state.dart';
import 'package:our_spotify/service_locator.dart';

class NewsSongsCubit extends Cubit<NewsSongsState> {
  NewsSongsCubit() : super(NewsSongsLoading());

  Future<void> getNewsSongs() async {
    var returnedSongs = await sl<GetNewsSongsUseCase>().call();

    returnedSongs.fold((ifLeft) {
      emit(NewsSongsLoadFailure());
    }, (ifRight) {
      emit(NewsSongsLoaded(songs: ifRight));
    });
  }
}
