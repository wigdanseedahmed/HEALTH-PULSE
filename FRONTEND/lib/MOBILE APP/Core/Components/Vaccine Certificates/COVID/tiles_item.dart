import 'package:health_pulse/imports.dart';

class ItemListTiles extends StatelessWidget {
  const ItemListTiles({
    Key? key,
    this.title = 'Title',
    this.item = 'Item',
  }) : super(key: key);

  final String title;
  final String item;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      title: Text(
        title,
        style: GoogleFonts.poppins(
          textStyle: Theme.of(context).textTheme.titleSmall,
          color: kDarkGreyColor.withOpacity(0.5),
        ),
      ),
      subtitle: Text(
        item,
        style: GoogleFonts.poppins(
          textStyle: Theme.of(context).textTheme.titleMedium,
          color: kDarkGreyColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}