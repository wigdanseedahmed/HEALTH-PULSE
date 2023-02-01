import 'package:health_pulse/imports.dart';

class CovidButtonCardActivityFeed extends StatelessWidget {
  const CovidButtonCardActivityFeed({
    Key? key,
    required this.postTitle,
    this.source,
    this.date,
    required this.url,
    required this.imageURL,
    required this.postTime,
  }) : super(key: key);

  final String postTitle;
  final String? source;
  final String? date;
  final String url;
  final String imageURL;
  final String postTime;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
      child: OutlinedButton(
        onPressed: () async {
          if (!await launch(url)) throw 'URL can not launch $url';
        },
        style: ButtonStyle(
          side: MaterialStateProperty.all(
            const BorderSide(color: kPrimarySwatch),
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          postTitle,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                            textStyle: Theme.of(context).textTheme.bodyMedium,
                            color: kDarkGreyColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '$source • $date',
                          style: GoogleFonts.poppins(
                            textStyle: Theme.of(context).textTheme.bodySmall,
                            color: kDarkGreyColor.withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      postTime,
                      style: GoogleFonts.poppins(
                        textStyle: Theme.of(context).textTheme.bodySmall,
                        color: kDarkGreyColor.withOpacity(0.5),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 80,
                width: 80,
                margin: const EdgeInsets.only(top: 5, bottom: 5, left: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: kPrimarySwatch,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(imageURL),
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
