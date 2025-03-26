import 'package:ExpensifyX_App/ui/home_screen.dart';
import 'package:ExpensifyX_App/ui/profile_screen.dart';
import 'package:ExpensifyX_App/ui/statistic_screen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  late List<Widget> _screens;

@override
  void initState() {
    super.initState();
     _screens = [
      HomeScreen(),
      StatisticScreen(),
      HomeScreen(),
      ProfileScreen(
        onBack: _onProfileBack,
      ),
    ];
  }


 void _onProfileBack() {
  setState(() {
    _selectedIndex = 0; // HomeScreen pe wapas jao
  });
}
  void _onItemTapped(int index) {
     print("Changing Tab to: $index");
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_selectedIndex != 0) {
          setState(() {
            _selectedIndex = 0;
          });
          return false;
        }
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          body: _screens[_selectedIndex],
          bottomNavigationBar: BottomAppBar(
            shape: CircularNotchedRectangle(),
            notchMargin: 8,
            color: Colors.white,
            elevation: 5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                    icon: Icon(Icons.home_outlined,
                        color: _selectedIndex == 0
                            ? Color(0xffe78bbc)
                            : Colors.grey),
                    onPressed: () => _onItemTapped(0)),
                IconButton(
                    icon: Icon(Icons.bar_chart,
                        color: _selectedIndex == 1
                            ? Color(0xffe78bbc)
                            : Colors.grey),
                    onPressed: () => _onItemTapped(1)),
                SizedBox(width: 48),
                IconButton(
                    icon: Icon(Icons.notifications_outlined,
                        color: _selectedIndex == 2
                            ? Color(0xffe78bbc)
                            : Colors.grey),
                    onPressed: () => _onItemTapped(2)),
                IconButton(
                    icon: Icon(Icons.person_outline,
                        color: _selectedIndex == 3
                            ? Color(0xffe78bbc)
                            : Colors.grey),
                    onPressed: () => _onItemTapped(3)),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            backgroundColor: Color(0xffe78bbc),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Icon(Icons.add, color: Colors.white),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        ),
      ),
    );
  }
}
