import 'package:health_pulse/imports.dart';

class TextSubTitle extends StatelessWidget {
  const TextSubTitle({
    Key? key,
    required this.title,
    this.color = kDarkGreyColor,
  }) : super(key: key);

  final String title;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.poppins(
        textStyle: Theme.of(context).textTheme.titleLarge,
        color: color,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
