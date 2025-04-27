import 'package:flutter/material.dart';

class BottomNavbar extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onTap;

  BottomNavbar({required this.selectedIndex, required this.onTap});

  @override
  _BottomNavbarState createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: widget.selectedIndex,
      onTap: widget.onTap,
      backgroundColor: Colors.blueAccent, // Background Color
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.white,  // Selected item color
      unselectedItemColor: Colors.grey[600],  // Unselected item color
      showUnselectedLabels: true,
      selectedFontSize: 14,
      unselectedFontSize: 12,
      elevation: 8,  // Shadow effect
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Explore',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_circle_outline),
          label: 'Add',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications),
          label: 'Notifications',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          label: 'Profile',
        ),
      ],
    );
  }
}
