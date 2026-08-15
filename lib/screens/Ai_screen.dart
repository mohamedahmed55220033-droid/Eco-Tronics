import 'package:flutter/material.dart';

class AiScreen extends StatefulWidget {
  const AiScreen({super.key});

  @override
  State<AiScreen> createState() => _AiScreenState();
}

class _AiScreenState extends State<AiScreen> {
  bool selfHealingEnabled = true;

  int filterHealth = 85;
  String pumpStatus = 'Normal';
  String pressureStatus = 'Stable';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff071E26),
      appBar: AppBar(
        backgroundColor: const Color(0xff071E26),
        elevation: 0,
        title: const Text(
          'AI Prediction',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Background Logo
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
              // AI HEADER
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
                    Icon(Icons.smart_toy, color: Colors.cyanAccent, size: 55),
                    SizedBox(height: 12),
                    Text(
                      'Eco-Tronics AI',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Predictive Maintenance & Self-Healing',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white70, fontSize: 13),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              // SELF HEALING
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
                        color: Colors.cyan.withValues(alpha: 0.15),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.healing,
                        color: Colors.cyanAccent,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Self-Healing System',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Automatic fault response',
                            style: TextStyle(
                              color: Colors.white54,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Switch(
                      value: selfHealingEnabled,
                      onChanged: (value) {
                        setState(() {
                          selfHealingEnabled = value;
                        });
                      },
                      activeThumbColor: Colors.cyanAccent,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              // SYSTEM ANALYSIS
              const Text(
                'Live Analysis',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              _statusCard(
                icon: Icons.filter_alt,
                title: 'Filter Health',
                value: '$filterHealth%',
                status: 'Good',
                color: Colors.greenAccent,
              ),

              const SizedBox(height: 12),

              _statusCard(
                icon: Icons.water_drop,
                title: 'Pump',
                value: pumpStatus,
                status: 'Normal',
                color: Colors.greenAccent,
              ),

              const SizedBox(height: 12),

              _statusCard(
                icon: Icons.speed,
                title: 'Pressure',
                value: pressureStatus,
                status: 'Safe',
                color: Colors.greenAccent,
              ),

              const SizedBox(height: 22),

              // PREDICTION
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xff163447).withValues(alpha: 0.96),
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(
                    color: Colors.amber.withValues(alpha: 0.35),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(
                          Icons.warning_amber_rounded,
                          color: Colors.amber,
                          size: 30,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'AI Prediction',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 18),

                    const Text(
                      'Filter replacement predicted',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      'Estimated time: after 2 days',
                      style: TextStyle(color: Colors.amber, fontSize: 14),
                    ),

                    const SizedBox(height: 18),

                    LinearProgressIndicator(
                      value: filterHealth / 100,
                      minHeight: 8,
                      borderRadius: BorderRadius.circular(10),
                      backgroundColor: Colors.white12,
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        Colors.greenAccent,
                      ),
                    ),

                    const SizedBox(height: 10),

                    const Text(
                      'Filter efficiency: 85%',
                      style: TextStyle(color: Colors.white54, fontSize: 12),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              // SELF HEALING ACTION
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: selfHealingEnabled
                      ? const Color(0xff123A32)
                      : const Color(0xff163447),
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          selfHealingEnabled
                              ? Icons.auto_awesome
                              : Icons.info_outline,
                          color: selfHealingEnabled
                              ? Colors.greenAccent
                              : Colors.white54,
                          size: 28,
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          'Recommended Action',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 15),

                    Text(
                      selfHealingEnabled
                          ? 'System will monitor the filter and automatically adjust operation when required.'
                          : 'Enable Self-Healing to allow automatic system responses.',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                        height: 1.5,
                      ),
                    ),

                    if (selfHealingEnabled) ...[
                      const SizedBox(height: 15),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.18),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: Colors.greenAccent,
                              size: 20,
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'Self-Healing protection is active.',
                                style: TextStyle(
                                  color: Colors.greenAccent,
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

              const SizedBox(height: 25),

              const Center(
                child: Text(
                  'Eco-Tronics⚡🌍',
                  style: TextStyle(color: Colors.white24, fontSize: 12),
                ),
              ),

              const SizedBox(height: 8),

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

  Widget _statusCard({
    required IconData icon,
    required String title,
    required String value,
    required String status,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: const Color(0xff163447).withValues(alpha: 0.94),
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
                    fontSize: 18,
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
