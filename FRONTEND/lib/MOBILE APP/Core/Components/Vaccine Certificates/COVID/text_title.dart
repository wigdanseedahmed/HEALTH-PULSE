import 'package:health_pulse/imports.dart';

class TextTitle extends StatelessWidget {
  final String title;

  const TextTitle({
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.poppins(
        textStyle: Theme.of(context).textTheme.headline4,
        color: kPrimarySwatch,
        fontWeight: FontWeight.w600,
        height: 1.2,
      ),
    );
  }
}
