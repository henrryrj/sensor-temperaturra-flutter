import 'package:lista_app/models/dispositivo_model.dart';
import 'monitor_model.dart';

class ChartData {
  ChartData(this.disp, this.lista);
  final Dispositivo disp;
  final List<Monitor> lista;
}
