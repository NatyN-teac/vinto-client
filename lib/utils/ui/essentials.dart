import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';

import 'dart:io' show Platform;

import 'package:shimmer/shimmer.dart';

// Date Picker typedef
typedef DatePickerChanged = void Function(DateTime date);
typedef IsEmptyCallback = void Function(bool value);
double lableFontSize() => 12;

LinearGradient leftToRight() => LinearGradient(
    begin: Alignment.centerRight,
    end: Alignment.centerLeft,
    colors: [primaryColor, accentColor, primaryColor]);
LinearGradient rightCornerToLeftCorner() => LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [primaryColor, accentColor, primaryColor]);

OutlineInputBorder textFieldfocused() => OutlineInputBorder(
    borderRadius: BorderRadius.circular(15),
    borderSide: BorderSide(color: Colors.blueGrey, width: 0.3));
OutlineInputBorder errorrTextFieldBorder() => OutlineInputBorder(
    borderRadius: BorderRadius.circular(15),
    borderSide: BorderSide(color: Color(0xffFF5252), width: 0.3));
final Color accentColor = Color(0xff0F61A0);
final Color primaryColor = Color(0xff0079D3);
final Color secondary = Color(0xffFF4500);

final Color grayColor = Colors.blueGrey;
final Color whiteColor = Colors.white;

MaterialColor primarySwatch =
    new MaterialColor(0xff0079D3, swatchColorMaker(primaryColor));

Map<int, Color> swatchColorMaker(Color color) {
  return <int, Color>{
    50: color.withOpacity(0.1),
    100: color.withOpacity(0.2),
    200: color.withOpacity(0.3),
    300: color.withOpacity(0.4),
    400: color.withOpacity(0.5),
    500: color.withOpacity(0.6),
    600: color.withOpacity(0.7),
    700: color.withOpacity(0.8),
    800: color.withOpacity(0.9),
    900: color.withOpacity(1),
  };
}

Widget masker(BuildContext context, Widget widget,
    {LinearGradient gradient, bool accept = false}) {
  return ShaderMask(
      child: widget,
      blendMode: BlendMode.srcATop,
      shaderCallback: (Rect bounds) {
        return accept
            ? gradient.createShader(bounds)
            : leftToRight().createShader(bounds);
      });
}

final BorderRadius buttonRadius = BorderRadius.circular(30);
Color buttonColor(BuildContext context) => accentColor;

Widget emptyList(
    {IconData icon, double iconSize = 100, String msg, double fontSize = 20}) {
  return Container(
    alignment: Alignment.center,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: iconSize,
          color: accentColor.withOpacity(0.5),
        ),
        SizedBox(height: 20),
        Text(
          msg,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: fontSize, color: primaryColor.withOpacity(0.4)),
        )
      ],
    ),
  );
}

void datePicker(
  BuildContext context, {
  @required DatePickerChanged onpicked,
  DateTime initialDate,
  DateTime firstDate,
  DateTime lastDate,
}) async {
  final DateTime _date = await showDatePicker(
    context: context,
    initialDate: initialDate ?? new DateTime.now(),
    firstDate: firstDate ?? new DateTime(1920),
    lastDate: lastDate ?? new DateTime.now(),
    builder: (BuildContext context, Widget child) {
      return Theme(
        data: ThemeData(
          primarySwatch: primarySwatch,
        ),
        child: child,
      );
    },
  );

  onpicked(_date);
}

Widget partners(BuildContext context) {
  return Container(
    child: Transform.scale(
      scale: 0.8,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: new Image.asset(
              'assets/partners/JCC.png',
              height: 110,
              width: 250,
              scale: 2,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              new Image.asset(
                'assets/partners/Minab.png',
                height: 40,
                width: 150,
              ),
              new Image.asset(
                'assets/partners/FSMMIPA.png',
                height: 40,
                width: 150,
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

class PersistentHeaderWrapper extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double maxHeight;
  final double minHeight;

  PersistentHeaderWrapper({this.child, this.maxHeight, this.minHeight});
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return LayoutBuilder(builder: (context, constraints) {
      // final double percentage =
      //     (constraints.maxHeight - minExtent) / (maxExtent - minExtent);

      return child;
    });
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate _) => true;

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;
}

Widget filterDrawerHeader(
    {ImageProvider imageIcon,
    bool isImageIcon: false,
    String title,
    IconData logo,
    Color color,
    double size: 50}) {
  return SafeArea(
    child: Container(
        padding: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: accentColor, width: 0.5))),
        margin: EdgeInsets.all(10),
        child: Row(
          children: [
            Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                  border: Border.all(color: accentColor, width: 0.2),
                  shape: BoxShape.circle),
              child: Center(
                child: isImageIcon
                    ? ImageIcon(
                        imageIcon,
                        size: size,
                        color: color ?? primaryColor,
                      )
                    : Icon(
                        logo,
                        size: size,
                        color: color ?? primaryColor,
                      ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Flexible(
              child: SizedBox(
                child: Text(
                  "$title Filter Options",
                  softWrap: false,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: grayColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
              ),
            )
          ],
        )),
  );
}

Widget shimmerLoader(
    {@required double height, @required double width, bool circle = false}) {
  return Shimmer.fromColors(
    direction: ShimmerDirection.ttb,
    baseColor: Color(0xffeeeeee),
    highlightColor: Color(0xfff5f5f5),
    child: Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          color: Colors.white,
          shape: circle ? BoxShape.circle : BoxShape.rectangle),
    ),
  );
}

