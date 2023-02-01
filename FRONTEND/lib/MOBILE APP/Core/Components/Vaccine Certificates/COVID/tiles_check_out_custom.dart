import 'package:health_pulse/imports.dart';

class CheckOutCustomListTile extends StatefulWidget {
  const CheckOutCustomListTile({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  State<CheckOutCustomListTile> createState() => _CheckOutCustomListTileState();
}

class _CheckOutCustomListTileState extends State<CheckOutCustomListTile> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: ListTile(
        dense: true,
        title: Text(
          widget.text,
          style: GoogleFonts.poppins(
            textStyle: Theme.of(context).textTheme.titleMedium,
            fontWeight: FontWeight.w500,
          ),
        ),
        // TODO: Implement Custom check-out time
        onTap: () {},
        trailing: const Padding(
          padding: EdgeInsets.all(8),
          child: Icon(Icons.arrow_forward_ios_rounded, color: kPrimarySwatch),
        ),
      ),
    );
  }
}