import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() => runApp(SelectHospital());

class SelectHospital extends StatefulWidget {
  @override
  _SelectHospitalState createState() => _SelectHospitalState();
}

class _SelectHospitalState extends State<SelectHospital> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Radial Speed Dial"),
          centerTitle: true,
        ),
        body: Stack(
          children: [
            Positioned(
              top: 30,
              left: 10,
              child: ElevatedButton(
                  onPressed: () {
                    if (Get.isDarkMode) {
                      Get.changeTheme(ThemeData.light());
                    } else {
                      Get.changeTheme(ThemeData.dark());
                    }
                  },
                  child: Text("change Theme")),
            )
          ],
        ),
      ),
    );
  }
}
