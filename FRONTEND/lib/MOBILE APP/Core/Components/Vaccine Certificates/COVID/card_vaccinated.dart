import 'package:health_pulse/imports.dart';

class CardVaccinated extends StatelessWidget {
  const CardVaccinated({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Card(
        color: kVaccinatedFull,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: SizedBox(
          height: 500,
          width: 500,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 140,
                child: Stack(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            'asset/images/vaccine_image.jpg',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                      foregroundDecoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            kVaccinatedFull.withOpacity(0.3),
                            kVaccinatedFullDark.withOpacity(0.8),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '30 days ago',
                                style: GoogleFonts.poppins(
                                  color: kWhiteColor,
                                  textStyle:
                                      Theme.of(context).textTheme.headlineSmall,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                               const CardVaccinationCertificate(
                                                name: 'Anthony Parker William Smith',
                                                idNumber: '990808-08-8899',
                                                dose1Manufacturer: 'Pfizer-BioNTech',
                                                dose1Date: '8/12/2021',
                                                dose1Batch: 'A001',
                                                dose1Location: 'Stadium Bukit Jalil',
                                                dose2Manufacturer: 'Pfizer-BioNTech',
                                                dose2Date: '31/12/2021',
                                                dose2Batch: 'A030',
                                                dose2Location: 'Stadium Bukit Jalil',
                                                 dose3Date: '31/06/2022',
                                                 dose3Batch: 'A050',
                                                 dose3Location:'Stadium Bukit Jalil',
                                              ),),);
                                },
                                child: const Icon(
                                  Icons.info,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Partially Vaccinated',
                                style: GoogleFonts.poppins(
                                  color: kWhiteColor,
                                  textStyle:
                                      Theme.of(context).textTheme.headlineSmall,
                                  height: 0.8,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const Text(
                                'Completed 1st dose on 31/12/2021',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: const [
                    Text(
                      'Anthony Parker',
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      'anthonyparker@mail.com',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
