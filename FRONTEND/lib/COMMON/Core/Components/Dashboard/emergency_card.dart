///----------------------------- 🌎 PROJECT IMPORTS -----------------------------///
import 'package:health_pulse/imports.dart';

class EmergencyCard extends StatelessWidget {
  final String emergencyType;

  final Function()? onTapped;

  final Size screenSize;

  const EmergencyCard({
    Key? key,
    required this.screenSize,
    required this.emergencyType,
    this.onTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapped,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFCE2029),
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1.0,
              blurRadius: 6.0,
            ),
          ],
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 40),
                Icon(
                  emergencyType == "Police"
                      ? Icons.local_police
                      : emergencyType == "Fire"
                          ? Icons.local_fire_department
                          : emergencyType == "Ambulance"
                              ? Icons.local_hospital_rounded
                              : Icons.traffic_outlined,
                  size: 75,
                  color: Colors.white,
                ),
                const SizedBox(height: 20),
                Text(
                  emergencyType,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
