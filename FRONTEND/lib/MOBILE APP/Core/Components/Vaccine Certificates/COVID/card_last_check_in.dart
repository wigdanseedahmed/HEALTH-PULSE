import 'package:health_pulse/imports.dart';

class CardLastCheckIn extends StatelessWidget {
  const CardLastCheckIn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Card(
        color: kDarkWhiteColor,
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
                'Last Check-In',
                style: GoogleFonts.poppins(
                  color: kDarkGreyColor,
                  textStyle: Theme.of(context).textTheme.headlineSmall,
                  height: 0.7,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '30 Jan, 2022, 10:05:55 AM',
                style: TextStyle(color: kDarkGreyColor.withOpacity(0.7)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Suria KLCC',
                    style: GoogleFonts.poppins(
                      color: kDarkGreyColor,
                      textStyle: Theme.of(context).textTheme.titleLarge,
                      height: 0.7,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  ButtonColor(
                    text: 'Check-out',
                    onPressed: () {
                      debugPrint('onPressed: ButtonColor(\'Check-out\')');
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
