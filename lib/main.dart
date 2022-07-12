import 'package:flutter/material.dart';
import 'package:lista_app/screens/graph_screen.dart';
import 'package:lista_app/screens/lista_screens.dart';
import 'package:lista_app/services/push_notifications_services.dart';
import 'package:lista_app/screens/historial_screens.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PushNotificationService.initializeApp();

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
      routes: {
        "home": (_) => const ListaScreen(),
        "graphScreen": (_) => const GraphScreen()
      }
    );
  }
}
