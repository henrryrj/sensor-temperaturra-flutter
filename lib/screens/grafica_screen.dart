import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lista_app/screens/historial_screens.dart';

class GraficaScreen extends StatelessWidget { 
  String dropdownvalue = 'Diario';  
  
  var items = [   
    'Diario',
    'Semanal',
    'Mensual', 
  ];
   GraficaScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) { 
    return Scaffold( 
        body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButton(
              value: dropdownvalue,
              icon: const Icon(Icons.arrow_drop_down_circle_outlined ), 
              dropdownColor: Colors.brown.shade100,  
              items: items.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  dropdownvalue = newValue!;
                });
              },
            ),
          ],
        ),
      ),
      
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
          context,
          MaterialPageRoute(builder: 
            (context) => HistorialScreen()
          ),
          );
        },
        label: const Text('Historial'),
        icon: const Icon(Icons.article_sharp),
        backgroundColor: Colors.blueGrey,
      ),
    );
  }
  
  void setState(Null Function() param0) {}
}
