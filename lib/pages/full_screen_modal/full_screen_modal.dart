// A screen that allows users to take a picture using a given camera.
// ignore_for_file: use_build_context_synchronously, avoid_print, deprecated_member_use

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:win_kamu/pages/new_notif/new_notif_base.dart';
import 'package:win_kamu/providers/new_notif_provider.dart';
import 'package:win_kamu/utils/themes.dart';
import 'package:win_kamu/widgets/appbar/custom_main_appbar.dart';

import '../../l10n/locale_keys.g.dart';

class TakePictureScreen extends StatefulWidget {
  const TakePictureScreen({
    super.key,
    required this.camera,
    required this.sayfa,
  });

  final CameraDescription camera;
  final String sayfa;
  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    // To display the current output from the Camera,
    // create a CameraController.
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.camera,
      // Define the resolution to use.
      ResolutionPreset.medium,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Fill this out in the next steps.
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Fotoğraf Çek',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back, color: Colors.black))
      ),
      // You must wait until the controller is initialized before displaying the
      // camera preview. Use a FutureBuilder to display a loading spinner until the
      // controller has finished initializing.
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the Future is complete, display the preview.
            return CameraPreview(_controller);
          } else {
            // Otherwise, display a loading indicator.
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        // Provide an onPressed callback.
        onPressed: () async {
          // Take the Picture in a try / catch block. If anything goes wrong,
          // catch the error.
          try {
            // Ensure that the camera is initialized.
            await _initializeControllerFuture;

            // Attempt to take a picture and get the file `image`
            // where it was saved.
            final image = await _controller.takePicture();
            final nProvider = Provider.of<NewNotifProvider>(context, listen: false);

            File imagefile = File(image.path); //convert Path to File
            Uint8List imagebytes = await imagefile.readAsBytes(); //convert to bytes
            String base64string = base64.encode(imagebytes); //convert bytes to base64 string
            nProvider.setimagePath = image.path.toString();
            nProvider.setbase64 = base64string.toString();

            if (!mounted) return;
            if (widget.sayfa == 'addPhoto') {
              Navigator.pop(context);
            }
            // If the picture was taken, display it on a new screen.,
            else {
              await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DisplayPictureScreen(
                    // Pass the automatically generated path to
                    // the DisplayPictureScreen widget.
                    base64: base64string,
                    imagePath: image.path,
                    sayfa: widget.sayfa,
                  ),
                ),
              );
            }
          } catch (e) {
            // If an error occurs, log the error to the console.
            print(e);
          }
        },
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}

// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;
  final String base64;
  final String sayfa;

  const DisplayPictureScreen({super.key, required this.base64, required this.imagePath, required this.sayfa});

  @override
  Widget build(BuildContext context) {
    final nProvider = Provider.of<NewNotifProvider>(context, listen: false);

    return Scaffold(
      appBar: const CustomMainAppbar(title: LocaleKeys.pictureTitle),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Column(
        children: [
          Image.file(File(imagePath)),
          Center(
            child: SizedBox(
              width: 35,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: APPColors.Login.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20), // <-- Radius
                  ),
                ),
                onPressed: () {
                  nProvider.setPhotos = imagePath.toString();
                  nProvider.setB64 = base64.toString();
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => NewNotifBase(
                                sayfa: sayfa,
                              ))));
                },
                child: const Text('Ekle'),
              ),
            ),
          )
        ],
      ),
    );
  }
}
