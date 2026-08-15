import 'dart:async';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool autoMode = true;
  bool pumpRunning = false;

  TimeOfDay? startTime;
  TimeOfDay? stopTime;

  Timer? scheduleTimer;

  int waterQuality = 78;
  int waterProduced = 560;
  int battery = 92;
  int solarPower = 420;

  @override
  void initState() {
    super.initState();

    scheduleTimer = Timer.periodic(
      const Duration(seconds: 10),
      (_) => checkSchedule(),
    );
  }

  @override
  void dispose() {
    scheduleTimer?.cancel();
    super.dispose();
  }

  // =========================
  // CHECK AUTO SCHEDULE
  // =========================

  void checkSchedule() {
    if (!autoMode || startTime == null || stopTime == null) {
      return;
    }

    final now = TimeOfDay.now();

    final nowMinutes = now.hour * 60 + now.minute;
    final startMinutes = startTime!.hour * 60 + startTime!.minute;
    final stopMinutes = stopTime!.hour * 60 + stopTime!.minute;

    bool shouldRun;

    if (startMinutes <= stopMinutes) {
      shouldRun = nowMinutes >= startMinutes && nowMinutes < stopMinutes;
    } else {
      // Schedule crosses midnight.
      shouldRun = nowMinutes >= startMinutes || nowMinutes < stopMinutes;
    }

    if (shouldRun != pumpRunning) {
      setState(() {
        pumpRunning = shouldRun;
      });
    }
  }

  // =========================
  // PICK START TIME
  // =========================

  Future<void> selectStartTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: startTime ?? TimeOfDay.now(),
    );

    if (picked != null) {
      setState(() {
        startTime = picked;
      });

      checkSchedule();
    }
  }

  // =========================
  // PICK STOP TIME
  // =========================

  Future<void> selectStopTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: stopTime ?? TimeOfDay.now(),
    );

    if (picked != null) {
      setState(() {
        stopTime = picked;
      });

      checkSchedule();
    }
  }

  // =========================
  // MANUAL START
  // =========================

  void manualStart() {
    if (autoMode) return;

    setState(() {
      pumpRunning = true;
    });
  }

  // =========================
  // MANUAL STOP
  // =========================

  void manualStop() {
    if (autoMode) return;

    setState(() {
      pumpRunning = false;
    });
  }

  // =========================
  // FORMAT TIME
  // =========================

  String formatTime(TimeOfDay? time) {
    if (time == null) {
      return '--:--';
    }

    return time.format(context);
  }

  // =========================
  // INFO CARD
  // =========================

  Widget infoCard({
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
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 27),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(color: Colors.white70, fontSize: 13),
                ),
                const SizedBox(height: 4),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      value,
                      style: TextStyle(
                        color: color,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      unit,
                      style: const TextStyle(
                        color: Colors.white54,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // =========================
  // BUILD
  // =========================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff071E26),
      body: SafeArea(
        child: Stack(
          children: [
            // =========================
            // BACKGROUND LOGO
            // =========================
            Positioned.fill(
              child: IgnorePointer(
                child: Center(
                  child: Opacity(
                    opacity: 0.06,
                    child: Image.asset(
                      'assets/logo.png',
                      width: 420,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),

            // =========================
            // CONTENT
            // =========================
            ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // =========================
                // HEADER
                // =========================
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xff006064), Color(0xff0277BD)],
                    ),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/logo.png',
                        height: 75,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Eco-Tronics⚡🌍',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 27,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        'Smart Water Purification System',
                        style: TextStyle(color: Colors.white70, fontSize: 13),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 18),

                // =========================
                // SYSTEM STATUS
                // =========================
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: const Color(0xff123A32).withValues(alpha: 0.95),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        pumpRunning ? Icons.check_circle : Icons.pause_circle,
                        color: pumpRunning
                            ? Colors.greenAccent
                            : Colors.orangeAccent,
                        size: 32,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'System Status',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              pumpRunning ? 'SYSTEM RUNNING' : 'SYSTEM STANDBY',
                              style: TextStyle(
                                color: pumpRunning
                                    ? Colors.greenAccent
                                    : Colors.orangeAccent,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.circle,
                        color: pumpRunning
                            ? Colors.greenAccent
                            : Colors.orangeAccent,
                        size: 10,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 18),

                // =========================
                // CONTROL MODE
                // =========================
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: const Color(0xff163447).withValues(alpha: 0.96),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: autoMode
                          ? Colors.cyanAccent.withValues(alpha: 0.35)
                          : Colors.orangeAccent.withValues(alpha: 0.35),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            autoMode ? Icons.auto_mode : Icons.pan_tool_alt,
                            color: autoMode
                                ? Colors.cyanAccent
                                : Colors.orangeAccent,
                            size: 30,
                          ),
                          const SizedBox(width: 12),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Control Mode',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Choose how the pump is controlled',
                                  style: TextStyle(
                                    color: Colors.white54,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Switch(
                            value: autoMode,
                            onChanged: (value) {
                              setState(() {
                                autoMode = value;
                              });

                              if (value) {
                                checkSchedule();
                              }
                            },
                            activeThumbColor: Colors.cyanAccent,
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: autoMode
                              ? Colors.cyan.withValues(alpha: 0.08)
                              : Colors.orange.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              autoMode ? Icons.schedule : Icons.touch_app,
                              color: autoMode
                                  ? Colors.cyanAccent
                                  : Colors.orangeAccent,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                autoMode
                                    ? 'AUTO: pump follows your schedule.'
                                    : 'MANUAL: you control the pump.',
                                style: TextStyle(
                                  color: autoMode
                                      ? Colors.cyanAccent
                                      : Colors.orangeAccent,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // =========================
                      // AUTO SCHEDULE
                      // =========================
                      if (autoMode) ...[
                        const SizedBox(height: 18),

                        Row(
                          children: [
                            Expanded(
                              child: _timeButton(
                                title: 'START TIME',
                                time: formatTime(startTime),
                                icon: Icons.play_circle,
                                color: Colors.greenAccent,
                                onTap: selectStartTime,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _timeButton(
                                title: 'STOP TIME',
                                time: formatTime(stopTime),
                                icon: Icons.stop_circle,
                                color: Colors.redAccent,
                                onTap: selectStopTime,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 14),

                        if (startTime != null && stopTime != null)
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(13),
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.18),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.event_available,
                                  color: Colors.cyanAccent,
                                  size: 21,
                                ),
                                const SizedBox(width: 9),
                                Expanded(
                                  child: Text(
                                    'Schedule: ${formatTime(startTime)} → ${formatTime(stopTime)}',
                                    style: const TextStyle(
                                      color: Colors.white70,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ],
                  ),
                ),

                const SizedBox(height: 18),

                // =========================
                // PUMP
                // =========================
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xff163447).withValues(alpha: 0.95),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.water_drop,
                            color: pumpRunning
                                ? Colors.greenAccent
                                : Colors.redAccent,
                            size: 35,
                          ),
                          const SizedBox(width: 12),
                          const Expanded(
                            child: Text(
                              'Pump',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            pumpRunning ? 'RUNNING' : 'STOPPED',
                            style: TextStyle(
                              color: pumpRunning
                                  ? Colors.greenAccent
                                  : Colors.redAccent,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 18),

                      // MANUAL CONTROLS
                      if (!autoMode)
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: manualStart,
                                icon: const Icon(Icons.play_arrow),
                                label: const Text('START'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 14,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: manualStop,
                                icon: const Icon(Icons.stop),
                                label: const Text('STOP'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 14,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                      if (autoMode)
                        const Text(
                          'Pump is controlled automatically according to the schedule.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.cyanAccent,
                            fontSize: 12,
                          ),
                        ),
                    ],
                  ),
                ),

                const SizedBox(height: 18),

                // =========================
                // WATER QUALITY
                // =========================
                infoCard(
                  title: 'Water Quality',
                  value: '$waterQuality',
                  unit: 'ppm',
                  icon: Icons.water_drop,
                  color: Colors.cyan,
                ),

                const SizedBox(height: 12),

                // =========================
                // WATER PRODUCED
                // =========================
                infoCard(
                  title: 'Water Produced',
                  value: '$waterProduced',
                  unit: 'L',
                  icon: Icons.water,
                  color: Colors.blue,
                ),

                const SizedBox(height: 12),

                // =========================
                // BATTERY
                // =========================
                infoCard(
                  title: 'Battery',
                  value: '$battery',
                  unit: '%',
                  icon: Icons.battery_full,
                  color: Colors.greenAccent,
                ),

                const SizedBox(height: 12),

                // =========================
                // SOLAR
                // =========================
                infoCard(
                  title: 'Solar Power',
                  value: '$solarPower',
                  unit: 'W',
                  icon: Icons.wb_sunny,
                  color: Colors.amber,
                ),

                const SizedBox(height: 18),

                // =========================
                // ALERTS
                // =========================
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: const Color(0xff163447).withValues(alpha: 0.95),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.notifications_none,
                        color: Colors.cyan,
                        size: 32,
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Alerts',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'No Alerts',
                              style: TextStyle(color: Colors.greenAccent),
                            ),
                          ],
                        ),
                      ),
                      Icon(Icons.check_circle, color: Colors.greenAccent),
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
      ),
    );
  }

  // =========================
  // TIME BUTTON
  // =========================

  Widget _timeButton({
    required String title,
    required String time,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: color.withValues(alpha: 0.35)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 27),
            const SizedBox(height: 7),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white54,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              time,
              style: TextStyle(
                color: color,
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
