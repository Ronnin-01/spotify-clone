import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:our_spotify/common/helpers/is_dark_mode.dart';
import 'package:our_spotify/common/widgets/appbar/app_bar.dart';
import 'package:our_spotify/presentation/profile/bloc/favorite_songs_cubit.dart';
import 'package:our_spotify/presentation/profile/bloc/favorite_songs_state.dart';
import 'package:our_spotify/presentation/profile/bloc/profile_info_cubit.dart';
import 'package:our_spotify/presentation/profile/bloc/profile_info_state.dart';
import 'package:our_spotify/presentation/song_player/pages/song_player.dart';

import '../../../common/widgets/favorite_button/favorite_button.dart';
import '../../../core/configs/constants/app_urls.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        backgroundColor: Color(0xff2c2b2b),
        title: Text('Profile'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _profileInfo(context),
          SizedBox(
            height: 30,
          ),
          _favoriteSongs(),
        ],
      ),
    );
  }

  Widget _profileInfo(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileInfoCubit()..getUser(),
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height / 3.5,
        decoration: BoxDecoration(
          color: context.isDarkMode ? Color(0xff2c2b2b) : Colors.white,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(50),
            bottomRight: Radius.circular(50),
          ),
        ),
        child: BlocBuilder<ProfileInfoCubit, ProfileInfoState>(
          builder: (context, state) {
            if (state is ProfileInfoLoading) {
              return Container(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator());
            }

            if (state is ProfileInfoLoaded) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 90,
                    width: 90,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(state.userEntity.imageUrl!),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(state.userEntity.email!),
                  SizedBox(height: 10),
                  Text(
                    state.userEntity.fullName!,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              );
            }

            if (state is ProfileInfoFailure) {
              return Text('Please try again');
            }

            return Container();
          },
        ),
      ),
    );
  }

  Widget _favoriteSongs() {
    return BlocProvider(
      create: (context) => FavoriteSongsCubit()..getFavoriteSongs(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Favorite Songs'),
            SizedBox(
              height: 20,
            ),
            BlocBuilder<FavoriteSongsCubit, FavoriteSongsState>(
                builder: (context, state) {
              if (state is FavoriteSongsLoading) {
                return CircularProgressIndicator();
              }

              if (state is FavoriteSongsLoaded) {
                return ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final String encodedArtist = Uri.encodeComponent(
                          state.favoriteSongs[index].artist);
                      final String encodedTitle =
                          Uri.encodeComponent(state.favoriteSongs[index].title);
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => SongPlayerPage(
                                  songEntity: state.favoriteSongs[index]),
                            ),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 65,
                                  width: 65,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              '${AppUrls.coverFirestorage}$encodedArtist - $encodedTitle.jpg?${AppUrls.mediaAlt}'))),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      state.favoriteSongs[index].title,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      state.favoriteSongs[index].artist,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  state.favoriteSongs[index].duration
                                      .toString()
                                      .replaceAll('.', ':'),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                FavoriteButton(
                                    key: UniqueKey(),
                                    function: () {
                                      context
                                          .read<FavoriteSongsCubit>()
                                          .removeSong(index);
                                    },
                                    songEntity: state.favoriteSongs[index])
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(height: 20),
                    itemCount: state.favoriteSongs.length);
              }

              if (state is FavoriteSongsFailure) {
                return Text('Please try again.');
              }
              return Container();
            })
          ],
        ),
      ),
    );
  }
}
