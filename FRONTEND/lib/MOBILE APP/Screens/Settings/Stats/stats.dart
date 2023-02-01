///----------------------------- 🌎 PROJECT IMPORTS -----------------------------///
import 'package:health_pulse/imports.dart';

class StatsMA extends StatelessWidget {
  const StatsMA({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: buildAppBar(context),
        body: buildBody(),
        // bottomNavigationBar: buildBottomNavigationBar(),
      ),
    );
  }

  ///------------------ APP BAR ------------------///
  buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: DynamicTheme.of(context)?.brightness == Brightness.light
          ? Colors.white
          : Colors.white12,
      elevation: 0,
      centerTitle: true,
      leading: Padding(
        padding: const EdgeInsets.only(left: 8.0, bottom: 16.0),
        child: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 40,
            color: Color(0xff4B4B87),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SettingsScreenMA(),
              ),
            );
          },
        ),
      ),
      title: const Text(
        "STATS",
        style: TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.bold,
          color: Color(0xff4B4B87),
        ),
      ),
    );
  }

  ///------------------ BODY ------------------///
  buildBody() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: const Color(0xff4B4B87).withOpacity(.2),
            ),
            child: TabBar(
              unselectedLabelColor: const Color(0xff4B4B87),
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color(0xff4B4B87)),
              tabs: const [
                Tab(text: "Day"),
                Tab(text: "Week"),
                Tab(text: "Month"),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              children: [
                buildGridCard(
                  title: "Heart Rate",
                  color: const Color(0xffFF6968),
                  icon: 'icons/heart-rate.svg',
                  dis: '80 - 20\nhealthy',
                  label1: '120 ',
                  label2: 'bpm',
                  ancColor: Colors.red.shade200,
                ),
                buildGridCard(
                  title: "Sleep",
                  color: const Color(0xff7A54FF),
                  icon: 'icons/sleep.svg',
                  dis: '80 - 20\nhealthy',
                  label1: '8 h ',
                  label2: '42 m',
                  ancColor: const Color(0xffBFADFF),
                ),
                buildGridCard(
                  title: "Energy Burn",
                  color: const Color(0xffFF8F61),
                  icon: 'icons/heart-rate.svg',
                  dis: '80 - 20\nhealthy',
                  label1: '582 ',
                  label2: 'kacl',
                  ancColor: const Color(0xffFFC5AD),
                ),
                buildGridCard(
                  title: "Steps",
                  color: const Color(0xff2AC3FF),
                  icon: 'icons/steps.svg',
                  dis: 'Dialy Gola\n25,000',
                  label1: '16741',
                  label2: '',
                  ancColor: const Color(0xffADE8FF),
                ),
                buildGridCard(
                  title: "Running",
                  color: const Color(0xff2AC3FF),
                  icon: 'icons/running.svg',
                  dis: 'Dialy Goal\n10km',
                  label1: '5,3',
                  label2: 'km',
                  ancColor: const Color(0xffADE8FF),
                ),
                buildGridCard(
                  title: "Cycling",
                  color: const Color(0xff96DA45),
                  icon: 'icons/cycling.svg',
                  dis: 'Dialy Gola\n20km',
                  label1: '25 km',
                  label2: '',
                  ancColor: const Color(0xffD8F2BB),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  ///------------------ BOTTOM SCREEN ------------------///
  buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: 1,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      unselectedItemColor: const Color(0xffA3A3CC),
      unselectedIconTheme: const IconThemeData(color: Color(0xffA3A3CC)),
      selectedItemColor: const Color(0xff6161A8),
      selectedIconTheme: const IconThemeData(
        color: Color(0xff484884),
      ),
      selectedLabelStyle: const TextStyle(
        color: Color(0xff6161A8),
      ),
      items: [
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            "icons/profile.svg",
            height: 30,
            width: 30,
            color: const Color(0xff8989BE),
          ),
          label: 'Profile',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            "icons/stats.svg",
            height: 30,
            width: 30,
            color: const Color(0xff8989BE),
          ),
          label: 'Stats',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            "icons/reward.svg",
            height: 30,
            width: 30,
            color: const Color(0xff8989BE),
          ),
          label: 'rewards',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            "icons/goal.svg",
            height: 30,
            width: 30,
            color: const Color(0xff8989BE),
          ),
          label: 'goal',
        ),
      ],
    );
  }

  ///------------------ GRID CARDS ------------------///
  Widget buildGridCard({
    String? title,
    String? icon,
    String? label1,
    String? label2,
    String? dis,
    Color? ancColor,
    Color? color,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(13),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title!,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: Colors.white60,
                  ),
                ),
                const SizedBox(height: 25),
                Row(
                  children: [
                    Text(
                      label1!,
                      style: const TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      label2!,
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      dis!,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white54,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Positioned(
            top: -8,
            right: -2,
            child: CircleAvatar(
              radius: 32,
              backgroundColor: ancColor,
              child: SvgPicture.asset(
                icon!,
                height: 30,
                width: 30,
                color: Colors.white54,
              ),
            ),
          )
        ],
      ),
    );
  }
}
