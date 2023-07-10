// ignore_for_file: prefer_const_constructors_in_immutables,prefer_const_constructors,prefer_const_literals_to_create_immutables,file_names,constant_identifier_names,unnecessary_new

import 'package:flutter/material.dart';
import 'package:win_kamu/utils/utils.dart';

class CustomDialog extends StatelessWidget {
  final String description, confirmButtonText;
  final String? cancelButtonText;
  final VoidCallback okFunction;
  final VoidCallback? cancelFunction;
  final bool? onlyConfirmation;

  CustomDialog({
    Key? key,
    required this.description,
    required this.confirmButtonText,
    required this.okFunction,
    this.cancelFunction,
    this.cancelButtonText,
    this.onlyConfirmation = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
      child: Container(
        padding: EdgeInsets.only(top: 10, left: 0, right: 0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: height_10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(description, textAlign: TextAlign.center, style: TextStyle(fontSize: font_size_18, fontWeight: FontWeight.w500)),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            onlyConfirmation == false
                ? Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: mainColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15)),
                            ),
                            minimumSize: Size.fromHeight(
                              48,
                            ),
                          ),
                          onPressed: okFunction,
                          child: Text(
                            confirmButtonText,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      Expanded(
                          child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: mainGreyColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(bottomRight: Radius.circular(15)),
                          ),
                          minimumSize: Size.fromHeight(48),
                        ),
                        onPressed: cancelFunction,
                        child: Text(
                          cancelButtonText!,
                          style: TextStyle(color: Colors.white),
                        ),
                      )),
                    ],
                  )
                : Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: mainGreyColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15)),
                            ),
                            minimumSize: Size.fromHeight(48),
                          ),
                          onPressed: cancelFunction,
                          child: Text(
                            confirmButtonText,
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
