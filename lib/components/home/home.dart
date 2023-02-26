import 'package:flutter/material.dart';
import 'package:flutterdash/components/home/home_card.dart';
import 'package:flutterdash/components/home/line_chart.dart';
import 'package:flutterdash/components/home/pie_chart.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {



  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Wrap(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
          children: const <Widget>[
            HomeCard(icon:  Icons.sell, title: "Sales Total", number: 394675, footer: "This Are the total sales", color: Colors.amber),
            HomeCard(icon:  Icons.group, title: "Customers total ", number: 7890, footer: "This Are the total customers", color: Colors.blue),
            HomeCard(icon:  Icons.flight, title: "Tavels Total", number: 2229, footer: "This Are the total travels", color: Colors.brown),
            HomeCard(icon:  Icons.percent,title: "Profits Total(USD)", number: 78900, footer: "The monthly total Profits ", color: Colors.indigo),
            HomeCard(icon:  Icons.percent,title: "Profits Losess(USD)", number:900, footer: "The monthly total Losses ", color: Colors.deepPurple),
          ],
        ),
        const SizedBox(height: 30,),
        Wrap(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Column(children: const <Widget> [
               CustomLineChart(),
               CustomPieChart() 
            ],),

            Container(
              margin:const EdgeInsets.all(10),
              child: Card(
                child: DataTable(
                  columns: const <DataColumn>  [
                    DataColumn(label: Text("Customer")),
                    DataColumn(label: Text("City")),
                    DataColumn(label: Text("Priority")),
                    DataColumn(label: Text("Total Purchase(USD)")),
                  ],

                  rows:  <DataRow> [
                    DataRow(cells: [
                      const DataCell(Text("John Doe")),
                      const DataCell(Text("Texas")),
                      DataCell(ElevatedButton( onPressed: (){},child: const Text("High"),)),
                      const DataCell(Text("2000k"))
                    ]),

                     DataRow(cells: [
                      const DataCell(Text("James Henery")),
                      const DataCell(Text("Nairobi")),
                      DataCell(ElevatedButton( onPressed: (){},child: const Text("Medium"),)),
                      const DataCell(Text("130k"))
                    ]),

                     DataRow(cells: [
                      const DataCell(Text("Mary Park")),
                      const DataCell(Text("Nakuru")),
                      DataCell(ElevatedButton( onPressed: (){},child: const Text("Low"),)),
                      const DataCell(Text("20k"))
                    ])

                  ],

              )),
            )

          ],
        ),

      

      ],
    );
  }
}