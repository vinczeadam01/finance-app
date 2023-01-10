import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
      return Scaffold(
        body: SafeArea(
          child: Container(
            color: Theme.of(context).primaryColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(onPressed: () {Navigator.pop(context);}, icon: const Icon(Icons.arrow_back)),
                
                SizedBox(
                  height: 40,
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30), color: Colors.white),
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Text("Name:"),
                          TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Name',
                            ),
                            onChanged: (text) async {
                              stderr.write('changed textfield');
                              final prefs = await SharedPreferences.getInstance();
                              await prefs.setString('name', text);
                            },
                          ),
                        ]),
                    ),
                  ),
                )
              ],),
          )),
      );
  }
}