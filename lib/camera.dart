import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:io';


class Camera extends StatelessWidget {
  const Camera({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  late CameraController _controller;
  late Future<void> _initController;
  var isCameraReady = false;
  late XFile imageFile;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initCamera();
    WidgetsBinding.instance?.addObserver(this);
  }
  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    _controller.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if(state == AppLifecycleState.resumed) {
      _initController = _controller.initialize();
    }
    if(!mounted) {
      return;
    }
    setState(() {
      isCameraReady = true;
    });
  }

  Widget cameraWidget(context) {
    var camera = _controller.value;
    final size = MediaQuery.of(context).size;
    var scale = size.aspectRatio * camera.aspectRatio;
    if(scale < 1) {
      scale = 1 / scale;
    }
    return Transform.scale(scale: scale, child: Center(child: CameraPreview(_controller)));
  }
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(

      body: FutureBuilder(
        future: _initController,
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.done)
          {
            return Stack(children: [
              cameraWidget(context),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  color: Color(0xAA332639),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      IconButton(
                          iconSize: 40,
                          icon: Icon(Icons.camera_alt, color: Colors.white),
                          onPressed: () => captureImage(context))
                    ],
                  ),
                ),
              )
            ],
            );
          }
          else {
            return Center(child: CircularProgressIndicator(),);
          }
        },
      ),

    );
  }
  Future<void> initCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;
    _controller = CameraController(firstCamera, ResolutionPreset.high);
    _initController = _controller.initialize();
    if(!mounted) {
      return;
    }
    setState(() {
      isCameraReady = true;
    });
  }

  captureImage(BuildContext context) {
    _controller.takePicture().then((file) {
      setState(() {
        imageFile = file;
      });
      if(mounted)
      {
        Navigator.push(context, MaterialPageRoute(builder: (context) =>
            DisplayPictureScreen(
                image: imageFile
            )));
      }
    });
  }
}

class DisplayPictureScreen extends StatelessWidget {
  final XFile image;

  DisplayPictureScreen({Key? key, required this.image}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Display'),),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Image.file(File(image.path), fit: BoxFit.fill,),
      ),
    );
  }
}
