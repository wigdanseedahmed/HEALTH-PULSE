import 'package:health_pulse/imports.dart';

class CovidItemRowListTiles extends StatelessWidget {
  const CovidItemRowListTiles({
    Key? key,
    this.itemLeft = '-',
    this.itemRight = '-',
    required this.headLeft,
    required this.headRight,
  }) : super(key: key);

  final String headLeft;
  final String itemLeft;
  final String headRight;
  final String itemRight;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Expanded(
          child: ListTile(
            dense: true,
            title: Text(
              headLeft,
              style: GoogleFonts.poppins(
                textStyle: Theme.of(context).textTheme.titleSmall,
                color: kDarkGreyColor.withOpacity(0.5),
              ),
            ),
            subtitle: Text(
              itemLeft,
              style: GoogleFonts.poppins(
                textStyle: Theme.of(context).textTheme.titleMedium,
                color: kDarkGreyColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        Expanded(
          child: ListTile(
            dense: true,
            title: Text(
              headRight,
              style: GoogleFonts.poppins(
                textStyle: Theme.of(context).textTheme.titleSmall,
                color: kDarkGreyColor.withOpacity(0.5),
              ),
            ),
            subtitle: Text(
              itemRight,
              style: GoogleFonts.poppins(
                textStyle: Theme.of(context).textTheme.titleMedium,
                color: kDarkGreyColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
