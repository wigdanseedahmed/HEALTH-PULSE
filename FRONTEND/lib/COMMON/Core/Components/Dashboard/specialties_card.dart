///----------------------------- 🌎 PROJECT IMPORTS -----------------------------///
import 'package:health_pulse/imports.dart';

class SpecialtiesCard extends StatelessWidget {
  final PhysicianModel physicianInfo;

  final bool isBookmarkedPressed;

  final Function()? onBookmarkPressed;

  final Size screenSize;

  const SpecialtiesCard(
      {Key? key,
      required this.screenSize,
      required this.physicianInfo,
      this.onBookmarkPressed,
      required this.isBookmarkedPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: InkWell(
          onTap: () {
            //print(physicianInfo);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    DetailScreen(selectedPhysician: physicianInfo),
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 7.0, horizontal: 18.0),

            decoration: BoxDecoration(
              color: DynamicTheme.of(context)?.brightness == Brightness.light
                  ? Colors.black12
                  : Colors.white30,
              borderRadius: BorderRadius.circular(12.0),

            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    physicianInfo.imagePath == null
                        ? CircleAvatar(
                            backgroundColor: const Color(0xFFD9D9D9),
                            radius: 36.0,
                            child: Text(
                                "${physicianInfo.firstName![0]}${physicianInfo.lastName![0]}"
                                    .toUpperCase()),
                          )
                        : CircleAvatar(
                            backgroundColor: const Color(0xFFD9D9D9),
                            backgroundImage: NetworkImage(physicianInfo.imagePath!),
                            radius: 36.0,
                          ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        RichText(
                          text: TextSpan(
                            text: '${physicianInfo.specialty}\n',
                            style: const TextStyle(
                              color: kMeteorite,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              height: 1.3,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text:
                                    '${physicianInfo.prefix ?? setPrefix(physicianInfo.medicalFieldSpeciality)} ${physicianInfo.fullName ?? "${physicianInfo.firstName} ${physicianInfo.lastName}"}',
                                style: TextStyle(
                                  color: DynamicTheme.of(context)?.brightness ==
                                          Brightness.light
                                      ? Colors.black
                                      : Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: physicianInfo.medicalFacilityName == null ||
                                        physicianInfo.medicalFacilityName!.isEmpty
                                    ? ''
                                    : '\n${physicianInfo.medicalFacilityName![0]}',
                                style: TextStyle(
                                  color: DynamicTheme.of(context)?.brightness ==
                                          Brightness.light
                                      ? Colors.black45
                                      : Colors.white54,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              TextSpan(
                                text: physicianInfo.jobTitle ==
                                            null &&
                                        physicianInfo.medicalFacilityAddress == null || physicianInfo.medicalFacilityAddress!.isEmpty
                                    ? '\n5 min'
                                    : physicianInfo.medicalFacilityAddress == null || physicianInfo.medicalFacilityAddress!.isEmpty
                                        ? '\n${physicianInfo.jobTitle} | 5 min'
                                        : physicianInfo.jobTitle == null
                                            ? '\n${physicianInfo.medicalFacilityAddress![0]} | 5 min'
                                            : '\n${physicianInfo.jobTitle} \n${physicianInfo.medicalFacilityAddress} | 5 min',
                                style: TextStyle(
                                  color: DynamicTheme.of(context)?.brightness ==
                                          Brightness.light
                                      ? Colors.black38
                                      : Colors.white38,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 6.0,
                        ),
                        Align(
                          alignment: FractionalOffset.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 5.0,
                            ),
                            child: StarRating(
                              rating: physicianInfo.rank == null
                                  ? 0.0
                                  : physicianInfo.rank!,
                              rowAlignment: MainAxisAlignment.start,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 6.0,
                        ),
                        //TODO: ADD BOOKING OPTION
                        /*RaisedButton(
                          onPressed: () {},
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(80.0)),
                          padding: const EdgeInsets.all(0.0),
                          child: Ink(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: <Color>[darkColor, midColor, lightColor],
                                stops: [0.0, 0.5, 1.0],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(80.0)),
                            ),
                            child: Container(
                              constraints: const BoxConstraints(
                                  minWidth: 88.0, minHeight: 36.0),
                              // min sizes for Material buttons
                              alignment: Alignment.center,
                              child: const Text(
                                'Book Visit',
                                style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 13,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),*/
                      ],
                    ),
                  ],
                ),
                IconButton(
                  icon: Icon(
                    isBookmarkedPressed == false
                        ? Icons.favorite_outline
                        : Icons.favorite,
                    color: kBrickRed,
                    size: 36,
                  ),
                  onPressed: onBookmarkPressed,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
