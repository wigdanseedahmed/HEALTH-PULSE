
import 'package:health_pulse/imports.dart';

class ButtonDropDown extends StatefulWidget {
  ButtonDropDown({
    Key? key,
    required this.dropdownItems,
    required this.initialValue,
  }) : super(key: key);

  final List<String> dropdownItems;
  //! TODO: Immutable class, need to check again later
  String initialValue;

  @override
  State<ButtonDropDown> createState() => _ButtonDropDownState();
}

class _ButtonDropDownState extends State<ButtonDropDown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        hint: Text(widget.initialValue),
        value: widget.initialValue,
        icon: const Icon(Icons.keyboard_arrow_down_rounded),
        buttonHeight: 35,
        buttonDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: const Color(0xFFE6E6E6)),
          color: kDarkWhiteColor,
        ),
        buttonPadding: const EdgeInsets.only(left: 10, right: 10),
        dropdownWidth: 150,
        dropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        items: widget.dropdownItems
            .map((item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: GoogleFonts.poppins(
                      textStyle: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ))
            .toList(),
        onChanged: (value) {
          setState(() {
            widget.initialValue = value as String;
          });
        },
      ),
    );
  }
}
