// A screen that allows users to take a picture using a given camera.
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:win_kamu/pages/WorkOrder/WoCreate.dart';
import 'package:win_kamu/pages/new_notif/new_notif_base.dart';
import 'package:win_kamu/providers/work_order_view_provider.dart';
import 'package:win_kamu/providers/new_notif_provider.dart';
import 'package:win_kamu/utils/themes.dart';

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
        title: const Text('Fotoğraf Çek',style: TextStyle(color:Colors.black),),
           leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);

                },
                icon: Icon(Icons.arrow_back, color: Colors.black)),
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        
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

        File imagefile = File(image.path); //convert Path to File
        Uint8List imagebytes = await imagefile.readAsBytes(); //convert to bytes
        String base64string = base64.encode(imagebytes); //convert bytes to base64 string

            if (!mounted) return;

            // If the picture was taken, display it on a new screen.
            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => DisplayPictureScreen(
                  // Pass the automatically generated path to
                  // the DisplayPictureScreen widget.
                  base64: base64string,
                  imagePath: image.path,
                  sayfa:  widget.sayfa,
                ),
              ),
            );
          } catch (e) {
            // If an error occurs, log the error to the console.
            print(e);
          }
        },
        child: const Icon(Icons.camera_alt,color: Colors.black,),
      ),
    );
  }
}

// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;
  final String base64;
  final String sayfa;

  const DisplayPictureScreen({super.key,required this.base64, required this.imagePath, required this.sayfa});

  @override
  Widget build(BuildContext context) {

    final woProvider = Provider.of<WorkOrderViewProvider>(context, listen: false);


    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
        title: const Text('Fotoğraf Çek',style: TextStyle(color:Colors.black),),
           leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);

                },
                icon: Icon(Icons.arrow_back, color: APPColors.Main.black)),
        
        ),
        
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              height: 60.h,
              child:Image.file(File(imagePath)),
            ),
            
            Center(child: Container(
              width: 35.w,
              child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: APPColors.Login.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(20), // <-- Radius
                            ),
                          ),
                          onPressed: () {
                            woProvider.setPhotos = imagePath.toString();
                            woProvider.setB64 = base64.toString();
                            print(woProvider.photos);
                              
                      Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: ((context) =>  WoCreate() )));
                            
                            
                          },
                          child: Text('Ekle'),
                        ),
            ),)
          ],
        ),
      ),
    );
  }
}