import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:our_spotify/common/bloc/favorite_button/favorite_button_state.dart';
import 'package:our_spotify/domain/usecases/song/add_or_remove_favorite_song.dart';
import 'package:our_spotify/service_locator.dart';

class FavoriteButtonCubit extends Cubit<FavoriteButtonState> {
  FavoriteButtonCubit() : super(FavoriteButtonInitial());

  Future<void> favoritebuttonUpdated(String songId) async {
    var result =
        await sl<AddOrRemoveFavoriteSongUseCase>().call(params: songId);

    result.fold((l) {
      emit(l);
    }, (isFavorite) {
      emit(FavoriteButtonUpdated(isFavorite: isFavorite));
    });
  }
}
