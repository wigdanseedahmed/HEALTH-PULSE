///----------------------------- 🌎 PROJECT IMPORTS -----------------------------///
import 'package:health_pulse/imports.dart';

class FilterTopTitleWidget extends StatelessWidget {
  const FilterTopTitleWidget({
    Key? key,
    required this.titleText,
    required this.onPressedClearAll,
    this.text,
    this.textColor,
  }) : super(key: key);

  final titleText;
  final onPressedClearAll;
  final text;
  final textColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Text(
              titleText,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          TextButton(
            onPressed: onPressedClearAll,
            child: Text(
              text,
              style: TextStyle(color: textColor, fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}