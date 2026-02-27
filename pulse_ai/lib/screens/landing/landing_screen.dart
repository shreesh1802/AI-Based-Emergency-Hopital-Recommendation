import 'package:flutter/material.dart';
import 'package:pulse_ai/screens/landing/widgets/ambulance_button.dart';
import 'package:pulse_ai/screens/landing/widgets/bottom_action_bar.dart';
import 'package:pulse_ai/screens/landing/widgets/service_cards.dart';
import '../../widgets/app_drawer.dart';
import 'widgets/typing_greeting.dart';
// import 'widgets/diagnostic_button.dart';
//import 'widgets/emergency_button.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.black),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: CircleAvatar(
              radius: 18,
              //backgroundImage: const AssetImage("../../assets/image.PNG"),
            ),
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 16),

            const TypingGreeting(text: "Hello,\nAlicia Wins 👋"),

            const SizedBox(height: 24),

            const AmbulanceButton(),

            const SizedBox(height: 24),

            const ServiceCards(),

            const Spacer(),

            const BottomActionBar(),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
