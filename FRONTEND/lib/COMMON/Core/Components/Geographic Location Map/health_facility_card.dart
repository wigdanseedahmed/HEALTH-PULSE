///----------------------------- 🌎 PROJECT IMPORTS -----------------------------///
import 'package:health_pulse/imports.dart';

class HealthFacilityCard extends StatelessWidget {
  final HealthFacilityInformationModel healthFacilityInfo;

  final Size screenSize;

  const HealthFacilityCard(
      {Key? key, required this.screenSize, required this.healthFacilityInfo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var healthCareDefaultImage = "data:image/jpeg;base64,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";

    return InkWell(
      onTap: () {
        //print(physicianInfo);
        /*Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                DetailScreen(selectedPhysician: physicianInfo),
          ),
        );*/
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 18.0),
        margin: const EdgeInsets.only(
          bottom: 20.0,
        ),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1.0,
                blurRadius: 6.0,
              ),
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: const Color(0xFFD9D9D9),
                  backgroundImage: NetworkImage(healthFacilityInfo.imagePath == null? healthCareDefaultImage : healthFacilityInfo.imagePath!),
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
                        text: '${healthFacilityInfo.facility_type}\n',
                        style: const TextStyle(
                          color: Colors.purple,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          height: 1.3,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text:
                            healthFacilityInfo.medical_facility_name_en,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextSpan(
                            text: '\n${healthFacilityInfo.address}',
                            style: const TextStyle(
                              color: Colors.black45,
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
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
                          rating: healthFacilityInfo.rank == null? 0.0 : healthFacilityInfo.rank!,
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
            const Icon(
              Icons.favorite_outline,
              color: lightColor,
              size: 36,
            ),
          ],
        ),
      ),
    );
  }
}
