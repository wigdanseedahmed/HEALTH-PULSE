///----------------------------- 🌎 PROJECT IMPORTS -----------------------------///
import 'package:health_pulse/imports.dart';

class DetailScreen extends StatefulWidget {
  final PhysicianModel selectedPhysician;

  const DetailScreen({
    Key? key,
    required this.selectedPhysician,
  }) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            color: midColor,
            // image: DecorationImage(
            //   image: AssetImage('assets/images/detail_illustration.png'),
            //   alignment: Alignment.topCenter,
            //   fit: BoxFit.fitWidth,
            // ),
          ),
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 25.0,
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: const Icon(
                        Icons.more_vert_rounded,
                        color: Colors.white,
                        size: 30.0,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(35),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Image.network(
                            widget.selectedPhysician.imagePath!,
                            width: 120,
                            height: 120,
                            fit: BoxFit.fill,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                '${widget.selectedPhysician.prefix ?? setPrefix(widget.selectedPhysician.medicalFieldSpeciality)} ${widget.selectedPhysician.fullName ?? "${widget.selectedPhysician.firstName} ${widget.selectedPhysician.lastName}"}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: lightColor,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                widget.selectedPhysician.specialty!,
                                style: const TextStyle(
                                  color: midColor,
                                  fontSize: 13,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Align(
                                alignment: FractionalOffset.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    top: 5.0,
                                  ),
                                  child: StarRating(
                                    rating: widget.selectedPhysician.rank!,
                                    rowAlignment: MainAxisAlignment.start,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: <Widget>[
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: kBlueColor.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: SvgPicture.asset(
                                      'assets/icons/phone.svg',
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: kYellowColor.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: SvgPicture.asset(
                                      'assets/icons/chat.svg',
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: kOrangeColor.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: SvgPicture.asset(
                                      'assets/icons/video.svg',
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      widget.selectedPhysician.biography!.isNotEmpty
                          ? const Text(
                              'About Physician',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: lightColor,
                              ),
                            )
                          : Container(),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.selectedPhysician.biography!,
                        style: const TextStyle(
                          height: 1.6,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Physician History',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: lightColor,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          left: 5.0,
                          right: 5.0,
                        ),
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 5,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    (widget.selectedPhysician.medicalEducation!
                                            .isNotEmpty)
                                        ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              const Text(
                                                'MEDICAL EDUCATION',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12,
                                                  color: Color(0xFF6f6f6f),
                                                ),
                                              ),
                                              Text(
                                                widget.selectedPhysician
                                                    .medicalEducation!,
                                                style: const TextStyle(
                                                  color: Color(0xFF9f9f9f),
                                                ),
                                              )
                                            ],
                                          )
                                        : Container(),
                                    (widget.selectedPhysician.internship!
                                            .isNotEmpty)
                                        ? Container(
                                            margin: const EdgeInsets.only(
                                              top: 20.0,
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  'INTERNSHIP',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12,
                                                    color: Color(0xFF6f6f6f),
                                                  ),
                                                ),
                                                Text(
                                                  widget.selectedPhysician
                                                      .internship!,
                                                  style: const TextStyle(
                                                    color: Color(0xFF9f9f9f),
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        : Container(),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 5,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    (widget.selectedPhysician.residency!
                                            .isNotEmpty)
                                        ? Container(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  'RESIDENCY',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12,
                                                    color: Color(0xFF6f6f6f),
                                                  ),
                                                ),
                                                Text(
                                                  widget.selectedPhysician
                                                      .residency!,
                                                  style: const TextStyle(
                                                    color: Color(0xFF9f9f9f),
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        : Container(),
                                    (widget.selectedPhysician.fellowship!
                                            .isNotEmpty)
                                        ? Container(
                                            margin: const EdgeInsets.only(
                                              top: 20.0,
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  'FELLOWSHIP',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12,
                                                    color: Color(0xFF6f6f6f),
                                                  ),
                                                ),
                                                Text(
                                                  widget.selectedPhysician
                                                      .fellowship!,
                                                  style: const TextStyle(
                                                    color: Color(0xFF9f9f9f),
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        : Container(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Upcoming Schedules',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: lightColor,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      //TODO: Add schedule from backend and change to listview.builder add color based on criticality
                      ScheduleCard(
                        title: 'Consultation',
                        description: 'Consultation',
                        hospitalName: 'Hospital Name',
                        day: 'Sunday',
                        date: '12',
                        month: 'Jan',
                        startTime: "9am",
                        endTime: "11am",
                        bgColor: kBlueColor,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ScheduleCard(
                        title: 'Surgery',
                        description: 'Surgery',
                        hospitalName: 'Hospital Name',
                        day: 'Monday',
                        date: '13',
                        month: 'Jan',
                        startTime: "9am",
                        endTime: "11am",
                        bgColor: kYellowColor,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ScheduleCard(
                        title: 'Consultation',
                        description: 'Consultation',
                        hospitalName: 'Hospital Name',
                        day: 'Tuesday',
                        date: '14',
                        month: 'Jan',
                        startTime: "9am",
                        endTime: "11am",
                        bgColor: kOrangeColor,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
