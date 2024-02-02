import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_audio_waveforms/flutter_audio_waveforms.dart';
import 'package:just_audio/just_audio.dart';
import 'package:musicappapp/page/music_details.dart';
import 'package:musicappapp/widget/bottom_panel_widget.dart';
import 'package:musicappapp/widget/muisc_widget.dart';
import 'package:musicappapp/model/music_model.dart';
import 'package:musicappapp/view_model/project_view_model.dart';
import 'package:provider/provider.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // musicInit() {
  //  _player.setAsset("assets/Al-Fatihah.mp3");
  //  _duration= _player.duration??Duration();
  //
  //   // print(totalTime);
  // }

  @override
  void initState() {

    super.initState();
  }

  MusicModel? musicModel;

  @override
  Widget build(BuildContext context) {
    ProjectViewModel projectViewModel = Provider.of(context);
    return SafeArea(
      child: Scaffold(
        // bottomSheet: Visibility(visible: projectViewModel.isPlayed,child: BottomPanelWidget(musicModel: musicModel)),
        backgroundColor: const Color(0xff232A31),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "All Quran",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 30,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: MusicWidget(
                        musicModel: projectViewModel.musicList[index],

                      ),

                    ),
                    itemCount: projectViewModel.musicList.length,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

