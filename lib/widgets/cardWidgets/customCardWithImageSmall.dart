import 'package:flutter/material.dart';
import 'package:win_kamu/utils/themes.dart';

class CustomCardWithImageSmall extends StatelessWidget {
  final String? title, icon;
  final int? numara;
  final double? cardPadding;
  final double? cardInlinePadding;
  final Widget? navigation;
  final bool? isNavigation;
  final IconData? iconData;
  final Color? iconColor, backgroundColor, textColor, borderColor;

  const CustomCardWithImageSmall(
      {Key? key,
      required this.title,
      this.navigation,
      this.icon,
      this.iconData,
      this.iconColor,
      this.backgroundColor,
      this.textColor,
      this.borderColor,
      this.isNavigation = true,
      this.numara,
      this.cardPadding = 28.0,
      this.cardInlinePadding = 8.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    Widget iconWidget;
    if (icon == null) {
      if (iconData != null) {
        iconWidget = Icon(
          iconData,
          color: iconColor ?? themeData.colorScheme.primary,
          size: 36,
        );
      } else {
        iconWidget = Image.asset(
          APPImages.splashScreen.images,
          color: iconColor ?? themeData.colorScheme.primary,
          width: 70,
          height: 70,
        );
      }
    } else {
      iconWidget = Image.asset(
        icon!,
        color: iconColor ?? themeData.colorScheme.primary,
        width: 36,
        height: 36,
      );
    }

    return InkWell(
      onTap: isNavigation!
          ? () async {
              await Navigator.push(context, MaterialPageRoute(builder: (context) => navigation!));
            }
          : () {},
      child: Padding(
        padding: EdgeInsets.all(cardPadding!),
        child: Container(
            decoration: BoxDecoration(
              color: backgroundColor ?? APPColors.NewNotifi.blue,
              borderRadius: const BorderRadius.all(Radius.circular(6.0)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              children: [
                Align(
                  alignment: const FractionalOffset(0.0, 0.0),
                  child: Container(
                    decoration: BoxDecoration(color: APPColors.Login.blue, borderRadius: BorderRadius.circular(6)),
                    width: 20,
                    height: 20,
                    child: Center(
                        child: Text(
                      numara.toString(),
                      style: const TextStyle(color: Colors.white),
                    )),
                  ),
                ),
                Center(
                    child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Text(title!, textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w600, color: textColor)),
                )),
              ],
            )),
      ),
    );
  }
}
