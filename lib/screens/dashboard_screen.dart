import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  Widget dataCard({
    required String title,
    required String value,
    required String unit,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xff163447),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 30),

          const SizedBox(height: 15),

          Text(
            title,
            style: const TextStyle(color: Colors.white70, fontSize: 14),
          ),

          const SizedBox(height: 6),

          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                value,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(width: 5),

              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text(
                  unit,
                  style: const TextStyle(color: Colors.white54, fontSize: 13),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget statusRow({
    required String title,
    required String value,
    required Color color,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Icon(Icons.circle, size: 10, color: color),

          const SizedBox(width: 12),

          Expanded(
            child: Text(title, style: const TextStyle(color: Colors.white70)),
          ),

          Text(
            value,
            style: TextStyle(color: color, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "System Dashboard",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // HEADER
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xff4527A0), Color(0xff6A1B9A)],
              ),
              borderRadius: BorderRadius.circular(22),
            ),
            child: const Column(
              children: [
                Icon(Icons.dashboard, color: Colors.white, size: 55),

                SizedBox(height: 10),

                Text(
                  "SMART AI WATER",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 5),

                Text(
                  "Live System Monitoring",
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),

          const SizedBox(height: 22),

          // DATA GRID
          GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            childAspectRatio: 1.15,
            children: [
              dataCard(
                title: "Water Quality",
                value: "78",
                unit: "ppm",
                icon: Icons.water_drop,
                color: Colors.cyan,
              ),

              dataCard(
                title: "Water Produced",
                value: "560",
                unit: "L",
                icon: Icons.opacity,
                color: Colors.blue,
              ),

              dataCard(
                title: "Battery",
                value: "92",
                unit: "%",
                icon: Icons.battery_full,
                color: Colors.green,
              ),

              dataCard(
                title: "Solar Power",
                value: "420",
                unit: "W",
                icon: Icons.solar_power,
                color: Colors.orange,
              ),

              dataCard(
                title: "Pressure",
                value: "Stable",
                unit: "",
                icon: Icons.speed,
                color: Colors.amber,
              ),

              dataCard(
                title: "Pump",
                value: "ON",
                unit: "",
                icon: Icons.water_drop,
                color: Colors.greenAccent,
              ),
            ],
          ),

          const SizedBox(height: 20),

          // SYSTEM STATUS
          Card(
            color: const Color(0xff163447),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "System Status",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 15),

                  statusRow(
                    title: "Water Quality Sensor",
                    value: "ONLINE",
                    color: Colors.greenAccent,
                  ),

                  statusRow(
                    title: "TDS Sensor",
                    value: "ONLINE",
                    color: Colors.greenAccent,
                  ),

                  statusRow(
                    title: "Flow Sensor",
                    value: "ONLINE",
                    color: Colors.greenAccent,
                  ),

                  statusRow(
                    title: "Pressure Sensor",
                    value: "ONLINE",
                    color: Colors.greenAccent,
                  ),

                  statusRow(
                    title: "Tank Level Sensors",
                    value: "ONLINE",
                    color: Colors.greenAccent,
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          // AI STATUS
          Card(
            color: const Color(0xff251B3A),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(
                        Icons.psychology,
                        color: Colors.deepPurpleAccent,
                        size: 32,
                      ),

                      SizedBox(width: 10),

                      Text(
                        "AI Prediction",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 15),

                  const Text(
                    "System health: GOOD",
                    style: TextStyle(
                      color: Colors.greenAccent,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    "Filter replacement expected after 2 days.",
                    style: TextStyle(color: Colors.white70),
                  ),

                  const SizedBox(height: 15),

                  LinearProgressIndicator(
                    value: 0.85,
                    minHeight: 10,
                    borderRadius: BorderRadius.circular(10),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    "Filter health: 85%",
                    style: TextStyle(color: Colors.white54),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          // SELF HEALING
          Card(
            color: const Color(0xff123A32),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.healing, color: Colors.greenAccent, size: 32),

                      SizedBox(width: 10),

                      Text(
                        "Self-Healing",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 15),

                  Text(
                    "✓ Automatic fault detection",
                    style: TextStyle(color: Colors.white70),
                  ),

                  SizedBox(height: 8),

                  Text(
                    "✓ Automatic pump protection",
                    style: TextStyle(color: Colors.white70),
                  ),

                  SizedBox(height: 8),

                  Text(
                    "✓ Backup filter management",
                    style: TextStyle(color: Colors.white70),
                  ),

                  SizedBox(height: 8),

                  Text(
                    "✓ Smart maintenance alerts",
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 25),

          const Center(
            child: Text(
              "SMART AI WATER • Developed by Mohamed Gzr",
              style: TextStyle(color: Colors.white38, fontSize: 12),
            ),
          ),

          const SizedBox(height: 15),
        ],
      ),
    );
  }
}
