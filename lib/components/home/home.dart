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
  bool _sortAscending = false;
  int _sortColumnIndex = 0;


  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
       const Wrap(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
          children:  <Widget>[
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

           const Column(children:  <Widget> [
               CustomLineChart(),
               CustomPieChart() 
            ],),

            Container(
              margin:const EdgeInsets.all(10),
              child: Card(
                child: DataTable(
                  sortAscending: _sortAscending,
                  sortColumnIndex: _sortColumnIndex,
                  columns:  <DataColumn>  [
                    DataColumn(label:const Text("Customer",), onSort: (columnIndex, ascending) => setState(() {
                      _sortAscending=ascending;
                      _sortColumnIndex=columnIndex;
                    }),),
                    const DataColumn(label: Text("City")),
                    const DataColumn(label: Text("Priority")),
                    DataColumn(label: const Text("Total Purchase(USD)"),onSort: (columnIndex, ascending) => setState(() {
                      _sortAscending=ascending;
                      _sortColumnIndex=columnIndex;
                    }),),
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
                    ]),
                     DataRow(cells: [
                      const DataCell(Text("Susan Rice")),
                      const DataCell(Text("Delhi")),
                      DataCell(ElevatedButton( onPressed: (){},child: const Text("Medium"),)),
                      const DataCell(Text("120k"))
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