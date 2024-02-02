import 'package:flutter/material.dart';
import 'package:musicappapp/model/music_model.dart';

import 'package:musicappapp/page/my_app.dart';
import 'package:musicappapp/nav_bar/bottom_nav_bar.dart';
import 'package:musicappapp/nav_bar/flat_nav_bar.dart';
import 'package:musicappapp/page/screen/bluetooth_page.dart';
import 'package:musicappapp/page/screen/serch_page.dart';
import 'package:musicappapp/view_model/project_view_model.dart';
import 'package:musicappapp/widget/bottom_panel_widget.dart';

import 'package:provider/provider.dart';

import 'page/screen/setting_page.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  PageController pageController = PageController();

  void _changeCurrentTab(int tab) {
    setState(() {
      pageController.jumpToPage(tab);
      index = tab;
    });
  }

  int index = 0;
  int oneTimeSnack = 0;
  bool visible = false;
  double height = 0;

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) async {
    //   Provider.of<ProjectViewModel>(context, listen: false)
    //       .initAudioPlayers();
    // });
  }

  @override
  Widget build(BuildContext context) {
    ProjectViewModel projectViewModel = Provider.of(context);
    return WillPopScope(
      onWillPop: () async {
        switch (index) {
          case 0:
            return false;
          case 1:
            _changeCurrentTab(0);
            return false;
          case 2:
            _changeCurrentTab(0);
            return false;
          case 3:
            _changeCurrentTab(0);
            return false;
          case 4:
            _changeCurrentTab(0);
            return false;
          default:
            return true;
        }
      },
      child: Scaffold(
    bottomSheet: Visibility(
        visible: projectViewModel.activeS?.isEnabled??false,
        child: BottomPanelWidget(musicModel: projectViewModel.activeS)),
        bottomNavigationBar: BottomNavBar(
          changeIndex: _changeCurrentTab,
          index: index,
        ),
        body: PageView(
          controller: pageController,
          physics: const NeverScrollableScrollPhysics(),
          onPageChanged: (int pageIndex) {
            index = pageIndex;
          },
          children: [
            MyApp(),
            SearchPage(),
            Scaffold(),
            BluetoothPage(),
            SettingPage(),          ],
        ),
      ),
    );
  }
}
// Widget _buildBottomPanel(BuildContext context) {
//   ProjectViewModel projectViewModel = Provider.of(context);
//   return StreamBuilder<dynamic>(
//     stream: projectViewModel.player.playerStateStream,
//     builder: (context, snapshot) {
//       final playbackState = snapshot.data;
//       final bool playing = playbackState?.playing ?? false;
//
//       return Container(
//         decoration: BoxDecoration(
//           color: Colors.pinkAccent,
//         ),
//         padding: EdgeInsets.all(16.0),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             IconButton(
//               icon: Icon(playing ? Icons.pause : Icons.play_arrow),color: Colors.white,
//               onPressed: () {
//                 if (playing) {
//                   projectViewModel.pauseOne();
//                 } else {
//                   projectViewModel.playOne();
//                 }
//               },
//             ),
//             IconButton(
//               icon: Icon(Icons.stop,color: Colors.white,),
//               onPressed: () {
//                 projectViewModel.stopOne();
//               },
//             ),
//             // Add more controls as needed (e.g., seek bar, volume control)
//           ],
//         ),
//       );
//     },
//   );
// }

