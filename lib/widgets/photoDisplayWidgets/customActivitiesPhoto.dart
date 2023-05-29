import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ActivitiesPhoto extends StatelessWidget {
  final String? photoAdress;
  const   ActivitiesPhoto({Key? key, required this.photoAdress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('photoAdress' + photoAdress.toString());
    return  CircleAvatar(
            child: GestureDetector(
              onTap: () async {
                await showDialog(
                    context: context,
                    builder: (_) =>
                        ImageDialog(photoAdress: photoAdress.toString()),);
              },
            ),
            radius: 30.0,
            //Photo by Tamas Tuzes-Katai on Unsplash
            backgroundImage: NetworkImage(photoAdress.toString()));
  }
}

class ImageDialog extends StatelessWidget {
  final String? photoAdress;
  const ImageDialog({Key? key, required this.photoAdress}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Dialog(
      child: Container(
        width: size.width,
        height: size.height /4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
                image: NetworkImage(photoAdress.toString()),
                fit: BoxFit.cover)),
      ),
    );
  }
}
