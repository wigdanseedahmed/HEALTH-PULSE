import 'package:health_pulse/imports.dart';

Future<dynamic> covidToolsAndServicesBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
    context: context,
    builder: (context) => Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Image(
              image: const AssetImage('asset/images/bottom_divider.png'),
              width: MediaQuery.of(context).size.width / 7,
            ),
          ),
          const SizedBox(height: 30),
          ListView(
            shrinkWrap: true,
            children: const [
              ToolsAndServicesListTiles(
                text: 'Covid-19 Self Test',
                assetImage: kIconSelfTest,
              ),
              ToolsAndServicesListTiles(
                text: 'Covid-19 Vaccination',
                assetImage: kIconVaccine,
              ),
              ToolsAndServicesListTiles(
                text: 'Covid-19 Hotspots',
                assetImage: kIconHotspot,
              ),
              ToolsAndServicesListTiles(
                text: 'Health Facilities',
                assetImage: kIconHealthFacilities,
              ),
              ToolsAndServicesListTiles(
                text: 'Healthcare Support',
                assetImage: kIconHealthSupport,
              ),
              ToolsAndServicesListTiles(
                text: 'Manage Dependents',
                assetImage: kIconDependent,
              ),
              ToolsAndServicesListTiles(
                text: 'Covid-19 Risk Status',
                assetImage: kIconRiskStatus,
              ),
              ToolsAndServicesListTiles(
                text: 'Behavioural Risk',
                assetImage: kIconBehavior,
              ),
              ToolsAndServicesListTiles(
                text: 'Digital Healthcare',
                assetImage: kIconDigitalHealth,
              ),
              ToolsAndServicesListTiles(
                text: 'From Travelling',
                assetImage: kIconTravel,
              ),
              ToolsAndServicesListTiles(
                text: 'Additional Resources',
                assetImage: kIconResources,
              ),
              ToolsAndServicesListTiles(
                text: 'SOP Guideline',
                assetImage: kIconSOP,
              ),
              ToolsAndServicesListTiles(
                text: 'Helpdesk Centre',
                assetImage: kIconHelpdesk,
              ),
              ToolsAndServicesListTiles(
                text: 'Frequently Ask Question',
                assetImage: kIconFAQ,
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
