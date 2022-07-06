import 'package:flutter/material.dart';


class HistorialScreen extends StatelessWidget { 
  final List<String> entries = <String>['A', 'B'];
   HistorialScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
        title: const Text('Historial'),
        elevation: 8
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(15),
        itemCount: entries.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 50,
            color: Colors.lightBlue.shade400,
            
            child: Center(
              child: Text('7 ${entries[index]}')
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),
    );
  }

  
}