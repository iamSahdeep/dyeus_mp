import 'package:dyeus_music_sample/Core/DataModel/MusicData.dart';

///Sample Data for music player
mixin DemoData {
  static final allMusicData = [
    MusicData(
        assetAudio: "music/catwalk.mp3",
        assetImage: "assets/images/ImageVisual.png",
        songName: "Cat Walk",
        songBy: "Arulo"),
    MusicData(
        assetAudio: "music/deepurban.mp3",
        assetImage: "assets/images/ImageVisual.png",
        songName: "Deep Urban",
        songBy: "Eugenio Mininni"),
    MusicData(
        assetAudio: "music/lifeisadream.mp3",
        assetImage: "assets/images/ImageVisual.png",
        songName: "Life is a Dream",
        songBy: "Michael Ramir C."),
  ];
}
