import 'package:flutter/material.dart';
import 'package:flutterdash/components/componets.dart';

class HomeCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final int number;
  final String footer;
  final Color color;
  const HomeCard({Key? key,required this.icon,required this.title,required this.number,required this.footer, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280,
      child: Card(
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
            Row(
              children: [
                Card(
                  color: color,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Icon(icon,color: Colors.white,size: 40,),
                  ),
                ),
                const SizedBox( width: 20,),
                Column(children: [
                  Text(title,style: const TextStyle(color: Colors.grey),),
                  Text(number.toString(),style: const TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                  customButton()
                ],)
              ],
            ),
            const SizedBox(height: 10,),
            const Divider(height: 2,thickness: 2,),
            Text(footer)
          ],),
        )      
      ),
    );
    
  }
}