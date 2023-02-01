import 'package:health_pulse/imports.dart';

class CheckInDetailsListTiles extends StatelessWidget {
  const CheckInDetailsListTiles({
    Key? key,
    required this.onPressed,
    required this.iconCheckInOrOut,
    required this.location,
    required this.date,
  }) : super(key: key);

  final VoidCallback onPressed;
  final IconData iconCheckInOrOut;
  final String location;
  final String date;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: ListTile(
        dense: true,
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: kPrimarySwatch, borderRadius: BorderRadius.circular(10)),
          child: Icon(
            iconCheckInOrOut,
            color: kWhiteColor,
            size: 30,
          ),
        ),
        title: Text(
          location,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.poppins(
            textStyle: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        subtitle: Text(
          date,
          style: GoogleFonts.poppins(
            textStyle: Theme.of(context).textTheme.bodyMedium,
            color: kDarkGreyColor.withOpacity(0.7),
          ),
        ),
      ),
    );
  }
}
