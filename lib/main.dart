import 'package:dyeus_music_sample/Core/ProviderNotifiers/AudioNotifier.dart';
import 'package:dyeus_music_sample/UI/Screens/PlayerScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AudioNotifier>(
      create: (context) => AudioNotifier(),
      child: MaterialApp(
        title: 'Music Player',
        theme: ThemeData(
            primarySwatch: Colors.blue,
            textTheme:
                GoogleFonts.dmSansTextTheme(Theme.of(context).textTheme)),
        home: PlayerScreen(),
      ),
    );
  }
}
