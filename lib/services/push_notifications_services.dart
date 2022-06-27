import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:lista_app/models/mysql1_model.dart';

class PushNotificationService {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? token;
  static String? sql;
  static String? sqlInsert;

  static final StreamController<String> _messageString =
      StreamController.broadcast();
  static Stream<String> get messageString => _messageString.stream;
  static var dbMysql = BDMysql();

  static Future _onBrackgroundHandler(RemoteMessage message) async {
    //debugPrint('onBackground Handler ${message.messageId}');
    debugPrint(message.notification!.body.toString());
    _messageString.add(message.notification!.body.toString());
  }

  static Future _onMessageHandler(RemoteMessage message) async {
    // en la app
    //debugPrint('onMessage Handler ${message.messageId}');
    debugPrint(message.notification!.body.toString());
    _messageString.add(message.notification!.body.toString());
  }

  static Future _onMessageOpenApp(RemoteMessage message) async {
    //debugPrint('onMessageOpenApp Handler ${message.messageId}');
    debugPrint(message.notification!.body.toString());
    _messageString.add(message.notification!.body.toString());
  }

  static Future initializeApp() async {
    // PUSH NOTIFICATIONES
    await Firebase.initializeApp();
    token = await FirebaseMessaging.instance.getToken();
    // Guardar token de todos los dispositivos!!!!
    debugPrint('TOKEN FIREBASE -------> $token');
    dbMysql.getConnection().then((conn) {
      sql = 'select id from tokendisp where id = ?';
      conn.query(sql!, [token]).then((value) {
        if (value.isEmpty) {
          sqlInsert = 'insert into tokendisp(id) values(?)';
          conn.query(sqlInsert!, [token]).then((value) {
            debugPrint(value.toString());
          });
        }
      });
    });
    // HANDLER
    FirebaseMessaging.onBackgroundMessage(_onBrackgroundHandler);
    FirebaseMessaging.onMessage.listen(_onMessageHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenApp);
    //LOCAL NOTIFICACIONES
  }

  static closeContorller() => _messageString.close();
}
