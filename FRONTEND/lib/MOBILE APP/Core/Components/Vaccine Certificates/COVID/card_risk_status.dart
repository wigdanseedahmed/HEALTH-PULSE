import 'package:health_pulse/imports.dart';

class CardRiskStatus extends StatelessWidget {
  const CardRiskStatus({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Card(
        color: kRiskStatusGreen,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
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
                'As of 30 Jan, 2022, 8:30 AM',
                style: TextStyle(color: kWhiteColor.withOpacity(0.7)),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                'Low Risk No Symptom',
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
    );
  }
}
