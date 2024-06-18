import 'package:flutter/material.dart';
import 'package:geopins/widgets/commons.dart';
import 'package:geopins/screens/homepage.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  final int currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/appBarBg.avif'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        toolbarHeight: 75,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyText(
              'GeoPins',
              size: 25,
              weight: FontWeight.bold,
              color: Colors.white,
              spacing: 3,
            ),
            const SizedBox(width: 7.5),
            Image.asset(
              'assets/mapPin.png',
              color: Colors.white,
              height: 27.5,
            ),
          ],
        ),
        backgroundColor: Colors.grey,
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
        decoration: BoxDecoration(
          color: Colors.transparent,
          image: const DecorationImage(
            image: AssetImage('assets/appBarBg.png'),
            fit: BoxFit.cover,
          ),
          boxShadow: const [
            BoxShadow(
                color: Color(0xFFB1B1B1), spreadRadius: 0.5, blurRadius: 4),
            BoxShadow(
                color: Color(0xFFDBDADA), spreadRadius: 0.5, blurRadius: 4)
          ],
          borderRadius: BorderRadius.circular(20),
        ),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) {
            if (index == 0) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => Homepage()),
                (route) => false,
              );
            } else {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => Homepage(),
                ),
              );
            }
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          unselectedIconTheme: const IconThemeData(
            size: 25,
            color: Colors.white,
          ),
          selectedIconTheme: const IconThemeData(
            size: 30,
            color: Colors.white,
          ),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_rounded),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
