import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:our_spotify/common/widgets/appbar/app_bar.dart';
import 'package:our_spotify/presentation/home/bloc/song_player_cubit.dart';

import '../../../common/widgets/favorite_button/favorite_button.dart';
import '../../../core/configs/constants/app_urls.dart';
import '../../../core/configs/theme/app_colors.dart';
import '../../../domain/entities/song/song.dart';
import '../../home/bloc/song_player_state.dart';

class SongPlayerPage extends StatelessWidget {
  final SongEntity songEntity;
  const SongPlayerPage({super.key, required this.songEntity});

  @override
  Widget build(BuildContext context) {
    final String encodedArtist = Uri.encodeComponent(songEntity.artist);
    final String encodedTitle = Uri.encodeComponent(songEntity.title);
    return Scaffold(
      appBar: BasicAppBar(
        title: Text(
          'Now playing',
          style: TextStyle(fontSize: 18),
        ),
        action: IconButton(
          onPressed: () {},
          icon: Icon(Icons.more_vert_rounded),
        ),
      ),
      body: BlocProvider(
        create: (_) => SongPlayerCubit()
          ..loadingSong(
              '${AppUrls.songFirestorage}$encodedArtist - $encodedTitle.mp3?${AppUrls.mediaAlt}'),
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Column(
            children: [
              _songCover(context),
              const SizedBox(
                height: 20,
              ),
              _songDetail(),
              const SizedBox(
                height: 30,
              ),
              _songPlayer(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _songCover(BuildContext context) {
    final String encodedArtist = Uri.encodeComponent(songEntity.artist);
    final String encodedTitle = Uri.encodeComponent(songEntity.title);
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(
              '${AppUrls.coverFirestorage}$encodedArtist - $encodedTitle.jpg?${AppUrls.mediaAlt}'),
        ),
      ),
    );
  }

  Widget _songDetail() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              songEntity.title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              songEntity.artist,
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
            )
          ],
        ),
        FavoriteButton(songEntity: songEntity)
      ],
    );
  }

  Widget _songPlayer(BuildContext context) {
    return BlocBuilder<SongPlayerCubit, SongPlayerState>(
      builder: (context, state) {
        if (state is SongPlayerLoading) {
          return CircularProgressIndicator();
        }
        if (state is SongPlayerLoaded &&
            context.read<SongPlayerCubit>().songDuration > Duration.zero) {
          final cubit = context.read<SongPlayerCubit>();
          final position = cubit.songPosition.inSeconds.toDouble();
          final duration = cubit.songDuration.inSeconds.toDouble();

          return Column(
            children: [
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  trackHeight: 2.0, // Thickness of the slider track
                  thumbShape: RoundSliderThumbShape(
                      enabledThumbRadius: 1.0), // Size of the thumb
                  overlayShape: RoundSliderOverlayShape(
                      overlayRadius: 10.0), // Tap/click area
                  activeTrackColor: AppColors.primary,
                  inactiveTrackColor: AppColors.primary.withValues(alpha: 0.3),
                  thumbColor: AppColors.primary,
                  overlayColor: AppColors.primary.withValues(alpha: 0.2),
                  trackShape: RoundedRectSliderTrackShape(),
                ),
                child: Slider(
                  value: position.clamp(0.0, duration),
                  min: 0.0,
                  max: duration,
                  onChanged: (value) {
                    cubit.audioPlayer.seek(Duration(seconds: value.toInt()));
                  },
                  allowedInteraction: SliderInteraction.tapAndSlide,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    formatDuration(
                        context.read<SongPlayerCubit>().songPosition),
                  ),
                  Text(
                    formatDuration(
                        context.read<SongPlayerCubit>().songDuration),
                  ),
                ],
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  context.read<SongPlayerCubit>().playOrPause();
                },
                child: Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: AppColors.primary),
                  child: Icon(
                    context.read<SongPlayerCubit>().audioPlayer.playing
                        ? Icons.pause_rounded
                        : Icons.play_arrow_rounded,
                  ),
                ),
              ),
            ],
          );
        }

        return Text("Loading audio...");
      },
    );
  }

  String formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}
