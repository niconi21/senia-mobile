import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomAlerts {
  static void showSimpleAlert(
      BuildContext context, String title, String content) {
    if (Platform.isAndroid) {
      _displaySimpleDialogAndroid(context, title, content);
    }
    if (Platform.isIOS) {
      _displaySimpleDialogIos(context, title, content);
    }
  }

  static void _displaySimpleDialogIos(
      BuildContext context, String title, String content) {
    showCupertinoDialog(
        barrierDismissible: false,
        context: context,
        builder: (builder) => CupertinoAlertDialog(
              title: Text(title),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(content),
                  SizedBox(
                    height: 10,
                  ),
                  Image(image: AssetImage('assets/logo.png'), width: 100)
                ],
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('ok')),
              ],
            ));
  }

  static void _displaySimpleDialogAndroid(
      BuildContext context, String title, String content) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(title),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(content),
                  SizedBox(
                    height: 10,
                  ),
                  Image(image: AssetImage('assets/logo.png'), width: 100)
                ],
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'ok',
                    )),
              ],
            ));
  }

  static void showOptoinAlert(
      BuildContext context, String title, String content, String textButton,void Function()? onPressed) {
    if (Platform.isAndroid) {
      _displayOptionDialogAndroid(context, title, content, textButton, onPressed);
    }
    if (Platform.isIOS) {
      _displayOptionDialogIos(context, title, content, textButton, onPressed);
    }
  }


  static void _displayOptionDialogAndroid(BuildContext context, String title,
      String content, String textButton, void Function()? onPressed) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(title),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(content),
                  SizedBox(
                    height: 10,
                  ),
                  Image(image: AssetImage('assets/logo.png'), width: 100)
                ],
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancelar',
                        style: TextStyle(color: Colors.red))),
                TextButton(onPressed: onPressed, child: Text(textButton)),
              ],
            ));
  }

  static void _displayOptionDialogIos(BuildContext context, String title,
      String content, String textButton, void Function()? onPressed) {
    showCupertinoDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => CupertinoAlertDialog(
              title: Text(title),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(content),
                  SizedBox(
                    height: 10,
                  ),
                  Image(image: AssetImage('assets/logo.png'), width: 100)
                ],
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancelar',
                        style: TextStyle(color: Colors.red))),
                TextButton(onPressed: onPressed, child: Text(textButton)),
              ],
            ));
  }
}
