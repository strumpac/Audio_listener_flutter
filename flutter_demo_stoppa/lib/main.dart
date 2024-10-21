import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:quickalert/quickalert.dart';

void main() {
  runApp(const ListenAudio());
}

class ListenAudio extends StatelessWidget {
  const ListenAudio({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
          brightness: Brightness.dark,
        ),
      ),
      home: const ListenerHomePage(),
    );
  }
}

class ListenerHomePage extends StatefulWidget {
  const ListenerHomePage({super.key});

  @override
  State<ListenerHomePage> createState() => _ListenerHomePageState();
}

class _ListenerHomePageState extends State<ListenerHomePage> {
  FilePickerResult? result;

  AudioPlayer audioPlayer = AudioPlayer();
  double playRate = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Audio listener',
          style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Raleway',
              color: Colors.black),
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          children: [
            Image.network(
              'https://static.vecteezy.com/system/resources/previews/023/986/631/original/whatsapp-logo-whatsapp-logo-transparent-whatsapp-icon-transparent-free-free-png.png',
              height: 300,
            ),
            result == null
                ? const Text('scegli un vocale')
                : Text(result!.files.single.name),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: playAudio,
                  icon: const Icon(Icons.play_arrow),
                  iconSize: 100,
                ),
                IconButton(
                  onPressed: alertCall,
                  icon: const Icon(Icons.warning),
                ),
                ElevatedButton(
                  onPressed: playbackRate,
                  child: Text('x$playRate'),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: pickFile,
        child: const Icon(Icons.audio_file),
      ),
    );
  }

  void pickFile() async {
    result = await FilePicker.platform.pickFiles(
        initialDirectory:
            'OnePlus Nord CE Lite 2/Android/media/com.whatsapp/WhatsApp/Media/Whatsapp Voice Notes');
    if(result!.files.single.extension == "opus")
    {
      setState(() {});
    }else{
      alertCall();
    }
  }

  void playAudio() {
    if (result != null) {
      audioPlayer.play(DeviceFileSource(result!.files.single.path!));
    }
  }

  void playbackRate() {
    playRate = playRate == 1 ? 2 : 1;
    audioPlayer.setPlaybackRate(playRate);
    setState(() {});
  }

  void alertCall() {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
      title: 'Oops...',
      text: 'Il file selezionato non è un audio',
    );
  }
}
