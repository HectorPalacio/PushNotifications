import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationProvider {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  final _mensajesStreamController = StreamController<String>.broadcast();
  Stream<String> get mensajes => _mensajesStreamController.stream;

  initNotifications() {
    _firebaseMessaging.requestNotificationPermissions();

    _firebaseMessaging.getToken().then((token) {
      print('============ FCM TOKEN============');
      print(token);

      // d2sDVcdySca_klgNkr19Vy:APA91bFOy8uwWLSfJfsqngsqn7TFxWi2zzb66cJCJeumSUsx7ts2CrTDL34P3Lpg-CKbnm4nc6gAEm14OVA2XBCn6gxZY9Dphm9x2kPtKRSXXx6WhPCQ8Pt-M-r1cAOqX7DSSLc7451F
    });

    _firebaseMessaging.configure(
      onMessage: (message) async {
        print('============On Message ==============');
        print(message);

        String argumento = 'no-data';
        if (Platform.isAndroid) {
          argumento = message['data']['comida'] ?? 'no-data';
        }

        _mensajesStreamController.sink.add(argumento);
      },
      onLaunch: (message) async {
        print('============On Launch ==============');
        print(message);
      },
      onResume: (message) async {
        print('============On Resume ==============');
        print(message);

        final noti = message['data']['comida'];
        _mensajesStreamController.sink.add(noti);
      },
    );
  }

  dispose() {
    _mensajesStreamController?.close();
  }
}
