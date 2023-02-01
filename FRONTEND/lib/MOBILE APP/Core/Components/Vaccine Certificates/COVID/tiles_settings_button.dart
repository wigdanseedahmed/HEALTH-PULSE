import 'package:health_pulse/imports.dart';

class SettingsButtonListTiles extends StatelessWidget {
  const SettingsButtonListTiles({
    Key? key,
    required this.text,
    required this.icon,
    this.onTap,
  }) : super(key: key);

  final String text;
  final IconData icon;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: kPrimarySwatch.withOpacity(0.5),
      child: ListTile(
        contentPadding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
        leading: Container(
          width: 40,
          height: 40,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: kPrimarySwatch,
          ),
          child: Icon(
            icon,
            color: kWhiteColor,
          ),
        ),
        title: Text(
          text,
          style: GoogleFonts.poppins(
            textStyle: Theme.of(context).textTheme.titleMedium,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: const Icon(
          Icons.keyboard_arrow_right_rounded,
          size: 30,
          color: kPrimarySwatch,
        ),
      ),
    );
  }
}
