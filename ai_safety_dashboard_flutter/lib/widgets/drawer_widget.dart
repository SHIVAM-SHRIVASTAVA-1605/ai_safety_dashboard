import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.blue[50], // Soft background
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            color: Colors.blueAccent, // Full width color
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 35,
                  backgroundImage: AssetImage('assets/images/profile.jpg'), // Dummy image
                ),
                SizedBox(height: 12),
                Text(
                  'Welcome User!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'user@example.com',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildDrawerItem(
                  context,
                  icon: Icons.home,
                  text: 'Home',
                  routeName: '/home',
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.report,
                  text: 'My Reports',
                  routeName: '/reports',
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.help_outline,
                  text: 'Help',
                  routeName: '/help', // ➡️ New Help Page
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.settings,
                  text: 'Settings',
                  routeName: '/settings',
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.info,
                  text: 'About',
                  routeName: '/about',
                ),
              ],
            ),
          ),
          Divider(thickness: 1),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () {
                  Navigator.pop(context); // Close drawer first

                  // Show Snackbar on logout
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('You successfully logged out!'),
                      backgroundColor: Colors.green,
                      duration: Duration(seconds: 2),
                    ),
                  );

                  // Navigate to login screen
                  Navigator.pushReplacementNamed(context, '/login');
                },
                icon: Icon(Icons.logout),
                label: Text('Logout'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(BuildContext context,
      {required IconData icon,
      required String text,
      required String routeName}) {
    return ListTile(
      leading: Icon(icon, color: Colors.blueAccent),
      title: Text(text),
      onTap: () {
        Navigator.pop(context); // Close drawer
        Navigator.pushNamed(context, routeName);
      },
    );
  }
}
