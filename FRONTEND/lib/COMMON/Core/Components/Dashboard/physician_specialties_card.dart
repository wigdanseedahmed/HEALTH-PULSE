///----------------------------- 🌎 PROJECT IMPORTS -----------------------------///
import 'package:health_pulse/imports.dart';

class MedicalFieldSpecialties extends StatelessWidget {
  const MedicalFieldSpecialties({
    Key? key,
    required this.screenSize,
    required this.specialtyName,
    required this.specialtyImage,
    required this.specialtyDoctorCount,
  }) : super(key: key);

  final Size screenSize;
  final String specialtyName;
  final String specialtyImage;
  final int specialtyDoctorCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: 20.0,
        bottom: 10.0,
      ),
      width: 135,
      child: Card(
        elevation: 3.0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        color: DynamicTheme.of(context)?.brightness == Brightness.light
            ? Colors.white
            : Colors.white30,
        child: InkWell(
          customBorder: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    SpecializationResultPage(speciality: specialtyName),
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                        top: 5.0,
                        bottom: 12.5,
                      ),
                      child: CircleAvatar(
                        backgroundColor: const Color(0xFFD9D9D9),
                        backgroundImage: AssetImage(specialtyImage),
                        radius: 40.0,
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    specialtyName,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: DynamicTheme.of(context)?.brightness ==
                              Brightness.light
                          ? Colors.black45
                          : Colors.white54,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 3.0,
                    ),
                    child: Text(
                      '$specialtyDoctorCount Doctors',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: kCannonPink,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
