import 'package:get_it/get_it.dart';
import 'package:our_spotify/data/sources/auth/auth_firebase_service.dart';
import 'package:our_spotify/data/sources/repository/auth/auth_repository_impl.dart';
import 'package:our_spotify/data/sources/repository/song/song_repository_impl.dart';
import 'package:our_spotify/data/sources/song/song_firestore_service.dart';
import 'package:our_spotify/domain/repository/auth/auth.dart';
import 'package:our_spotify/domain/repository/song/song.dart';
import 'package:our_spotify/domain/usecases/auth/get_user.dart';
import 'package:our_spotify/domain/usecases/auth/signin.dart';
import 'package:our_spotify/domain/usecases/auth/signup.dart';
import 'package:our_spotify/domain/usecases/song/add_or_remove_favorite_song.dart';
import 'package:our_spotify/domain/usecases/song/get_favorite_songs.dart';
import 'package:our_spotify/domain/usecases/song/get_news_songs.dart';
import 'package:our_spotify/domain/usecases/song/get_play_list.dart';
import 'package:our_spotify/domain/usecases/song/is_favorite_song.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  sl.registerSingleton<AuthFirebaseService>(AuthFirebaseServiceImpl());

  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());

  sl.registerSingleton<SignupUseCase>(SignupUseCase());

  sl.registerSingleton<SigninUseCase>(SigninUseCase());

  sl.registerSingleton<SongFirebaseService>(SongFirebaseServiceImpl());

  sl.registerSingleton<SongsRepository>(SongRepositoryImpl());

  sl.registerSingleton<GetNewsSongsUseCase>(GetNewsSongsUseCase());

  sl.registerSingleton<GetPlayListUseCase>(GetPlayListUseCase());

  sl.registerSingleton<AddOrRemoveFavoriteSongUseCase>(
      AddOrRemoveFavoriteSongUseCase());

  sl.registerSingleton<IsFavoriteSongUseCase>(IsFavoriteSongUseCase());

  sl.registerSingleton<GetUserUseCase>(GetUserUseCase());

  sl.registerSingleton<GetFavoriteSongsUseCase>(GetFavoriteSongsUseCase());
}
