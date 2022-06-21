import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';

class PushNotificationService {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? token;
  static final StreamController<String> _messageString =
      StreamController.broadcast();
  static Stream<String> get messageString => _messageString.stream;

  static Future _onBrackgroundHandler(RemoteMessage message) async {
    //debugPrint('onBackground Handler ${message.messageId}');
    debugPrint(message.data.toString());
    _messageString.add(message.data.toString());
  }

  static Future _onMessageHandler(RemoteMessage message) async {
    //debugPrint('onMessage Handler ${message.messageId}');
    debugPrint(message.data.toString());
    _messageString.add(message.data.toString());


  }

  static Future _onMessageOpenApp(RemoteMessage message) async {
    //debugPrint('onMessageOpenApp Handler ${message.messageId}');
    debugPrint(message.data.toString());
    _messageString.add(message.data.toString());
  }

  static Future initializeApp() async {
    // PUSH NOTIFICATIONES
    await Firebase.initializeApp();
    token = await FirebaseMessaging.instance.getToken();
    debugPrint('TOKEN FIREBASE -------> $token');
    // HANDLER
    FirebaseMessaging.onBackgroundMessage(_onBrackgroundHandler);
    FirebaseMessaging.onMessage.listen(_onMessageHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenApp);
    //LOCAL NOTIFICACIONES
  }

  static closeContorller() => _messageString.close();
}
