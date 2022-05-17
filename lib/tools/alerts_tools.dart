import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomAlerts {
  static void showAlert(BuildContext context, String title, String content) {
    if (Platform.isAndroid) {
      _displayDialogAndroid(context, title, content);
    }
    if (Platform.isIOS) {
      _displayDialogIos(context, title, content);
    }
  }

  static void _displayDialogIos(
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
                // TextButton(
                //     onPressed: () {
                //       Navigator.pop(context);
                //     },
                //     child: const Text('Cancelar',
                //         style: TextStyle(color: Colors.red))),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('ok')),
              ],
            ));
  }

  static void _displayDialogAndroid(
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
}
