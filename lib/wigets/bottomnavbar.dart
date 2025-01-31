import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/bottomnav_provider.dart';

class BottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var navProvider = Provider.of<BottomNavProvider>(context);

    return BottomNavigationBar(backgroundColor: Colors.white,
      currentIndex: navProvider.currentIndex,
      onTap: (index) => navProvider.changeIndex(index),
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: true,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_filled), // Changed icon
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.event_note), // Changed icon
          label: 'Booking',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.message_rounded), // Changed icon
          label: 'Chat',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_border), // Changed icon
          label: 'Favorite',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle), // Changed icon
          label: 'Profile',
        ),
      ],
    );
  }
}
