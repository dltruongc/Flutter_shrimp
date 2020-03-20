import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

typedef void OnError(Exception exception);

enum PlayerState { stopped, playing, paused }

class PlayerWidget extends StatefulWidget {
  final String url;

  PlayerWidget(this.url);

  @override
  _PlayerWidgetState createState() => _PlayerWidgetState(url);
}

class _PlayerWidgetState extends State<PlayerWidget> {
  final String url;

  _PlayerWidgetState(this.url);

  Duration duration;
  Duration position;

  AudioPlayer audioPlayer;

  String localFilePath;

  PlayerState playerState = PlayerState.stopped;

  get isPlaying => playerState == PlayerState.playing;

  get isPaused => playerState == PlayerState.paused;

  get durationText =>
      duration != null ? duration.toString().split('.').first : '';

  get positionText =>
      position != null ? position.toString().split('.').first : '';

  double vol = 0.7;

  StreamSubscription _positionSubscription;
  StreamSubscription _audioPlayerStateSubscription;
  StreamSubscription _durationSubscription;

  @override
  void initState() {
    super.initState();
    initAudioPlayer();
  }

  @override
  void dispose() {
    _positionSubscription.cancel();
    _audioPlayerStateSubscription.cancel();
    _durationSubscription.cancel();
    audioPlayer.stop();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    audioPlayer.stop();
  }

  void initAudioPlayer() {
    audioPlayer = AudioPlayer();
    _positionSubscription = audioPlayer.onAudioPositionChanged
        .listen((p) => setState(() => position = p));
    _durationSubscription = audioPlayer.onDurationChanged
        .listen((d) => setState(() => duration = d));
    _audioPlayerStateSubscription =
        audioPlayer.onPlayerStateChanged.listen((s) {
      if (s == AudioPlayerState.PLAYING) {
      } else if (s == AudioPlayerState.STOPPED) {
        onComplete();
        setState(() {
          position = duration;
        });
      }
    }, onError: (msg) {
      setState(() {
        playerState = PlayerState.stopped;
        duration = Duration(seconds: 0);
        position = Duration(seconds: 0);
      });
    });
  }

  Future play() async {
    if (playerState == PlayerState.paused) {
      await audioPlayer.resume();
    } else {
      await audioPlayer.play(url);
    }
    setState(() {
      playerState = PlayerState.playing;
    });
  }

  Future pause() async {
    await audioPlayer.pause();
    setState(() => playerState = PlayerState.paused);
  }

  Future stop() async {
    await audioPlayer.stop();
    playerState = PlayerState.stopped;
    setState(() {
      position = Duration(milliseconds: 1);
    });
  }

  Future seek() async {
    final dur = Duration(seconds: (10 + position.inSeconds));
    if (dur.inSeconds < duration.inSeconds - 10) {
      await audioPlayer.seek(dur);
      setState(() {
        position = Duration(seconds: (10 + position.inSeconds));
      });
    }
  }

  Future setVolume(double _vol) async {
    await audioPlayer.setVolume(_vol);
    setState(() {
      vol = _vol;
    });
  }

  void onComplete() {
    setState(() => playerState = PlayerState.stopped);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2.0,
      color: Colors.white,
      child: Center(
        child: Container(
          child: _buildPlayer(),
        ),
      ),
    );
  }

  Widget _buildPlayer() => Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(mainAxisSize: MainAxisSize.min, children: [
              IconButton(
                  onPressed: () => setVolume(vol >= 0.2 ? vol - 0.2 : 0),
                  icon: Icon(Icons.volume_down),
                  iconSize: 48.0,
                  color: Colors.cyan),
              IconButton(
                  onPressed: isPlaying ? null : () => play(),
                  iconSize: 48.0,
                  icon: Icon(Icons.play_arrow),
                  color: Colors.cyan),
              IconButton(
                  onPressed: isPlaying ? () => pause() : null,
                  iconSize: 48.0,
                  icon: Icon(Icons.pause),
                  color: Colors.cyan),
              IconButton(
                  onPressed: isPlaying || isPaused ? () => stop() : null,
                  iconSize: 48.0,
                  icon: Icon(Icons.stop),
                  color: Colors.cyan),
              IconButton(
                  onPressed: () => setVolume(vol <= 0.8 ? vol + 0.2 : 0),
                  icon: Icon(Icons.volume_up),
                  iconSize: 48.0,
                  color: Colors.cyan),
            ]),
            duration == null
                ? Slider(
                    activeColor: Colors.grey,
                    value: 0,
                    onChanged: (double value) {},
                  )
                : Slider(
                    activeColor: Colors.cyan,
                    value: position?.inMilliseconds?.toDouble() ?? 0.0,
                    onChanged: (double value) => audioPlayer
                        .seek(Duration(seconds: (value / 1000).floor())),
                    min: 0.0,
                    max: duration.inMilliseconds.toDouble()),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                    position != null
                        ? "${positionText ?? ''} / ${durationText ?? ''}"
                        : duration != null ? durationText : '--:--',
                    style: TextStyle(fontSize: 24.0, color: Colors.cyan))
              ],
            )
          ],
        ),
      );
}
