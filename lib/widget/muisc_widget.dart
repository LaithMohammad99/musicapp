import 'package:flutter/material.dart';
import 'package:flutter_audio_waveforms/flutter_audio_waveforms.dart';
import 'package:musicappapp/page/music_details.dart';
import 'package:musicappapp/view_model/project_view_model.dart';
import 'package:provider/provider.dart';

import '../model/music_model.dart';

class MusicWidget extends StatefulWidget {
  final MusicModel musicModel;

  const MusicWidget({
    super.key,
    required this.musicModel,
  });

  @override
  State<MusicWidget> createState() => _MusicWidgetState();
}

class _MusicWidgetState extends State<MusicWidget> {
  @override
  Widget build(BuildContext context) {
    ProjectViewModel projectViewModel = Provider.of(context);
    return StreamBuilder<dynamic>(
      stream: projectViewModel.player.playerStateStream,
        builder: (context, snapshot) {
          final playbackState = snapshot.data;
          final bool playing = playbackState?.playing ?? false;

          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) =>
                          MusicDetails(musicModel: widget.musicModel)));
            },
            child: AnimatedContainer(
              decoration: BoxDecoration(
                  color: widget.musicModel.isEnabled??false
                      ? const Color(0xffF1F2F6).withOpacity(0.3)
                      :const Color(0xff232A31) ,
                  borderRadius: BorderRadius.circular(20)),
              duration: const Duration(milliseconds: 800),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: (){
                        if(widget.musicModel.isEnabled??false)
                          {
                            projectViewModel.pause(widget.musicModel);
                            setState(() {
                              widget.musicModel.isEnabled=false;
                            });

                          }else {
                          projectViewModel.play(widget.musicModel);
                          setState(() {
                            widget.musicModel.isEnabled=true;
                          });
                        }
                      },
                      child:widget.musicModel.isEnabled??false
                          ?   const CircleAvatar(
                        backgroundColor: Colors.pinkAccent,
                        child: Icon(
                          Icons.pause,
                          color: Colors.white,
                        ),
                      )
                          :
                      const CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.play_arrow,
                          color: Colors.pink,
                        ),
                      )

                    ),
                    const SizedBox(
                      width: 20,
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.musicModel.name ?? "",
                          style: const TextStyle(color: Colors.white),
                        ),
                        Text(
                          widget.musicModel.nameTow ?? "",
                          style: TextStyle(color: Colors.grey.withOpacity(0.3)),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 100,
                    ),

                    // Text( musicList[index].duration.toString(),style: TextStyle(color: Colors.white),),
                  ],
                ),
              ),
            ),
          );
        }
    );
  }
}
// onTap: () {
//   if (projectViewModel.player.playing) {
//     projectViewModel.pause(widget.musicModel);
//     setState(() {
//       widget.musicModel.isEnabled = false;
//     });
//   } else {
//     projectViewModel.play(widget.musicModel);
//     setState(() {
//       widget.musicModel.isEnabled = true;
//     });
//   }
// },
