///----------------------------- 🌎 PROJECT IMPORTS -----------------------------///
import 'package:health_pulse/imports.dart';
import 'package:custom_map_markers/custom_map_markers.dart';

Icon currentIcon =
    const Icon(Icons.location_pin, color: Colors.black, size: 20.0);

Icon hospitalIcon =
    const Icon(Icons.local_hospital_sharp, color: Colors.redAccent, size: 20.0);

Icon dentalIcon = const Icon(Icons.local_hospital_sharp,
    color: Colors.greenAccent, size: 20.0);

Icon pharmacyIcon = const Icon(Icons.local_pharmacy_sharp,
    color: Colors.deepOrangeAccent, size: 20.0);

Icon labIcon = const Icon(Icons.local_hospital_sharp,
    color: Colors.amberAccent, size: 20.0);

Icon clinicIcon = const Icon(Icons.local_hospital_sharp,
    color: Colors.blueAccent, size: 20.0);

Icon doctorsIcon =
    const Icon(Icons.person_pin, color: Colors.purpleAccent, size: 20.0);

Icon searchIcon = const Icon(Icons.place, size: 30, color: Colors.red);

Icon setCustomMapPin(String? value) {
    switch (value) {
        case 'Hospital':
            return hospitalIcon;
            break;
        case 'Pharmacy':
            return pharmacyIcon;
            break;
        case 'Laboratory':
            return labIcon;
            break;
        case 'Dentist':
            return dentalIcon;
            break;
        case 'Clinic':
            return clinicIcon;
            break;
        default:
            return searchIcon;
            break;
    }}

String setCustomImageMapPin(String? value) {
    switch (value) {
        case 'Hospital':
            return 'assets/map marker/hospitalMarker.png';
            break;
        case 'Pharmacy':
            return 'assets/map marker/pharmacyMarker.png';
            break;
        case 'Laboratory':
            return 'assets/map marker/labMarker.png';
            break;
        case 'Dentist':
            return 'assets/map marker/dentistMarker.png';
            break;
        case 'Clinic':
            return 'assets/map marker/clinicMarker.png';
            break;
        default:
            return 'assets/map marker/hospitalMarker.png';
            break;
    }}

Color setCustomColourImageMapPin(String? value) {
    switch (value) {
        case 'Hospital':
            return Colors.teal.withOpacity(0.5);
            break;
        case 'Pharmacy':
            return Colors.black54;
            break;
        case 'Laboratory':
            return Colors.yellow.withOpacity(0.5);
            break;
        case 'Dentist':
            return Colors.blue.withOpacity(0.5);
            break;
        case 'Clinic':
            return Colors.teal.withOpacity(0.8);
            break;
        default:
            return Colors.white54;
            break;
    }}

/*Future<BitmapDescriptor> setCustomMapPin(String value) {
    switch (value) {
        case 'Hospital':
            return BitmapDescriptor.fromAssetImage(
                ImageConfiguration(devicePixelRatio: 2.5),
                'assets/images/markerDiamond1.png');
            break;
        case 'Pharmacy':
            return BitmapDescriptor.fromAssetImage(
                ImageConfiguration(devicePixelRatio: 2.5),
                'assets/images/markerGold1.png');
            break;
        case 'Laboratory':
            return BitmapDescriptor.fromAssetImage(
                ImageConfiguration(devicePixelRatio: 2.5),
                'assets/images/markerSilver1.png');
            break;
        case 'Dentist':
            return BitmapDescriptor.fromAssetImage(
                ImageConfiguration(devicePixelRatio: 2.5),
                'assets/images/markerBronze1.png');
            break;
        case 'Clinic':
            return BitmapDescriptor.fromAssetImage(
                ImageConfiguration(devicePixelRatio: 2.5),
                'assets/images/markerBronze1.png');
            break;
        default:
            return BitmapDescriptor.fromAssetImage(
                ImageConfiguration(devicePixelRatio: 2.5),
                'assets/images/markerRed1.png');
            break;
    }}*/

customFilterMarker(Color color, String? facilityType) {
    return Stack(
        children: [
            Icon(
                Icons.add_location,
                color: color,
                size: 50,
            ),
            Positioned(
                left: 15,
                top: 8,
                child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                        color: Colors.white, borderRadius: BorderRadius.circular(10)),
                    child: Center(child: Image.asset(
                        setCustomImageMapPin(facilityType),
                        width: 39,
                        height: 55,
                    ),
                    ),
                ),
            )
        ],
    );
}