///----------------------------- 🌎 PROJECT IMPORTS -----------------------------///
import 'package:health_pulse/imports.dart';

class HealthPulseDrawer extends StatelessWidget {
  const HealthPulseDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        shrinkWrap: true,
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          buildDrawerHeader(),
          buildDrawerBody(),
        ],
      ),
    );
  }
  ///------------------ HEADER ------------------///
  buildDrawerHeader() {
    return Container(
          height: 170.0,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: const Alignment(-1.0, 0.0),
              end: const Alignment(1.0, 0.0),
              colors: linearGradientColourScheme,
            ),
          ),
          child: DrawerHeader(
            child: Row(
              children: [
                buildUserProfilePicture(),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                        alignment: FractionalOffset.centerLeft,
                        child: UserProfile.firstName != null
                            ? Text(
                          'Welcome back, ${UserProfile.firstName!}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Color(0xFFFFFFFF),
                          ),
                        )
                            : const Text(
                          'Welcome back',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Color(0xFFFFFFFF),
                          ),
                        ),
                      ),
                      const Align(
                        alignment: FractionalOffset.centerLeft,
                        child: Text(
                          'How can we help you today?',
                          style: TextStyle(
                            fontSize: 15,
                            color: Color(0xAAFFFFFFF),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
  }

  buildUserProfilePicture() {
    return Container(
                  margin: const EdgeInsets.only(
                    right: 15.0,
                  ),
                  width: 50.0,
                  height: 50.0,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: const CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage("assets/images/user_profile.png"),
                  ),
                  // child: ClipOval(
                  //   child: UserProfile.userImagePath != null
                  //       ? CachedNetworkImage(
                  //     imageUrl: UserProfile.userImagePath,
                  //     imageBuilder: (context, imageProvider) =>
                  //         Container(
                  //           decoration: BoxDecoration(
                  //             image: DecorationImage(
                  //               image: imageProvider,
                  //               fit: BoxFit.cover,
                  //             ),
                  //           ),
                  //         ),
                  //     placeholder: (context, url) =>
                  //         CircularProgressIndicator(),
                  //     errorWidget: (context, url, error) =>
                  //         Image.asset('assets/images/user.jpg'),
                  //   )
                  //       : (Container()),
                  // ),
                );
  }

  ///------------------ BODY ------------------///
  buildDrawerBody() {
    return Column(
      children: [
        ListTile(
          leading: const Icon(EvaIcons.home),
          title: const Text('Home'),
          onTap: () {
            /*Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => MyApp()),
                  );*/
          },
        ),
        ListTile(
          leading: const Icon(Icons.favorite_border),
          title: const Text('My Health'),
          onTap: () {
            /*Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            MyHealthPage(UserProfile.userFirstName)),
                  );*/
          },
        ),
        ListTile(
          leading: const Icon(Icons.star),
          title: const Text('Top Doctors'),
          onTap: () {
            /*Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CreateProfilePage()),
                  );*/
          },
        ),
        ListTile(
          leading: const Icon(Icons.groups_outlined),
          title: const Text('All Doctors'),
          onTap: () {
            /*Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SearchPage()),
                  );*/
          },
        ),
        const ExpansionTile(
          leading: Icon(Icons.mood),
          title: Text("Browse by Specialty"),
          children: <Widget>[
            //specialtyList(),
          ],
        ),
        ListTile(
          leading: const Icon(Icons.search),
          title: const Text('Doctor Lookup'),
          onTap: () {
            /*Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SearchPage()),
                  );*/
          },
        ),
        ListTile(
          leading: const Icon(Icons.web),
          title: const Text('Visit my Website'),
          onTap: (){},//launchURL('https://johnuberbacher.com'),
        ),
        ListTile(
          leading: const Icon(Icons.exit_to_app),
          title: const Text('Logout'),
          onTap: () {
            /*authMethods.signOut();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => Authenticate()));*/
          },
        ),
      ],
    );
  }

}