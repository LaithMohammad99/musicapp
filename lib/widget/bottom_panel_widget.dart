import 'package:flutter/material.dart';
import 'package:musicappapp/model/music_model.dart';
import 'package:musicappapp/view_model/project_view_model.dart';
import 'package:provider/provider.dart';

class BottomPanelWidget extends StatefulWidget {
  final MusicModel? musicModel;

  const BottomPanelWidget({super.key, this.musicModel});

  @override
  State<BottomPanelWidget> createState() => _BottomPanelWidgetState();
}




class _BottomPanelWidgetState extends State<BottomPanelWidget> {
  ProjectViewModel? projectViewModel;

  @override
  void initState() {
    // projectViewModel = Provider.of(context);

    // TODO: implement initState
    super.initState();
  }
  @override
  void dispose() {
    projectViewModel?.player.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    ProjectViewModel projectViewModel = Provider.of(context);
    return SizedBox(
      height: 80,
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xff593B4C), Colors.black45],
              ),
            ),
            child: Row(
              children: [
                Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      image: DecorationImage(
                          image: AssetImage(
                            projectViewModel.image,
                          ))),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  projectViewModel.name,
                  style:
                  const TextStyle(color: Colors.white, fontSize: 20),
                ),
                const SizedBox(
                  width: 110,
                ),
                InkWell(
                  onTap: () {
                    if(projectViewModel.isPlayed==true) {
                      projectViewModel.pause(widget.musicModel??MusicModel());
                    }else {
                      projectViewModel.play(widget.musicModel??MusicModel());

                    }

                  },
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Icon(
                      projectViewModel.isPlayed
                          ? Icons.pause
                          : Icons.play_arrow,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Positioned(
          //   top: 60,
          //   child: Slider(
          //     mouseCursor: MouseCursor.uncontrolled,
          //     value: projectViewModel.position.inSeconds.toDouble(),
          //     onChanged: (onChanged) {},
          //     max: projectViewModel.duration.inSeconds.toDouble(),
          //     min: 0,
          //   ),
          // )
        ],
      ),
    );
  }

}

