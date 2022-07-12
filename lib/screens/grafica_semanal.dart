import 'package:flutter/cupertino.dart'; 
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:charts_flutter/src/text_element.dart' as elements;
import 'package:charts_flutter/src/text_style.dart' as styles;


class GraficaSemanal extends StatelessWidget {
  const GraficaSemanal({Key? key}) : super(key: key);

  static String? pointerAmount;
  static String? pointerDay;

  @override
  Widget build(BuildContext context) {
    final data = [
      Expenses(1, 33),
      Expenses(2, 39),
      Expenses(3, 33),
      Expenses(4, 30),
      Expenses(5, 28),
      Expenses(6, 20),
    ];
    List<charts.Series<Expenses,int>> series=[
      charts.Series<Expenses, int>(
        id: 'Lineal',
        domainFn: (v,i) =>v.day,
        measureFn: (v,i) => v.expense,
        data: data
      )
    ];
    return Center(
      child: SizedBox(
        height: 350.0,
        child: charts.LineChart(
          series,
          selectionModels: [
            charts.SelectionModelConfig(
              changedListener: (charts.SelectionModel model){
                if (model.hasAnySelection){
                  pointerAmount= model.selectedSeries[0]
                    .measureFn(model.selectedDatum[0].index)
                    ?.toStringAsFixed(2);
                  pointerDay = model.selectedSeries[0]
                  .domainFn(model.selectedDatum[0].index)
                  ?.toString();
                }
              }
            )
          ],
          behaviors: [
            charts.LinePointHighlighter(
              symbolRenderer: mySymbolRenderer()
            )
          ],
        ),
      ),
    );
  }
}

class mySymbolRenderer extends charts.CircleSymbolRenderer{
  @override
  void paint(
    charts.ChartCanvas canvas, 
    Rectangle<num> bounds, 
    {
      List<int>? dashPattern, 
      charts.Color? fillColor, 
      charts.FillPatternType? fillPattern, 
      charts.Color? strokeColor, 
      double? strokeWidthPx
    }) {
    super.paint(
      canvas, 
      bounds, 
      dashPattern: dashPattern, 
      fillColor: fillColor, 
      fillPattern: fillPattern, 
      strokeColor: strokeColor, 
      strokeWidthPx: strokeWidthPx
    );
    canvas.drawRect(
      Rectangle(
        bounds.left -25,
        bounds.top -30,
        bounds.width +48,
        bounds.height +24
      ),
      fill: charts.ColorUtil.fromDartColor(Colors.grey),
      stroke: charts.ColorUtil.fromDartColor(Colors.green),
      strokeWidthPx: 2
    );
    var myStyle = styles.TextStyle();
    myStyle.fontSize =10;
    myStyle.color = charts.ColorUtil.fromDartColor(Colors.black);
    canvas.drawText(
      elements.TextElement(
        'Dia ${GraficaSemanal.pointerDay} \n ${GraficaSemanal.pointerAmount}'
      ),
      (bounds.left -20).round(),
      (bounds.top -26).round()
    );
  }
}

class Expenses{
  final int day;
  final double expense;
  Expenses(this.day, this.expense) ;

}