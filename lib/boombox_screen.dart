import 'package:audioplayers/audioplayers.dart';
import 'package:boombox/boombox_painter.dart';
import 'package:boombox/boombox_service.dart';
import 'package:flutter/material.dart';

class BoomboxScreen extends StatefulWidget {
  const BoomboxScreen({super.key});

  @override
  State<BoomboxScreen> createState() => _BoomboxScreenState();
}

class _BoomboxScreenState extends State<BoomboxScreen>
    with SingleTickerProviderStateMixin {
  static const Size _size = Size(300, 300);
  static const double _volumeMultiplier = 8.0;

  final AudioPlayer _audioPlayer = AudioPlayer();
  late final AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _initAnimation();
    _initVolumeListener();
    _playAudio();
  }

  void _initAnimation() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 550),
    )..repeat();

    _setAnimation();
  }

  void _initVolumeListener() {
    BoomboxService.startListening((volume) {
      setState(() {
        _setAnimation(volume: volume);
      });
    });
  }

  void _setAnimation({int volume = 0}) {
    _animation = Tween<double>(begin: 0, end: volume * _volumeMultiplier)
        .animate(_controller);
  }

  Future<void> _playAudio() async {
    await _audioPlayer.play(AssetSource('audio.mp3'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
          animation: _animation,
          builder: (_, __) => CustomPaint(
            painter: BoomboxPainter(volumeRadius: _animation.value),
            size: _size,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    BoomboxService.stopListening();
    _controller.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }
}
