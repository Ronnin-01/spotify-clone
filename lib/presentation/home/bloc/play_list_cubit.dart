import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:our_spotify/presentation/home/bloc/play_list_state.dart';
import 'package:our_spotify/service_locator.dart';
import '../../../domain/usecases/song/get_play_list.dart';

class PlayListCubit extends Cubit<PlayListState> {
  PlayListCubit() : super(PlayListLoading());

  Future<void> getPlayList() async {
    var returnedSongs = await sl<GetPlayListUseCase>().call();

    returnedSongs.fold((ifLeft) {
      emit(PlayListLoadFailure());
    }, (ifRight) {
      emit(PlayListLoaded(songs: ifRight));
    });
  }
}
