
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomOverlayLoader {

  OverlayEntry _overlay;

  CustomOverlayLoader();

  void show(BuildContext context) {
    if(_overlay == null){
      _overlay = OverlayEntry(
          builder: (context) => Container(
            color: Colors.black54.withOpacity(0.7),
            child: Center(
              child: Container(
                height: Get.height * 0.15,
                width:  Get.height * 0.15,
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.5),
                    borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                child: Center(
                  child: CircularProgressIndicator(

                  ),
                ),
              ),
            ),
          )
      );
      Overlay.of(context).insert(_overlay);
    }
  }

  void hide() {
    if (_overlay != null) {
      _overlay.remove();
      _overlay = null;
    }
  }

}