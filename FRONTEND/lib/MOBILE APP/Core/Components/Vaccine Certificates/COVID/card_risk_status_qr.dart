import 'package:health_pulse/imports.dart';

class CardRiskStatusQR extends StatelessWidget {
  const CardRiskStatusQR({
    Key? key,
    required this.date,
    required this.symptom,
  }) : super(key: key);

  final String date;
  final String symptom;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Column(
        children: [
          Container(
            height: 110,
            width: double.infinity,
            color: kRiskStatusGreen,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Risk Status',
                    style: GoogleFonts.poppins(
                      color: kWhiteColor,
                      textStyle: Theme.of(context).textTheme.headlineSmall,
                      height: 0.7,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'As of $date',
                    style: TextStyle(color: kWhiteColor.withOpacity(0.7)),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    symptom,
                    style: GoogleFonts.poppins(
                      color: kWhiteColor,
                      textStyle: Theme.of(context).textTheme.titleLarge,
                      fontWeight: FontWeight.w600,
                      height: 0.7,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              children: [
                QrImage(
                  data: 'https://mysejahtera.malaysia.gov.my/intro/',
                  size: MediaQuery.of(context).size.width / 1.5,
                ),
                Text(
                  'MySejahtera Profile QR Code',
                  style: GoogleFonts.poppins(
                    textStyle: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
