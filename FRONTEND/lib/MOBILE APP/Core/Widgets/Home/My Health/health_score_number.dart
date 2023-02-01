///----------------------------- 🌎 PROJECT IMPORTS -----------------------------///
import 'package:health_pulse/imports.dart';
import 'package:animated_flip_counter/animated_flip_counter.dart';

Widget myHealthScoreNumber(double? userHealthScore, context) {
  return Container(
    decoration: const BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(30)),
      color: Color(0xFFe9f0f3),
    ),
    child: Center(
      child: AnimatedFlipCounter(
        duration: const Duration(milliseconds: 500),
        value: userHealthScore ?? 1,
        /* pass in a number like 2014 */
        textStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 40,
          color: kShamrock,
        ),
      ),
    ),
  );
}