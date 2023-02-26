import 'package:flutter/material.dart';

Widget profileImage=ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.network("https://sp-images.summitpost.org/947006.jpg?auto=format&fit=max&ixlib=php-2.1.1&q=35&w=1024&s=d877834568578388ef13b78e3cd7ba2b", 
              fit: BoxFit.cover,)
            );


Widget customButton()=>Padding(
          padding: const EdgeInsets.all(8.0),
          child: OutlinedButton(
            onPressed: (){},
            style:  ButtonStyle(
              // padding: const MaterialStatePropertyAll<EdgeInsets>(EdgeInsets.all(15)),
              shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
              )
            ),
            child:const Text("see more")),
        );