import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class CustomPieChart extends StatelessWidget {
  const CustomPieChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Card(
      child: SizedBox(
        height: 200,width: 400,
        child: PieChart(
          PieChartData(
            centerSpaceRadius: 50,
            sections: [
              PieChartSectionData(
                value: 20,
                color: Colors.blue,
                showTitle: false,
                title: "Sales"
              ),
              PieChartSectionData(
                value: 70,
                color: Colors.amber,
                title: "Profits"
              ),
              PieChartSectionData(
                value: 10,
                color: Colors.red,
                title: "Losses"
              )
            ]
        )),
        ),
    );
    
  }
}