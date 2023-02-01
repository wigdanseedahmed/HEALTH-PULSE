import 'package:health_pulse/imports.dart';

class CardToolsAndServices extends StatelessWidget {
  const CardToolsAndServices({
    Key? key,
    required this.text,
    required this.assetImage,
    this.onTap,
  }) : super(key: key);

  final String text;
  final String assetImage;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        onTap: onTap,
        splashColor: kPrimarySwatch.withOpacity(0.3),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    image: DecorationImage(
                      image: AssetImage(assetImage),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  text,
                  style: GoogleFonts.poppins(
                    textStyle: Theme.of(context).textTheme.bodySmall,
                    color: kDarkGreyColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
