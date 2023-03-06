import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../utils/themes.dart';
import '../../utils/utils.dart';

class CustomCardWithImage extends StatefulWidget {
  final String cardName;
  final String? imageUrl;
  final VoidCallback? onPressed;
  final bool isIcon;

  const CustomCardWithImage(
      {super.key,
      required this.cardName,
      this.imageUrl,
      this.onPressed,
      this.isIcon = true});

  @override
  State<CustomCardWithImage> createState() => _CustomCardWithImageState();
}

class _CustomCardWithImageState extends State<CustomCardWithImage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 230,
        child: Stack(children: [
          Positioned(
            child: Material(
              child: Padding(
                padding: EdgeInsets.all(height_24),
                child: Container(
                    height: 180.0,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            offset: Offset(-10.0, 10.0),
                            blurRadius: 20.0,
                            spreadRadius: 4.0)
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                    )),
              ),
            ),
          ),
          Positioned(
              top: 35,
              left: 30,
              child: Card(
                elevation: 10.0,
                shadowColor: Colors.grey.withOpacity(0.3),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0)),
                child: Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage(widget.imageUrl ??
                              APPImages.splashScreen.images))),
                ),
              )),
          Positioned(
              top: widget.isIcon ? 90 : 110,
              left: 220,
              child: Container(
                height: 150,
                width: 130,
                child: Column(
                  children: [
                    Text(
                      widget.cardName,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 17,
                          color: Color(0xFF363f93),
                          fontWeight: FontWeight.bold),
                    ),
                    widget.isIcon
                        ? IconButton(
                            onPressed: widget.onPressed ?? () {},
                            icon: Icon(
                              Icons.arrow_circle_right,
                              color: Color(0xFF363f93),
                              size: 40,
                            ))
                        : Container()
                  ],
                ),
              ))
        ]));
  }
}
