import 'package:flutter/material.dart';
import 'package:money_management_app/pages/charts.dart';

import 'homepage.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  static const List<Widget> _pages = <Widget>[
    Homepage(),
    ChartsPage(),
  ];
  int _selectedIndex = 0;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(toolbarHeight: 0, shadowColor: Colors.transparent,),
      floatingActionButton:FloatingActionButton(
        onPressed: (){
          Navigator.pushNamed(context, '/add');
        },
        child: Icon(Icons.add),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      
      bottomNavigationBar: BottomAppBar(
        color: Colors.white.withAlpha(255),
        elevation: 1,
        shape: CircularNotchedRectangle(), //shape of notch
        notchMargin: 8.0, //notche margin between floating button and bottom appbar
        child: BottomNavigationBar(
          elevation:0,
          backgroundColor: Colors.white.withAlpha(0),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart),
              label: 'Charts',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          ),
      ),

        body: Center(
          child: _pages.elementAt(_selectedIndex), //New
        ),

    ) ;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

}
