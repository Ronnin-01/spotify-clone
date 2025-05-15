import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:our_spotify/common/helpers/is_dark_mode.dart';
import 'package:our_spotify/common/widgets/favorite_button/favorite_button.dart';
import 'package:our_spotify/core/configs/theme/app_colors.dart';
import 'package:our_spotify/domain/entities/song/song.dart';
import 'package:our_spotify/presentation/home/bloc/play_list_cubit.dart';
import 'package:our_spotify/presentation/song_player/pages/song_player.dart';
import '../bloc/play_list_state.dart';

class PlayList extends StatelessWidget {
  const PlayList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PlayListCubit()..getPlayList(),
      child: BlocBuilder<PlayListCubit, PlayListState>(
        builder: (context, state) {
          if (state is PlayListLoading) {
            Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(
                color: AppColors.primary,
              ),
            );
          }
          if (state is PlayListLoaded) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Playlist',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Text(
                        'See more',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: Color(0xffc6c6c6)),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  _songs(state.songs),
                ],
              ),
            );
          }
          return Container();
        },
      ),
    );
  }

  Widget _songs(List<SongEntity> songs) {
    return ListView.separated(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: context.isDarkMode
                            ? AppColors.darkGrey
                            : Color(0xffe6e6e6)),
                    child: Icon(Icons.play_arrow_rounded,
                        color: context.isDarkMode
                            ? Color(0xff959595)
                            : AppColors.darkGrey),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        songs[index].title,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        songs[index].artist,
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 12),
                      )
                    ],
                  )
                ],
              ),
              Row(
                children: [
                  Text(
                    songs[index].duration.toString().replaceAll('.', ':'),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  FavoriteButton(songEntity: songs[index])
                ],
              ),
            ],
          ),
        );
      },
      separatorBuilder: (context, index) => SizedBox(height: 20),
      itemCount: songs.length,
    );
  }
}
