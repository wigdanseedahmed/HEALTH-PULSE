import 'package:health_pulse/imports.dart';

class ToolsAndServicesListTiles extends StatelessWidget {
  const ToolsAndServicesListTiles({
    Key? key,
    required this.text,
    required this.assetImage,
  }) : super(key: key);

  final String text;
  final String assetImage;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      onTap: () {
        debugPrint('onTap: $text');
      },
      leading: Container(
        height: 30,
        width: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          image: DecorationImage(image: AssetImage(assetImage)),
        ),
      ),
      title: Text(
        text,
        style: GoogleFonts.poppins(
          textStyle: Theme.of(context).textTheme.titleMedium,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
