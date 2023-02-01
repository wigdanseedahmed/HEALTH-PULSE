import 'package:health_pulse/imports.dart';

class ButtonVaccineCard extends StatelessWidget {
  const ButtonVaccineCard({
    Key? key,
    required this.text,
    required this.icon,
    this.onPressed,
  }) : super(key: key);

  final String text;
  final IconData icon;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Column(
        children: [
          Icon(
            icon,
            size: 40,
            color: kPrimarySwatch,
          ),
          Text(
            text,
            style: GoogleFonts.poppins(
              textStyle: Theme.of(context).textTheme.bodySmall,
              color: kPrimarySwatch,
            ),
          ),
        ],
      ),
      style: TextButton.styleFrom(
        primary: kPrimarySwatch,
        backgroundColor: kWhiteColor,
        padding: const EdgeInsets.all(10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: onPressed,
    );
  }
}
