import 'package:health_pulse/imports.dart';

class CheckOutTimeListTile extends StatefulWidget {
  const CheckOutTimeListTile({
    Key? key,
    required this.timeText,
  }) : super(key: key);

  final String timeText;

  @override
  State<CheckOutTimeListTile> createState() => _CheckOutTimeListTileState();
}

class _CheckOutTimeListTileState extends State<CheckOutTimeListTile> {
  bool checkboxValue = false;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      dense: true,
      title: Text(
        widget.timeText,
        style: GoogleFonts.poppins(
          textStyle: Theme.of(context).textTheme.titleMedium,
          fontWeight: FontWeight.w500,
        ),
      ),
      controlAffinity: ListTileControlAffinity.trailing,
      value: checkboxValue,
      onChanged: (value) {
        setState(() {
          checkboxValue = value!;
        });
      },
    );
  }
}