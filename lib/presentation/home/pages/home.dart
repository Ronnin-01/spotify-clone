import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:our_spotify/common/helpers/is_dark_mode.dart';
import 'package:our_spotify/common/widgets/appbar/app_bar.dart';
import 'package:our_spotify/core/configs/assets/app_images.dart';
import 'package:our_spotify/core/configs/assets/app_vectors.dart';
import 'package:our_spotify/core/configs/theme/app_colors.dart';
import 'package:our_spotify/presentation/home/widgets/news_songs.dart';
import 'package:our_spotify/presentation/home/widgets/play_list.dart';
import 'package:our_spotify/presentation/profile/pages/profile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        hideback: true,
        action: IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => ProfilePage()));
            },
            icon: Icon(Icons.person)),
        title: SvgPicture.asset(
          AppVectors.logo,
          height: 40,
          width: 40,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _homeTopCard(),
            _tabs(),
            SizedBox(
              height: 260,
              child: TabBarView(
                controller: _tabController,
                children: [
                  NewsSongs(),
                  Container(),
                  Container(),
                  Container(),
                ],
              ),
            ),
            PlayList(),
          ],
        ),
      ),
    );
  }

  Widget _homeTopCard() {
    return Center(
      child: SizedBox(
        height: 188,
        child: Stack(
          children: [
            Align(
                alignment: Alignment.bottomCenter,
                child: SvgPicture.asset(AppVectors.homeTopCard)),
            Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 60),
                  child: Image.asset(AppImages.homeArtist),
                ))
          ],
        ),
      ),
    );
  }

  Widget _tabs() {
    return TabBar(
      tabAlignment: TabAlignment.fill,
      automaticIndicatorColorAdjustment: true,
      indicatorAnimation: TabIndicatorAnimation.elastic,
      indicatorSize: TabBarIndicatorSize.tab,
      dividerColor: Colors.transparent,
      controller: _tabController,
      //isScrollable: true,
      indicatorColor: AppColors.primary,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      labelColor: context.isDarkMode ? Colors.white : Colors.black,
      tabs: [
        Text(
          'News',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
        ),
        Text(
          'Videos',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
        ),
        Text(
          'Artists',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
        ),
        Text(
          'Podcasts',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
        ),
      ],
    );
  }
}
