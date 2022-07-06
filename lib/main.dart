import 'package:flutter/material.dart';
import 'package:lista_app/screens/grafica_screen.dart';
//import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:lista_app/screens/lista_screens.dart';
import 'package:lista_app/services/push_notifications_services.dart';
import 'package:lista_app/screens/historial_screens.dart';

/* const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
    playSound: true);

final FlutterLocalNotificationsPlugin miNoti =
    FlutterLocalNotificationsPlugin(); */

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PushNotificationService.initializeApp();
/*   await miNoti
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  PushNotificationService.messaging
      .setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  ); */
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  final GlobalKey<ScaffoldMessengerState> scafolKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    //context!
    PushNotificationService.messageString.listen((message) {
      //debugPrint('Myapp ===> $message');
      navigatorKey.currentState?.pushNamed('home', arguments: message);
      final snackBar = SnackBar(content: Text(message), backgroundColor: Colors.blue.shade300);
      scafolKey.currentState?.showSnackBar(snackBar);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "home",
      navigatorKey: navigatorKey, //navegar
      scaffoldMessengerKey: scafolKey, //snak
      routes: {"home": (_) => ListaScreen(),
      "historial": (_) => HistorialScreen()},
    );
  }
}
