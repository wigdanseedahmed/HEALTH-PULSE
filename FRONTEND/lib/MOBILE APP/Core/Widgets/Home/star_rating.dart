///----------------------------- 🌎 PROJECT IMPORTS -----------------------------///
import 'package:health_pulse/imports.dart';

class StarRating extends StatelessWidget {
  final int starCount;
  final double rating;
  final Color? color;
  final MainAxisAlignment rowAlignment;

  const StarRating({
    Key? key,
    this.starCount = 5,
    this.rating = .0,
    this.color,
    this.rowAlignment = MainAxisAlignment.center,
  }) : super(key: key);

  Widget buildStar(
      BuildContext context, int rank, MainAxisAlignment rowAlignment) {
    Icon icon;
    if (rank >= rating / 2) {
      return icon = const Icon(
        Icons.star_border,
        color: Colors.amber,
      );
    } else if (rank > (rating / 2) - 1 && rank < rating / 2) {
      return icon = Icon(
        Icons.star_half,
        color: color ?? Colors.amber,
      );
    } else {
      return icon = Icon(
        Icons.star,
        color: color ?? Colors.amber,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "${(rating / 2)}",
        ),
        const SizedBox(width: 5.0),
        Row(
          mainAxisAlignment: rowAlignment,
          children: List.generate(
            starCount,
            (rank) => buildStar(context, rank, rowAlignment),
          ),
        ),
      ],
    );
  }
}
