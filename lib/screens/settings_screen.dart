import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool automaticControl = true;
  bool notifications = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.cyan,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // ESP32
          Card(
            color: const Color(0xff163447),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: const ListTile(
              leading: Icon(
                Icons.developer_board,
                color: Colors.cyan,
                size: 35,
              ),
              title: Text(
                'ESP32 Connection',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                'Ready to connect',
                style: TextStyle(color: Colors.white70),
              ),
              trailing: Icon(Icons.circle, color: Colors.orange, size: 14),
            ),
          ),

          const SizedBox(height: 15),

          // WIFI
          Card(
            color: const Color(0xff163447),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: const ListTile(
              leading: Icon(Icons.wifi, color: Colors.greenAccent, size: 32),
              title: Text(
                'Wi-Fi',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                'Connection settings',
                style: TextStyle(color: Colors.white70),
              ),
              trailing: Icon(Icons.chevron_right, color: Colors.white54),
            ),
          ),

          const SizedBox(height: 15),

          // AUTOMATIC CONTROL
          Card(
            color: const Color(0xff123A32),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: SwitchListTile(
              value: automaticControl,
              onChanged: (value) {
                setState(() {
                  automaticControl = value;
                });
              },
              activeThumbColor: Colors.greenAccent,
              title: const Text(
                'Automatic Control',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: const Text(
                'Allow AI to control the system',
                style: TextStyle(color: Colors.white70),
              ),
              secondary: const Icon(Icons.auto_mode, color: Colors.greenAccent),
            ),
          ),

          const SizedBox(height: 15),

          // NOTIFICATIONS
          Card(
            color: const Color(0xff163447),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: SwitchListTile(
              value: notifications,
              onChanged: (value) {
                setState(() {
                  notifications = value;
                });
              },
              activeThumbColor: Colors.cyan,
              title: const Text(
                'Notifications',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: const Text(
                'Receive system alerts',
                style: TextStyle(color: Colors.white70),
              ),
              secondary: const Icon(Icons.notifications, color: Colors.cyan),
            ),
          ),

          const SizedBox(height: 25),

          // ABOUT
          Card(
            color: const Color(0xff251B3A),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Icon(Icons.water_drop, color: Colors.cyan, size: 55),

                  SizedBox(height: 12),

                  Text(
                    'SMART AI WATER',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 8),

                  Text(
                    'Smart Self-Healing Water Purification Station',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white70),
                  ),

                  SizedBox(height: 18),

                  Text(
                    'Developed by Mohamed Gzr',
                    style: TextStyle(color: Colors.white54, fontSize: 13),
                  ),

                  SizedBox(height: 6),

                  Text(
                    'Version 1.0.0',
                    style: TextStyle(color: Colors.white38, fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
