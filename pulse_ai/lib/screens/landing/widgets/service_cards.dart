import 'package:flutter/material.dart';

class ServiceCards extends StatelessWidget {
  const ServiceCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _ServiceCard(
            title: "Hospitals",
            icon: Icons.local_hospital,
            gradient: [Colors.orange.shade200, Colors.orange.shade100],
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _ServiceCard(
            title: "Pharmacy",
            icon: Icons.local_pharmacy,
            gradient: [Colors.blue.shade200, Colors.blue.shade100],
          ),
        ),
      ],
    );
  }
}

class _ServiceCard extends StatefulWidget {
  final String title;
  final IconData icon;
  final List<Color> gradient;

  const _ServiceCard({
    required this.title,
    required this.icon,
    required this.gradient,
  });

  @override
  State<_ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<_ServiceCard> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        height: 150, // ⬅️ taller
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: widget.gradient,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(28),
          boxShadow: _pressed
              ? []
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.12),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(widget.icon, size: 28),
            const Spacer(),
            Text(
              widget.title,
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
