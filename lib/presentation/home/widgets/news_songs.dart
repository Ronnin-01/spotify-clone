import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:our_spotify/common/helpers/is_dark_mode.dart';
import 'package:our_spotify/core/configs/constants/app_urls.dart';
import 'package:our_spotify/core/configs/theme/app_colors.dart';
import 'package:our_spotify/domain/entities/song/song.dart';
import 'package:our_spotify/presentation/home/bloc/news_song_state.dart';
import 'package:our_spotify/presentation/home/bloc/news_songs_cubit.dart';
import 'package:our_spotify/presentation/song_player/pages/song_player.dart';

class NewsSongs extends StatelessWidget {
  const NewsSongs({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NewsSongsCubit()..getNewsSongs(),
      child: SizedBox(
        height: 200,
        child: BlocBuilder<NewsSongsCubit, NewsSongsState>(
          builder: (context, state) {
            if (state is NewsSongsLoading) {
              return Container(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(
                    color: AppColors.primary,
                  ));
            }
            if (state is NewsSongsLoaded) {
              return _songs(state.songs);
            }
            return Container();
          },
        ),
      ),
    );
  }

  Widget _songs(List<SongEntity> songs) {
    return ListView.separated(
        addAutomaticKeepAlives: true,
        padding: EdgeInsets.only(left: 10, right: 10),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final String encodedArtist = Uri.encodeComponent(songs[index].artist);
          final String encodedTitle = Uri.encodeComponent(songs[index].title);
          debugPrint(
              '${AppUrls.coverFirestorage}$encodedArtist - $encodedTitle.jpg?${AppUrls.mediaAlt}');
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) =>
                      SongPlayerPage(songEntity: songs[index]),
                ),
              );
            },
            child: SizedBox(
              width: 160,
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              '${AppUrls.coverFirestorage}$encodedArtist - $encodedTitle.jpg?${AppUrls.mediaAlt}'),
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          height: 40,
                          width: 40,
                          transform: Matrix4.translationValues(10, 10, 0),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: context.isDarkMode
                                  ? AppColors.darkGrey
                                  : Color(0xffe6e6e6)),
                          child: Icon(
                            Icons.play_arrow_rounded,
                            color: context.isDarkMode
                                ? Color(0xff959595)
                                : Color(0xff555555),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    songs[index].title,
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  SizedBox(height: 5),
                  Text(
                    songs[index].artist,
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
                  ),
                ],
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => SizedBox(
              width: 14,
            ),
        itemCount: songs.length);
  }
}
