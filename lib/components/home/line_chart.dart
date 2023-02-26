import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CustomLineChart extends StatefulWidget {
  const CustomLineChart({Key? key}) : super(key: key);

  @override
  State<CustomLineChart> createState() => _CustomLineChartState();
}

class _CustomLineChartState extends State<CustomLineChart> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 200,
      child: Card(
        // color: Colors.brown,
        child: LineChart(
          LineChartData(   
            // backgroundColor: Colors.deepPurple,         
            minX: 0,
            maxX: 13,
            minY: 0,
            maxY: 20,
            titlesData: FlTitlesData(show: true,topTitles: AxisTitles(axisNameWidget: const Text("Travel Data",style: TextStyle(color: Colors.white),),)),
            borderData: FlBorderData(show: false),
            gridData: FlGridData(show: true,drawVerticalLine: true, 
            
            ),
            // lineTouchData: LineTouchData(enabled: false),
            
            lineBarsData: [
              LineChartBarData(
                isCurved: true,
                color: Colors.green,
                barWidth: 5,
                spots: [
                const FlSpot(0, 3),
                const FlSpot(2, 5),
                const FlSpot(4, 8),
                const FlSpot(6, 11),
                const FlSpot(8, 5),
                const FlSpot(12, 14),
              ]),

               LineChartBarData(
                isCurved: true,
                color: Colors.deepOrange,
                barWidth: 5,
                spots: [
                const FlSpot(1, 3),
                const FlSpot(2, 8),
                const FlSpot(4, 6),
                const FlSpot(6, 4),
                const FlSpot(8,8),
                const FlSpot(12, 10),
              ])
            ]
        
        )),
      ),
    );
    
  }
}