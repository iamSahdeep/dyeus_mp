import 'package:flutter/cupertino.dart';

///Model class for Demo Data.
class MusicData {
  final String assetImage;
  final String assetAudio;
  final String songName;
  final String songBy;

  MusicData({
    @required this.assetImage,
    @required this.assetAudio,
    @required this.songName,
    @required this.songBy,
  });
}
