import 'package:health_pulse/imports.dart';

class ButtonColor extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const ButtonColor({Key? key, required this.text, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      child: TextButton(
        onPressed: onPressed,
        child: Text(text),
        style: TextButton.styleFrom(
          backgroundColor: kPrimarySwatch,
          primary: kWhiteColor,
          padding: const EdgeInsets.only(left: 10, right: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
        ),
      ),
    );
  }
}
