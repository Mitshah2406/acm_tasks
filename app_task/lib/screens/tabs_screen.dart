import 'package:app_task/screens/home_screen.dart';
import 'package:app_task/screens/profile_screen.dart';
import 'package:flutter/material.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int currentIndex = 0;

  List<Widget> tabs = [const HomeScreen(), const ProfileScreen()];
  @override
  Widget build(BuildContext context) {
    void onNavigationTap(int index) {
      setState(() {
        currentIndex = index;
      });
      print(currentIndex);
    }

    return Scaffold(
      drawer: const Drawer(
        elevation: 4,
        child: Text("Hello"),
      ),
      appBar: AppBar(
        title: const Text("Movie"),
        elevation: 4,
      ),
      body: tabs[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          elevation: 14,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          backgroundColor: const Color(0xffA9FDAC),
          currentIndex: currentIndex,
          onTap: onNavigationTap,
          selectedItemColor: Colors.black54,
          unselectedItemColor: Colors.black12,
          type: BottomNavigationBarType.shifting,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.apps_outlined), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle_outlined), label: "Profile"),
          ]),
    );
  }
}
