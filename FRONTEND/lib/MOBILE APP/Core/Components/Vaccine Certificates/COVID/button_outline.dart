import 'package:health_pulse/imports.dart';
class ButtonOutline extends StatelessWidget {
  const ButtonOutline({
    Key? key,
    required this.text,
    this.isSelected = false,
    this.onPressed,
  }) : super(key: key);

  final String text;
  final bool isSelected;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5),
      child: OutlinedButton(
        onPressed: onPressed,
        child: Text(text),
        style: ButtonStyle(
          foregroundColor:
              isSelected ? null : MaterialStateProperty.all(kDarkGreyColor),
          side: isSelected
              ? null
              : MaterialStateProperty.all(
                  const BorderSide(color: kPrimarySwatch),
                ),
          backgroundColor: isSelected
              ? MaterialStateProperty.all(kPrimarySwatch.withOpacity(0.2))
              : null,
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
          ),
        ),
      ),
    );
  }
}
