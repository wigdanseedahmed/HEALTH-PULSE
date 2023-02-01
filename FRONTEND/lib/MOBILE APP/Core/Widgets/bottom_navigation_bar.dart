///----------------------------- 🌎 PROJECT IMPORTS -----------------------------///
import 'package:health_pulse/imports.dart';

class CustomBottomNavBarMA extends StatelessWidget {
  const CustomBottomNavBarMA({
    Key? key,
    required this.selectedMenu,
  }) : super(key: key);

  final MenuState selectedMenu;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: Icon(
              EvaIcons.home,
              size: 33.0,
              color: MenuState.DashboardScreen == selectedMenu
                  ? kViolet
                  : Colors.grey,
            ),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeScreenMA(),
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.map_rounded,
              size: 33.0,
              color: MenuState.GeographicMapScreen == selectedMenu
                  ? kViolet
                  : Colors.grey,
            ),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const GeographicLocationMapScreenMA(
                  healthFacilitiesDatabaseContent: [],
                  healthFacilityType: [],
                  sectorType: [],
                  insuranceProvided: [],
                  insuranceSectorType: [],
                  isEmergencyProvided: [],
                  specialization: [],
                  workingHours: [],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(0.0),
            //padding: const EdgeInsets.only(bottom: 9.0),
            child: IconButton(
              icon: Icon(
                EvaIcons.creditCard,
                size: 33.0,
                color: MenuState.VaccineDigitalizationScreen == selectedMenu
                    ? kViolet
                    : Colors.grey,
              ),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const VaccineCertificateScreenMA(),
                ),
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.newspaper_outlined,
              size: 33.0,
              color:
                  MenuState.NewsScreen == selectedMenu ? kViolet : Colors.grey,
            ),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const NewsPostScreenMA(),
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              EvaIcons.optionsOutline,
              size: 33.0,
              color: MenuState.SettingsScreen == selectedMenu
                  ? kViolet
                  : Colors.grey,
            ),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SettingsScreenMA(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
