import 'package:flutter/material.dart';
import 'package:geopins/widgets/addLocationPopup.dart';
import 'package:geopins/widgets/commons.dart';
import 'package:geopins/models/mapItems.dart';
import 'package:geopins/screens/profile.dart';
import 'package:geopins/widgets/mapItemTile.dart';

class Homepage extends StatefulWidget {
  Homepage({super.key});

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final int currentIndex = 0;

  List<MapItem> mapItemList = [
    MapItem(
        name: 'home',
        address:
            'Savera Niwas, Nirmal Mahato Path, Rd No. 1, Chhota Gamharia, Jamshedpur, Jharkhand, PIN: 832108',
        location: 'location',
        favorites: false),
    MapItem(
        name: 'new place',
        address:
            'Savera Niwas, Nirmal Mahato Path, Rd No. 1, Chhota Gamharia, Jamshedpur, Jharkhand, PIN: 832108',
        location: 'location',
        favorites: false),
    MapItem(
        name: 'some random place',
        address:
            'Savera Niwas, Nirmal Mahato Path, Rd No. 1, Chhota Gamharia, Jamshedpur, Jharkhand, PIN: 832108',
        location: 'location',
        favorites: false),
    MapItem(
        name: 'abc 123',
        address:
            'Savera Niwas, Nirmal Mahato Path, Rd No. 1, Chhota Gamharia, Jamshedpur, Jharkhand, PIN: 832108',
        location: 'location',
        favorites: false),
    MapItem(
        name: '01923',
        address:
            'Savera Niwas, Nirmal Mahato Path, Rd No. 1, Chhota Gamharia, Jamshedpur, Jharkhand, PIN: 832108',
        location: 'location',
        favorites: false),
  ];

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
              'assets/pin.png',
              color: Colors.white,
              height: 27.5,
            ),
          ],
        ),
        backgroundColor: Colors.grey,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              for (int i = 0; i < mapItemList.length; i++)
                MapItemTile(mapItem: mapItemList[i]),
              const SizedBox(height: 20),
            ],
          ),
        ),
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
                color: Color(0xFFDBDADA), spreadRadius: 0.5, blurRadius: 4),
          ],
          borderRadius: BorderRadius.circular(20),
        ),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) {
            if (index == 1) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const ProfilePage()),
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
      floatingActionButton: GestureDetector(
        onTap: () {
          print('Add Button');
          addLocationPopUpBuilder(context);
        },
        child: Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            border: Border.all(width: 3, color: Colors.white),
            borderRadius: BorderRadius.circular(100),
            image: const DecorationImage(
              image: AssetImage('assets/appBarBg.png'),
              fit: BoxFit.cover,
            ),
            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(81, 0, 0, 0),
                spreadRadius: 2,
                blurStyle: BlurStyle.normal,
                blurRadius: 10,
                offset: Offset(0, 0),
              ),
            ],
          ),
          child: const Center(
            child: Icon(
              Icons.add_rounded,
              size: 35,
              color: Colors.white,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void addLocationPopUpBuilder(BuildContext context) {
    showDialog(
      barrierColor: const Color(0x92000000),
      context: context,
      builder: (context) {
        return const AddLocationDialog();
      },
    );
  }
}
