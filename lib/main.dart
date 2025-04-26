// lib/main.dart

import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    // Temayı önce oluşturup, Roboto fontunu uyguluyoruz:
    final base = ThemeData.dark();
    return MaterialApp(
      title: 'Minimal Drum Kit',
      debugShowCheckedModeBanner: false,
      theme: base.copyWith(
        scaffoldBackgroundColor: Colors.black,
        // Roboto fontunu tüm textTheme'e uygula
        textTheme: base.textTheme.apply(fontFamily: 'Roboto'),
      ),
      home: const DrumPage(),
    );
  }
}

class DrumPage extends StatefulWidget {
  const DrumPage({super.key});
  @override
  State<DrumPage> createState() => _DrumPageState();
}

class _DrumPageState extends State<DrumPage> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final double _padSpacing = 8.0;
  final double _padBorderRadius = 8.0;

  final List<Map<String, dynamic>> _pads = [
    {
      'color': Colors.redAccent,
      'sound': 'bip.wav',
      'label': 'Bip',
      'icon': Icons.music_note,
    },
    {
      'color': Colors.blueAccent,
      'sound': 'bongo.wav',
      'label': 'Bongo',
      'icon': Icons.waves,
    },
    {
      'color': Colors.greenAccent,
      'sound': 'clap1.wav',
      'label': 'Clap 1',
      'icon': Icons.album,
    },
    {
      'color': Colors.orangeAccent,
      'sound': 'clap2.wav',
      'label': 'Clap 2',
      'icon': Icons.back_hand,
    },
    {
      'color': Colors.purpleAccent,
      'sound': 'clap3.wav',
      'label': 'Clap 3',
      'icon': Icons.brightness_1,
    },
    {
      'color': Colors.cyanAccent,
      'sound': 'crash.wav',
      'label': 'Crash',
      'icon': Icons.circle,
    },
    {
      'color': Colors.pinkAccent,
      'sound': 'how.wav',
      'label': 'How',
      'icon': Icons.flash_on,
    },
    {
      'color': Colors.lightBlueAccent,
      'sound': 'oobah.wav',
      'label': 'Oobah',
      'icon': Icons.nightlight_round,
    },
    {
      'color': Colors.tealAccent,
      'sound': 'ridebel.wav',
      'label': 'Ridebel',
      'icon': Icons.surround_sound,
    },
  ];

  Future<void> _playSound(int index) async {
    try {
      await _audioPlayer.play(AssetSource(_pads[index]['sound']));
    } catch (e) {
      debugPrint('Sound error: $e');
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DRUM KIT', style: TextStyle(letterSpacing: 2)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(_padSpacing),
        child: GridView.builder(
          itemCount: _pads.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: _padSpacing,
            mainAxisSpacing: _padSpacing,
            childAspectRatio: 1,
          ),
          itemBuilder: (context, i) => _buildPad(i),
        ),
      ),
    );
  }

  Widget _buildPad(int index) {
    final pad = _pads[index];
    return Card(
      color: pad['color'],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_padBorderRadius),
      ),
      elevation: 0,
      child: InkWell(
        borderRadius: BorderRadius.circular(_padBorderRadius),
        onTap: () => _playSound(index),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(pad['icon'], size: 28, color: Colors.white),
              const SizedBox(height: 4),
              Text(
                pad['label'],
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
