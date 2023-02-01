import 'package:health_pulse/imports.dart';

class CardProfile extends StatelessWidget {
  const CardProfile({
    Key? key,
    required this.name,
    required this.email,
    required this.idNumber,
    required this.location,
  }) : super(key: key);

  final String name;
  final String email;
  final String idNumber;
  final String location;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Card(
            elevation: 5,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 60, bottom: 20, left: 15, right: 15),
              child: Column(
                children: [
                  Text(
                    name,
                    style: GoogleFonts.poppins(
                      textStyle: Theme.of(context).textTheme.headlineSmall,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    email,
                    style: GoogleFonts.poppins(
                      textStyle: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              'I/C NO',
                              style: GoogleFonts.poppins(
                                textStyle:
                                    Theme.of(context).textTheme.bodySmall,
                              ),
                            ),
                            Text(
                              idNumber,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                textStyle:
                                    Theme.of(context).textTheme.titleMedium,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              'STATE',
                              style: GoogleFonts.poppins(
                                textStyle:
                                    Theme.of(context).textTheme.bodySmall,
                              ),
                            ),
                            Text(
                              location,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                textStyle:
                                    Theme.of(context).textTheme.titleMedium,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  ButtonColor(
                    text: 'Refresh Profile',
                    onPressed: () {
                      debugPrint('onPressed: ButtonColor(\'Refresh\')');
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: CircleAvatar(
            backgroundColor: kPrimarySwatch,
            radius: 50,
            child: Text(
              getInitials(name),
              style: GoogleFonts.poppins(
                textStyle: Theme.of(context).textTheme.headlineLarge,
                color: kWhiteColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
