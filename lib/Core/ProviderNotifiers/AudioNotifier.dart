import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dyeus_music_sample/Core/Helpers/DemoData.dart';
import 'package:dyeus_music_sample/Core/Utils.dart';
import 'package:flutter/cupertino.dart';

///AudioNotifier work like a AudioManager here,
///by managing Player state and UI state as well.

class AudioNotifier extends ChangeNotifier {
  ///Current progress of song in Audio Player in seconds
  int currentProgress = 0;

  ///Max duration of the song currently being played in seconds
  int maxProgress = 0;

  ///Current song index in [DemoData.allMusicData]
  int currentSongIndex = 1;

  ///Helper bool useful in Play/Pause in UI
  bool isPaused = true;

  ///Controller Class for [CarouselSlider]
  CarouselController carouselController = CarouselController();

  ///[AudioCache] a helper class in [AudioPlayer] for playing assets file.
  AudioCache audioCache = AudioCache();

  ///Our main Audio Player
  AudioPlayer audioPlayer = AudioPlayer();

  ///Loading all assets in cache, basically [audioCache.loadAll(fileNames)] loads all assets in temp local directory
  AudioNotifier() {
    audioCache
        .loadAll(DemoData.allMusicData.map((item) => item.assetAudio).toList());
    _addListeners();
  }

  ///Callback for carousal page change. see [CarouselSlider]
  onCarousalPageChanged(int index, CarouselPageChangedReason reason) async {
    currentSongIndex = index;
    notifyListeners();
    audioPlayer.play(audioCache
        .loadedFiles[DemoData.allMusicData[currentSongIndex].assetAudio].path);
    notifyListeners();
  }

  ///Adding audio handlers for UI updates through the inbuilt provided streams
  void _addListeners() {
    audioPlayer.onAudioPositionChanged.listen((event) {
      currentProgress = event.inSeconds;
      notifyListeners();
    });
    audioPlayer.onDurationChanged.listen((event) {
      maxProgress = event.inSeconds;
      notifyListeners();
    });

    audioPlayer.onPlayerStateChanged.listen((event) {
      if (event == AudioPlayerState.PLAYING) {
        isPaused = false;
      } else
        isPaused = true;
      notifyListeners();
    });
  }

  ///Handling play/pause
  void togglePlayPause() async {
    if (audioPlayer != null) {
      if (audioPlayer.state == AudioPlayerState.PLAYING) {
        audioPlayer.pause();
      } else if (audioPlayer.state == AudioPlayerState.PAUSED) {
        audioPlayer.resume();
      } else if (audioPlayer.state == AudioPlayerState.COMPLETED ||
          audioPlayer.state == null) {
        audioPlayer.play(audioCache
            .loadedFiles[DemoData.allMusicData[currentSongIndex].assetAudio]
            .path);
      }
    }
  }

  ///Handling slider value change
  void handleSliderValueChange(double value) {
    if (audioPlayer != null) {
      audioPlayer.seek(Duration(seconds: value.toInt()));
    }
  }

  ///Converting seconds into mm:ss format
  String getCurrentProgressInMMSS() {
    var dur = Duration(seconds: currentProgress);
    return Utils.getStringFromDuration(dur);
  }

  ///Converting seconds into mm:ss format
  String getMaxProgressInMMSS() {
    var dur = Duration(seconds: maxProgress);
    return Utils.getStringFromDuration(dur);
  }
}
