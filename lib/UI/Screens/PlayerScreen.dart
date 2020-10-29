import 'package:carousel_slider/carousel_slider.dart';
import 'package:dyeus_music_sample/Core/Helpers/Colors.dart';
import 'package:dyeus_music_sample/Core/Helpers/DemoData.dart';
import 'package:dyeus_music_sample/Core/ProviderNotifiers/AudioNotifier.dart';
import 'package:dyeus_music_sample/UI/HelperWidgets/AudioVisualWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlayerScreen extends StatefulWidget {
  @override
  _PlayerScreenState createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  @override
  Widget build(BuildContext context) {
    final audioNotifier = Provider.of<AudioNotifier>(context);
    final size = MediaQuery.of(context).size;

    /// building indicator at top
    Widget _buildIndicator(int index) {
      double zoom = audioNotifier.currentSongIndex == index ? 2 : 1;
      return AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 14.0 + (7.0 * zoom),
        child: new Center(
          child: new Material(
            color: audioNotifier.currentSongIndex == index
                ? CColors.indicatorDark
                : CColors.indicatorDark.withOpacity(0.25),
            type: MaterialType.circle,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 7.0 * zoom,
              height: 7.0 * zoom,
            ),
          ),
        ),
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          Container(
            child: Image.asset(
              "assets/images/background.png",
              fit: BoxFit.fill,
              width: size.width,
              height: size.height,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 60.0, bottom: 30.0),
                    child: Container(
                      height: 20,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List<Widget>.generate(
                            DemoData.allMusicData.length, _buildIndicator),
                      ),
                    ),
                  ),
                  CarouselSlider(
                    carouselController: audioNotifier.carouselController,
                    options: CarouselOptions(
                      enableInfiniteScroll: true,
                      initialPage: 1,
                      viewportFraction: 0.6,
                      enlargeCenterPage: true,
                      scrollDirection: Axis.horizontal,
                      onPageChanged: audioNotifier.onCarousalPageChanged,
                    ),
                    items: DemoData.allMusicData.map((item) {
                      return Builder(
                        builder: (BuildContext context) {
                          return AudioVisualWidget(
                            visualAsset: item.assetImage,
                            isSelected: DemoData.allMusicData.indexOf(item) ==
                                audioNotifier.currentSongIndex,
                          );
                        },
                      );
                    }).toList(),
                  ),
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      DemoData.allMusicData[audioNotifier.currentSongIndex]
                          .songName,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: CColors.nameTextColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 24),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                    child: Text(
                      DemoData
                          .allMusicData[audioNotifier.currentSongIndex].songBy,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: CColors.singerTextColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 16),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FlatButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onPressed: () {
                      audioNotifier.carouselController.previousPage();
                    },
                    child: Image.asset(
                      "assets/images/previous.png",
                      height: 40,
                      width: 40,
                    ),
                  ),
                  FlatButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onPressed: () {
                      audioNotifier.togglePlayPause();
                    },
                    child: Image.asset(
                      !audioNotifier.isPaused
                          ? "assets/images/pause.png"
                          : "assets/images/play.png",
                      height: 60,
                      width: 60,
                    ),
                  ),
                  FlatButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onPressed: () {
                      audioNotifier.carouselController.nextPage();
                    },
                    child: Image.asset(
                      "assets/images/next.png",
                      height: 40,
                      width: 40,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 120.0),
                child: Column(
                  children: [
                    SliderTheme(
                      data: SliderThemeData(
                          trackHeight: 3, minThumbSeparation: 6),
                      child: Slider(
                        value: audioNotifier.currentProgress.toDouble(),
                        max: audioNotifier.maxProgress.toDouble(),
                        onChanged: audioNotifier.handleSliderValueChange,
                        inactiveColor: CColors.indicatorDark.withOpacity(0.5),
                        activeColor: CColors.indicatorDark,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            audioNotifier.getCurrentProgressInMMSS(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: CColors.nameTextColor,
                                fontWeight: FontWeight.w700,
                                fontSize: 12),
                          ),
                          Text(
                            audioNotifier.getMaxProgressInMMSS(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: CColors.singerTextColor.withOpacity(0.5),
                                fontWeight: FontWeight.w700,
                                fontSize: 12),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
