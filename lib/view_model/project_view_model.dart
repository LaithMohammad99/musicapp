import 'package:flutter/cupertino.dart';
import 'package:just_audio/just_audio.dart';
import 'package:musicappapp/model/music_model.dart';

class ProjectViewModel with ChangeNotifier {
  final player = AudioPlayer();

  List<MusicModel> musicList = [
    MusicModel(
        path: "assets/Al-Fatihah.mp3",
        name: "Fatihah",
        nameTow: "maher",
        image: 'assets/maher1.jpeg',
        id: 0,
        duration: 2222),
    MusicModel(
        path: "assets/Al_kwther.mp3",
        name: "Al_kwther",
        nameTow: "Omar",
        image: 'assets/maher2.jpeg',
        id: 1,
        duration: 3222),

  ];

  bool isPlayed = false;
  String name = "";
  String image = "";
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  MusicModel? activeS;
  int currentIndex = 0;
  int selectedPlayer = 0; // 0 for player1, 1 for player2



  void initAudioPlayers() async {
    try {
      for (var song in musicList) {
        await player.setAsset(song.path??"");
        song.isEnabled = true;
        await player.stop();
      }
    } catch (e) {
      print('Error initializing audio players: $e');
    }
  }
  void playSong(MusicModel song) async {
    if (song.isEnabled??false) {
      await player.setAsset(song.path??"");
      await player.play();
    }
  }

  setActive(MusicModel item) {
    activeS = item;
    notifyListeners();
  }

  Future<void> seek(dynamic position) async {
    player.seek(position);
  }

  Future<void> next() async {
    if (currentIndex < musicList.length - 1) {
      currentIndex++;
      await player.setAsset(musicList[currentIndex].path.toString());
      name = musicList[currentIndex].name ?? "";
      image = musicList[currentIndex].image ?? "";
      await player.play();
      notifyListeners();
    }
  }

  Future<void> playOne() async {
    await player.play();
  }

  Future<void> pauseOne() async {
    await player.pause();
    isPlayed=false;
    notifyListeners();
  }
  Future<void> stopOne() async {
    await player.stop();
  }
  Future<void> initAudioPlayer() async {
    await player.setAsset(musicList[currentIndex].path ?? "");
    player.durationStream.listen((duration) {
      duration = duration;
      print('Duration: $duration');
    });
    player.positionStream.listen((position) {
      position = position;
      print('Position: $position');
    });
  }

  Future<void> previous() async {
    if (currentIndex > 0) {
      currentIndex--;
      await player.setAsset(musicList[currentIndex].path ?? "");
      await player.play();
    }
  }

  pauseAndPlayed() {
    activeS?.isEnabled = !(activeS?.isEnabled ?? false);
  }

  Future<void> pause(MusicModel item) async {
    if (item.isEnabled == true) {
      player.pause();
      item.isEnabled = true;
      isPlayed = true;
      notifyListeners();
    }
  }

  void playSelectedAudio(int selectedPlayer) {
    // Stop the currently playing audio
    if (selectedPlayer == 0) {
      player.stop();
    } else {
      player.stop();
    }

    // Play the selected audio
    if (selectedPlayer == 0) {
      player.setAsset(musicList[0].path??"");
    } else {
      player.setAsset(musicList[1].path??"");
    }
    selectedPlayer = selectedPlayer;
notifyListeners();

  }

  Future<void> play(MusicModel item) async {
    try {
      if (activeS != item) {
        activeS = item;

        for (var element in musicList) {
          element.isEnabled = false;
        }
        player.setAsset(item.path ?? "");
        await player.play();
        notifyListeners();

        name = item.name ?? "";
        image = item.image ?? "";
        notifyListeners();

        item.isEnabled = true;
        notifyListeners();
      } else {
        await player.play();
      }
    } catch (e) {
      print(e);
    }
  }
}
