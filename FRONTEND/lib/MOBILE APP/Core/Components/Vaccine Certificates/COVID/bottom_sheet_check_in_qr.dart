import 'package:health_pulse/imports.dart';

import 'tiles_check_in_name.dart';
import 'tiles_check_out_custom.dart';
import 'tiles_check_out_time.dart';

// TODO: Pass in checkbox value with BLoC and update state
Future<dynamic> covidCheckInQrBottomSheet(BuildContext context) {
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
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Image(
              image: const AssetImage('asset/images/bottom_divider.png'),
              width: MediaQuery.of(context).size.width / 7,
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(top: 30, bottom: 10),
            child: Text(
              'Check-in with...',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w700,
                textStyle: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ),
          SizedBox(
            height: 230,
            child: ListView(
              children: const [
                CheckInNameListTile(name: 'Peter Parker'),
                CheckInNameListTile(name: 'John Parker'),
                CheckInNameListTile(name: 'Jennifer Parker'),
                CheckInNameListTile(name: 'Katie Parker'),
              ],
            ),
          ),
          Divider(
            thickness: 1,
            color: kDarkGreyColor.withOpacity(0.3),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(top: 15, bottom: 10),
            child: Text(
              'Check-out automatically after...',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w700,
                textStyle: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ),
          SizedBox(
            height: 190,
            child: ListView(
              children: const [
                CheckOutTimeListTile(timeText: '15 minutes'),
                CheckOutTimeListTile(timeText: '30 minutes'),
                CheckOutTimeListTile(timeText: '60 minutes'),
                CheckOutCustomListTile(text: 'Custom'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Card(
              elevation: 5,
              color: kPrimarySwatch,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: InkWell(
                onTap: () {
                  // TODO: Successfull check-in screen
                  Navigator.pop(context);
                },
                child: Center(
                  heightFactor: 1.4,
                  child: Text(
                    'Continue Check-In',
                    style: GoogleFonts.poppins(
                      color: kWhiteColor,
                      textStyle: Theme.of(context).textTheme.headline4,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
