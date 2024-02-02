import 'package:flutter/material.dart';
import 'package:flutter_audio_waveforms/flutter_audio_waveforms.dart';
import 'package:just_audio/just_audio.dart';
import 'package:musicappapp/model/music_model.dart';
import 'package:musicappapp/view_model/project_view_model.dart';
import 'package:musicappapp/widget/bottom_panel_widget.dart';
import 'package:provider/provider.dart';

class MusicDetails extends StatefulWidget {
  final MusicModel musicModel;

  const MusicDetails({super.key, required this.musicModel});

  @override
  State<MusicDetails> createState() => _MusicDetailsState();
}

class _MusicDetailsState extends State<MusicDetails> {
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  @override
  void initState() {
    // WidgetsBinding.instance.addPostFrameCallback((_) async {
    //   Provider.of<ProjectViewModel>(context, listen: false).initAudioPlayer();
    // });
    super.initState();
  }

  AudioPlayer audioPlayer = AudioPlayer();
  Stream? postStream;

  @override
  Widget build(BuildContext context) {
    ProjectViewModel projectViewModel = Provider.of(context);
    return Scaffold(
      backgroundColor: const Color(0xff232A31),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    color: Colors.white,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back_ios),
                  ),
                  const Text(
                    "Now Playing",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  const Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 100,
            ),
            CircleAvatar(
              radius: 120,
              backgroundImage: AssetImage(widget.musicModel.image ?? ""),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: Colors.white)),
                      child: const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.favorite_border,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Text(
                              "Follow",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.pinkAccent,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: Colors.white)),
                      child: const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.play_circle_sharp,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Text(
                              "CHUFFLE PLAY",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Text(
              widget.musicModel.name ?? "",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            Text(
              widget.musicModel.nameTow ?? "",
              style:
                  TextStyle(color: Colors.grey.withOpacity(0.4), fontSize: 20),
            ),
            Slider(
              value: projectViewModel.position.inSeconds.toDouble(),
              min: 0,
              max: projectViewModel.duration.inSeconds.toDouble(),
              onChanged: (double value) {
                projectViewModel.seek(value);

              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  StreamBuilder<dynamic>(
                    stream: projectViewModel.player.durationStream,
                    builder: (context, snapshot) {
                      final duration = snapshot.data ?? Duration.zero;
                      return Text(
                        '$duration',
                        style: const TextStyle(color: Colors.white),
                      );
                    },
                  ),
                  StreamBuilder<dynamic>(
                    stream: projectViewModel.player.positionStream,
                    builder: (context, snapshot) {
                      final position = snapshot.data ?? Duration.zero;
                      return Text(
                        '$position',
                        style: TextStyle(color: Colors.white),
                      );
                    },
                  ),
                ],
              ),
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      projectViewModel.previous();
                    },
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Transform.flip(
                    flipX: true,
                    child: const Icon(
                      Icons.double_arrow,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (widget.musicModel.isEnabled ?? false) {
                        projectViewModel.pause(widget.musicModel);
                        setState(() {
                          widget.musicModel.isEnabled = false;
                        });
                      } else {
                        projectViewModel.play(widget.musicModel);
                        setState(() {
                          widget.musicModel.isEnabled = true;
                        });
                      }
                    },
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: const BoxDecoration(
                          color: Colors.white, shape: BoxShape.circle),
                      child: Icon(
                        projectViewModel.player.playing
                            ? Icons.pause
                            : Icons.play_arrow,
                        color: Colors.black,
                        size: 50,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  const Icon(
                    Icons.double_arrow,
                    color: Colors.white,
                    size: 30,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () {
                      projectViewModel.next();

                    },
                    child: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
