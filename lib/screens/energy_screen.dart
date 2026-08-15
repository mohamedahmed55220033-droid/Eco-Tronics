import 'package:flutter/material.dart';

class EnergyScreen extends StatefulWidget {
  const EnergyScreen({super.key});

  @override
  State<EnergyScreen> createState() => _EnergyScreenState();
}

class _EnergyScreenState extends State<EnergyScreen> {
  int battery = 92;
  int solarPower = 420;
  int loadPower = 180;
  int batteryVoltage = 24;

  bool inverterOn = true;
  bool solarCharging = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff071E26),
      appBar: AppBar(
        backgroundColor: const Color(0xff071E26),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Energy System',
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
              // HEADER
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
                    Icon(Icons.wb_sunny, color: Colors.amber, size: 55),
                    SizedBox(height: 10),
                    Text(
                      'Smart Energy Management',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Solar power and battery monitoring',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white70, fontSize: 13),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // BATTERY MAIN CARD
              Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: const Color(0xff163447).withValues(alpha: 0.95),
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Column(
                  children: [
                    const Row(
                      children: [
                        Icon(
                          Icons.battery_full,
                          color: Colors.greenAccent,
                          size: 30,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Battery',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    Text(
                      '$battery%',
                      style: const TextStyle(
                        color: Colors.greenAccent,
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 12),

                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: battery / 100,
                        minHeight: 12,
                        backgroundColor: Colors.white12,
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          Colors.greenAccent,
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    Text(
                      '$batteryVoltage V',
                      style: const TextStyle(
                        color: Colors.white54,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              // SOLAR + LOAD
              Row(
                children: [
                  Expanded(
                    child: _energyCard(
                      title: 'Solar Power',
                      value: '$solarPower',
                      unit: 'W',
                      icon: Icons.wb_sunny,
                      color: Colors.amber,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _energyCard(
                      title: 'System Load',
                      value: '$loadPower',
                      unit: 'W',
                      icon: Icons.bolt,
                      color: Colors.orangeAccent,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // ENERGY FLOW
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
                        Icon(Icons.account_tree, color: Colors.cyanAccent),
                        SizedBox(width: 10),
                        Text(
                          'Energy Flow',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    _flowRow(
                      icon: Icons.wb_sunny,
                      title: 'Solar Panels',
                      value: '$solarPower W',
                      color: Colors.amber,
                    ),

                    _arrow(),

                    _flowRow(
                      icon: Icons.battery_charging_full,
                      title: 'Battery',
                      value: '$battery%',
                      color: Colors.greenAccent,
                    ),

                    _arrow(),

                    _flowRow(
                      icon: Icons.power,
                      title: 'System Load',
                      value: '$loadPower W',
                      color: Colors.orangeAccent,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              // INVERTER
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: const Color(0xff163447).withValues(alpha: 0.95),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: inverterOn
                            ? Colors.green.withValues(alpha: 0.15)
                            : Colors.red.withValues(alpha: 0.15),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.electrical_services,
                        color: inverterOn
                            ? Colors.greenAccent
                            : Colors.redAccent,
                      ),
                    ),

                    const SizedBox(width: 12),

                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Inverter',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Power conversion system',
                            style: TextStyle(
                              color: Colors.white54,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Switch(
                      value: inverterOn,
                      onChanged: (value) {
                        setState(() {
                          inverterOn = value;
                        });
                      },
                      activeThumbColor: Colors.greenAccent,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // SOLAR CHARGING
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: const Color(0xff163447).withValues(alpha: 0.95),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.amber.withValues(alpha: 0.12),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.battery_charging_full,
                        color: Colors.amber,
                      ),
                    ),

                    const SizedBox(width: 12),

                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Solar Charging',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Charge battery from solar panels',
                            style: TextStyle(
                              color: Colors.white54,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Switch(
                      value: solarCharging,
                      onChanged: (value) {
                        setState(() {
                          solarCharging = value;
                        });
                      },
                      activeThumbColor: Colors.amber,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // SYSTEM EFFICIENCY
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
                        Icon(Icons.speed, color: Colors.cyanAccent),
                        SizedBox(width: 10),
                        Text(
                          'Energy Efficiency',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 18),

                    const LinearProgressIndicator(
                      value: 0.86,
                      minHeight: 10,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      backgroundColor: Colors.white12,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.cyanAccent,
                      ),
                    ),

                    const SizedBox(height: 10),

                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Current efficiency',
                          style: TextStyle(color: Colors.white54, fontSize: 12),
                        ),
                        Text(
                          '86%',
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

              const SizedBox(height: 20),

              // DEMO INFO
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
                        'Demo energy data. Solar, battery and power readings will be connected to the real hardware through ESP32.',
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

  Widget _energyCard({
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
              fontSize: 25,
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

  Widget _flowRow({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.12),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 15),
          ),
        ),
        Text(
          value,
          style: TextStyle(color: color, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _arrow() {
    return const Padding(
      padding: EdgeInsets.only(left: 21, top: 6, bottom: 6),
      child: Icon(Icons.arrow_downward, color: Colors.white24, size: 20),
    );
  }
}