Widget networkImageLoader(
        {@required String url,
        @required double height,
        @required double width,
        bool circle = false}) =>
    CachedNetworkImage(
      imageUrl: url,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          shape: circle ? BoxShape.circle : BoxShape.rectangle,
          image: DecorationImage(fit: BoxFit.cover, image: imageProvider),
        ),
        height: height,
        width: width,
      ),
      placeholder: (context, url) =>
          shimmerLoader(height: height - 1, width: width - 1, circle: circle),
      errorWidget: (context, url, error) => Container(
          decoration: BoxDecoration(
              shape: circle ? BoxShape.circle : BoxShape.rectangle),
          height: height - 1,
          width: width - 1,
          child: Icon(Icons.error)),
    );

Widget iconResolver({String code, Color color, double size: 15}) {
  return Icon(
    code != null
        ? IconData(
            int.parse(code, radix: 16),
            fontFamily: 'FontAwesomeSolid',
            fontPackage: 'font_awesome_flutter',
          )
        : Icons.folder,
    size: 15,
    color: color ?? primaryColor,
  );
}

void textFieldListener(
    {TextEditingController controller, IsEmptyCallback onChanged}) {
  if (controller.text.isNotEmpty) {
    onChanged(false);
  } else {
    onChanged(true);
  }
}

bool foriOS() => Platform.isIOS;

void showErrorSnack(
    {String title,
    String message,
    Color background = const Color(0xffFF5252),
    Color textColor = Colors.white}) {
  Get.snackbar(title, message,
      margin: EdgeInsets.only(top: 10, left: 10, right: 10),
      snackPosition: SnackPosition.TOP,
      colorText: textColor,
      forwardAnimationCurve: Curves.bounceIn,
      backgroundColor: background);
}

void showMessageSnack({String title, String message}) {
  Get.snackbar(title, message,
      snackPosition: SnackPosition.BOTTOM,
      colorText: Colors.white,
      forwardAnimationCurve: Curves.bounceIn,
      backgroundColor: grayColor);
}

void showSuccessSnack({String title, String message}) {
  Get.snackbar(title, message,
      snackPosition: SnackPosition.TOP,
      margin: EdgeInsets.only(top: 10, left: 10, right: 10),
      colorText: Colors.white,
      forwardAnimationCurve: Curves.bounceIn,
      backgroundColor: const Color(0xff03A84E));
}

void nextPage(PageController pageController) {
  pageController.nextPage(
      duration: Duration(milliseconds: 200), curve: Curves.ease);
}

void previousPage(PageController pageController) {
  pageController.previousPage(
      duration: Duration(milliseconds: 200), curve: Curves.ease);
}

Widget formFieldHeader({String title, IconData icon}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            color: grayColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        Icon(
          icon,
          color: grayColor,
          size: 16,
        )
      ],
    ),
  );
}

Widget formIconHeader({String msg, IconData icon}) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Center(
        child: Container(
          margin: EdgeInsets.only(left: 0),
          alignment: Alignment.center,
          height: 120,
          width: 120,
          decoration: BoxDecoration(
              gradient: rightCornerToLeftCorner(),
              shape: BoxShape.circle,
              border: Border.all(width: 2, color: Colors.transparent)),
          child: Icon(icon, size: 70, color: Colors.white),
        ),
      ),
      SizedBox(height: 10),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Text(
          msg,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            color: grayColor,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
      SizedBox(height: 10),
    ],
  );
}
