import 'package:flutter/material.dart';

class WaterScreen extends StatefulWidget {
  const WaterScreen({super.key});

  @override
  State<WaterScreen> createState() => _WaterScreenState();
}

class _WaterScreenState extends State<WaterScreen> {
  // Demo values - later these can come from ESP32 sensors.
  int beforeRo = 3500;
  int afterRo = 78;
  int temperature = 27;
  int tankLevel = 82;

  @override
  Widget build(BuildContext context) {
    final bool waterSafe = afterRo <= 100;

    return Scaffold(
      backgroundColor: const Color(0xff071E26),
      appBar: AppBar(
        backgroundColor: const Color(0xff071E26),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Water Quality',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Stack(
        children: [
          // Background logo
          Positioned.fill(
            child: IgnorePointer(
              child: Center(
                child: Opacity(
                  opacity: 0.05,
                  child: Image.asset(
                    'assets/logo.png',
                    width: 420,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),

          ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xff006064), Color(0xff0277BD)],
                  ),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: const Column(
                  children: [
                    Icon(Icons.water_drop, color: Colors.cyanAccent, size: 55),
                    SizedBox(height: 10),
                    Text(
                      'Water Quality Monitor',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Real-time purification monitoring',
                      style: TextStyle(color: Colors.white70, fontSize: 13),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Water status
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: waterSafe
                      ? const Color(0xff123A32)
                      : const Color(0xff402B18),
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Row(
                  children: [
                    Icon(
                      waterSafe ? Icons.verified : Icons.warning_amber_rounded,
                      color: waterSafe ? Colors.greenAccent : Colors.amber,
                      size: 42,
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Water Status',
                            style: TextStyle(
                              color: Colors.white54,
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            waterSafe ? 'QUALITY GOOD' : 'CHECK REQUIRED',
                            style: TextStyle(
                              color: waterSafe
                                  ? Colors.greenAccent
                                  : Colors.amber,
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // TDS comparison
              const Text(
                'TDS Analysis',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              Row(
                children: [
                  Expanded(
                    child: _tdsCard(
                      title: 'Before RO',
                      value: '$beforeRo',
                      unit: 'ppm',
                      icon: Icons.waves,
                      color: Colors.orangeAccent,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _tdsCard(
                      title: 'After RO',
                      value: '$afterRo',
                      unit: 'ppm',
                      icon: Icons.water_drop,
                      color: Colors.cyanAccent,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 18),

              // Purification efficiency
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xff163447).withValues(alpha: 0.95),
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.auto_graph, color: Colors.cyanAccent),
                        SizedBox(width: 10),
                        Text(
                          'Purification Efficiency',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 18),

                    LinearProgressIndicator(
                      value: 0.978,
                      minHeight: 10,
                      borderRadius: BorderRadius.circular(10),
                      backgroundColor: Colors.white12,
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        Colors.cyanAccent,
                      ),
                    ),

                    const SizedBox(height: 10),

                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Removal efficiency',
                          style: TextStyle(color: Colors.white54, fontSize: 12),
                        ),
                        Text(
                          '97.8%',
                          style: TextStyle(
                            color: Colors.cyanAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              // Sensors
              const Text(
                'Sensors',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              _sensorCard(
                icon: Icons.thermostat,
                title: 'Water Temperature',
                value: '$temperature°C',
                status: 'Normal',
                color: Colors.orangeAccent,
              ),

              const SizedBox(height: 10),

              _sensorCard(
                icon: Icons.water,
                title: 'Clean Water Tank',
                value: '$tankLevel%',
                status: tankLevel > 20 ? 'Available' : 'Low',
                color: tankLevel > 20 ? Colors.greenAccent : Colors.redAccent,
              ),

              const SizedBox(height: 10),

              _sensorCard(
                icon: Icons.speed,
                title: 'TDS Sensor',
                value: '$afterRo ppm',
                status: waterSafe ? 'Normal' : 'High',
                color: waterSafe ? Colors.greenAccent : Colors.redAccent,
              ),

              const SizedBox(height: 20),

              // Demo note
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.blue.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.blue.withValues(alpha: 0.2)),
                ),
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: Colors.cyanAccent,
                      size: 20,
                    ),
                    SizedBox(width: 9),
                    Expanded(
                      child: Text(
                        'Demo sensor data. Values will be replaced by live ESP32 sensor readings when the hardware is connected.',
                        style: TextStyle(
                          color: Colors.white54,
                          fontSize: 12,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              const Center(
                child: Text(
                  'Eco-Tronics⚡🌍',
                  style: TextStyle(color: Colors.white24, fontSize: 12),
                ),
              ),

              const SizedBox(height: 7),

              const Center(
                child: Text(
                  'Developed by Mohamed Gzr',
                  style: TextStyle(color: Colors.white38, fontSize: 12),
                ),
              ),

              const SizedBox(height: 25),
            ],
          ),
        ],
      ),
    );
  }

  Widget _tdsCard({
    required String title,
    required String value,
    required String unit,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xff163447).withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 30),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(color: Colors.white54, fontSize: 12),
          ),
          const SizedBox(height: 5),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            unit,
            style: const TextStyle(color: Colors.white38, fontSize: 11),
          ),
        ],
      ),
    );
  }

  Widget _sensorCard({
    required IconData icon,
    required String title,
    required String value,
    required String status,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xff163447).withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 30),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(color: Colors.white54, fontSize: 12),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Text(
            status,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
