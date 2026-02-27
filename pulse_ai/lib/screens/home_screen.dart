import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List hospitals = [];
  bool loading = false;

  Future<void> openMap(double lat, double lng) async {
  final Uri url = Uri.parse(
    "https://www.google.com/maps/dir/?api=1&destination=$lat,$lng",
  );

  if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
    throw Exception("Could not launch map");
  }
}

  Future<void> fetchHospitals() async {
    setState(() {
      loading = true;
    });

    final response = await http.post(
      Uri.parse("http://127.0.0.1:8000/recommend"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "lat": 28.7041,
        "lng": 77.1025,
        "emergency": "cardiac",
        "insurance": "HDFC"
      }),
    );

    if (response.statusCode == 200) {
      setState(() {
        hospitals = jsonDecode(response.body);
        loading = false;
      });
    } else {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: SafeArea(
        child: Column(
          children: [
            // HEADER
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 24),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFE53935), Color(0xFFD32F2F)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(30),
                ),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "PULSE",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Smart Emergency Hospital Finder",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // BUTTON
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE53935),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 6,
                  ),
                  onPressed: fetchHospitals,
                  child: loading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          "Find Emergency Care",
                          style: TextStyle(fontSize: 18),
                        ),
                ),
              ),
            ),

            const SizedBox(height: 25),

            // RESULTS
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: hospitals.length,
                itemBuilder: (context, index) {
                  final hospital = hospitals[index];

                  return GestureDetector(
                    onTap: () {
                      final lat = hospital["lat"];
                      final lng = hospital["lng"];

                      if (lat != null && lng != null) {
                        final parsedLat = double.tryParse(lat.toString());
                        final parsedLng = double.tryParse(lng.toString());

                        if (parsedLat != null && parsedLng != null) {
                          openMap(parsedLat, parsedLng);
                        } else {
                          print("Invalid coordinates");
                        }
                      } else {
                        print("Coordinates missing in backend response");
                      }
                    },
                      
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            hospital["name"].toString(),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            children: [
                              _infoChip(
                                  "ETA",
                                  "${hospital["eta"]} min",
                                  Colors.red),
                              _infoChip(
                                  "Beds",
                                  hospital["beds_available"].toString(),
                                  Colors.green),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoChip(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        "$label: $value",
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}