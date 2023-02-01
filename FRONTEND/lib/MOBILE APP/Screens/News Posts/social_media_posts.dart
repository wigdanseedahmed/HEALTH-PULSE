///----------------------------- 🌎 PROJECT IMPORTS -----------------------------///
import 'package:health_pulse/imports.dart';
import 'package:flutter/cupertino.dart';
import 'package:unicons/unicons.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:http/http.dart' as http;

class SocialMediaPostsScreenMA extends StatefulWidget {
  const SocialMediaPostsScreenMA({Key? key}) : super(key: key);

  @override
  State<SocialMediaPostsScreenMA> createState() =>
      _SocialMediaPostsScreenMAState();
}

class _SocialMediaPostsScreenMAState extends State<SocialMediaPostsScreenMA>
    with TickerProviderStateMixin {
  bool isLoading = false;

  ///--------------- VARIABLES USED TO FILTER SPECIALITIES ---------------///
  late String? medicalSpecialityInitial = 'Physician';
  late String? medicalTopSpecialistInitial = 'Physician';

  ///--------------- VARIABLES USED TO DETERMINE SCREEN SIZE ---------------///
  late ScrollController _scrollController;
  double _scrollPosition = 0;
  double _opacity = 0;

  _scrollListener() {
    setState(() {
      _scrollPosition = _scrollController.position.pixels;
    });
  }

  // late List<MapModel> _data;
  ///--------------- USER DATA ---------------///
  NetworkHandler networkHandler = NetworkHandler();

  getUserInfo() async {
    UserProfile.email =
        await CheckSharedPreferences.getUserEmailSharedPreference();
    UserProfile.email =
        await CheckSharedPreferences.getUserEmailSharedPreference();
    var userInfo = await networkHandler
        .get("${AppUrl.getUserUsingEmail}${UserProfile.email}");

    //print(userInfo);
    setState(() {
      UserProfile.firstName = userInfo['data']['firstName'];
      UserProfile.userPhotoName = userInfo['data']["userPhotoName"];
      UserProfile.userPhotoURL = userInfo['data']["userPhotoURL"];
      UserProfile.userPhotoFile = userInfo['data']["userPhotoFile"];
    });
  }

  ///--------------- SOCIAL MEDIA POSTS DATA ---------------///
  List<SocialMediaNewsPostsModel>? readSocialMediaNewsPostsContent =
      <SocialMediaNewsPostsModel>[];

  Future<List<SocialMediaNewsPostsModel>?> readingSocialMediaPostsData() async {
    /// String to URI, using the same url used in the nodejs code
    var uri = Uri.parse(AppUrl.getSocialMediaPosts);

    /// Create Request to get data and response to read data
    final response = await http.get(
      uri,
      headers: {
        //"Accept": "application/json",
        "Access-Control-Allow-Origin": "*",
        // Required for CORS support to work
        //"Access-Control-Allow-Credentials": 'true', // Required for cookies, authorization headers with HTTPS
        "Access-Control-Allow-Headers":
            "Content-Type, Access-Control-Allow-Origin, Accept",
        "Access-Control-Allow-Methods": "POST, DELETE, GET, PUT"
      },
    );
    //print('Response status: ${response.statusCode}');
    //print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      readSocialMediaNewsPostsContent =
          socialMediaNewsPostsModelFromJson(response.body);
      // print("Read Physician Json File Content: $readResponseTopHeadlineNewsContent");

      return readSocialMediaNewsPostsContent;
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  @override
  void initState() {
    readingSocialMediaPostsData();
    getUserInfo();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);

    selectedCategory = "All";

    _tabController =
        TabController(length: newsCategoriesList.length, vsync: this);
    _tabController.animateTo(0);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    final postPageController = PageController(viewportFraction: 0.61);
    final latestNewsPageController = PageController(viewportFraction: 0.8);

    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(1.0),
      child: FutureBuilder(
        future: readingSocialMediaPostsData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return buildScaffold(
                readSocialMediaNewsPostsContent,
                screenSize,
                context,
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
          }

          return const CircularProgressIndicator();
        },
      ),
    );
  }

  ///--------------- SCAFFOLD ---------------///
  buildScaffold(
    List<SocialMediaNewsPostsModel>? socialMediaNewsPostsData,
    Size screenSize,
    BuildContext context,
  ) {
    return Scaffold(
      body: buildBody(
        socialMediaNewsPostsData,
        screenSize,
        context,
      ),
      bottomNavigationBar: const CustomBottomNavBarMA(
        selectedMenu: MenuState.NewsScreen,
      ),
    );
  }

  ///--------------- BODY ---------------///
  buildBody(List<SocialMediaNewsPostsModel>? socialMediaNewsPostsData,
      Size screenSize, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        ///--- TOP BAR SECTION ---///
        buildTopBar(context),
        const SizedBox(height: 8.0),

        ///--- SOCIAL MEDIA POSTS SECTION ---///
        Expanded(
            child: buildSocialMediaPosts(
                socialMediaNewsPostsData, MediaQuery.of(context))),
      ],
    );
  }

  ///--------------- TOP BAR ---------------///

  buildTopBar(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFF1F5F9),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
        ),
      ),
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
        bottom: 6.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              buildTopBarTitle(),
            ],
          ),
          // const SizedBox(height: 6.0),
          /// buildTopBarTabBar(context),
          // SizedBox(height: 8.0),
          // buildWidgetSearch(),
          // const SizedBox(height: 12.0),
        ],
      ),
    );
  }

  buildTopBarTitle() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: RichText(
          // textAlign: TextAlign.right,
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Social Posts Today\n',
                style: //Theme.of(context).textTheme.titleMedium!.merge
                    GoogleFonts.playfairDisplay(
                  fontSize: 45.6,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF325384),
                ),
              ),
              TextSpan(
                text: getStrToday(),
                style: //Theme.of(context).textTheme.caption!.merge(
                    GoogleFonts.playfairDisplay(
                  color: const Color(0xFF325384).withOpacity(0.8),
                  fontSize: 20.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String selectedCategory = "All";
  late TabController _tabController =
      TabController(length: newsCategoriesList.length, vsync: this);

  Widget buildTopBarTabBar(BuildContext context) {
    return Container(
      height: 30,
      margin: const EdgeInsets.only(left: 14.4, top: 18.8),
      child: DefaultTabController(
        length: newsCategoriesList.length,
        child: TabBar(
          controller: _tabController,
          enableFeedback: true,
          labelPadding: const EdgeInsets.only(left: 14.4, right: 14.4),
          indicatorPadding: const EdgeInsets.only(left: 14.4, right: 14.4),
          isScrollable: true,
          labelColor: const Color(0XFF000000),
          unselectedLabelColor: const Color(0XFF8A8A8A),
          labelStyle: GoogleFonts.lato(
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
          unselectedLabelStyle: GoogleFonts.lato(
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
          indicator: RoundedRectangleTabIndicator(
            colour: const Color(0xFF000000),
            weight: 2.4,
            width: 14.4,
          ),
          onTap: (int index) {
            setState(() {
              selectedCategory = newsCategoriesList[index];
            });
            // print('Tab $index is tapped');
          },
          tabs: List.generate(
            newsCategoriesList.length,
            (index) => Tab(
              child: Text(
                newsCategoriesList[index],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSearch() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        padding: const EdgeInsets.only(
          left: 12.0,
          top: 8.0,
          right: 12.0,
          bottom: 16.0,
        ),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          color: Colors.white,
        ),
        child: Row(
          children: const <Widget>[
            Expanded(
              child: Text(
                'What are you looking for?',
                style: TextStyle(
                  color: Colors.black26,
                ),
              ),
            ),
            Icon(
              Icons.search,
              size: 16.0,
              color: Colors.black26,
            ),
          ],
        ),
      ),
    );
  }

  String getStrToday() {
    var today = DateFormat().add_yMMMMd().format(DateTime.now());
    var strDay = today.split(" ")[1].replaceFirst(',', '');
    if (strDay == '1') {
      strDay = "${strDay}st";
    } else if (strDay == '2') {
      strDay = "${strDay}nd";
    } else if (strDay == '3') {
      strDay = "${strDay}rd";
    } else {
      strDay = "${strDay}th";
    }
    var strMonth = today.split(" ")[0];
    var strYear = today.split(" ")[2];
    return "$strDay $strMonth $strYear";
  }

  ///--------------- LATEST NEWS ---------------///

  Widget buildSocialMediaPosts(
      List<SocialMediaNewsPostsModel>? socialMediaNewsPostsData,
      MediaQueryData mediaQuery) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16.0,
        top: 8.0,
        right: 16.0,
        // bottom: mediaQuery.padding.bottom + 8.0,
      ),
      child: ListView.separated(
          itemBuilder: (context, index) {
            return Card(
              elevation: 0,
              color: Theme.of(context).cardColor,
              margin: const EdgeInsets.all(16),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      contentPadding: const EdgeInsets.all(0),
                      leading:
                          socialMediaNewsPostsData![index].userProfilePicture ==
                                  null
                              ? Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.transparent,
                                      width: 1,
                                    ),
                                    borderRadius: const BorderRadius.all(
                                      Radius.elliptical(30, 30),
                                    ),
                                  ),
                                  child: Text(
                                      '${socialMediaNewsPostsData[index].userFirstName![0]}${socialMediaNewsPostsData[index].userLastName![0]}'),
                                )
                              : CircleAvatar(
                                  radius: 30,
                                  backgroundImage: NetworkImage(
                                      socialMediaNewsPostsData[index]
                                          .userProfilePicture!),
                                ),
                      title: Text(
                        socialMediaNewsPostsData[index].username!,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      subtitle: Text(
                        timeago.format(
                            DateTime.parse(
                                socialMediaNewsPostsData[index].dateCreated!),
                            allowFromNow: true),
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              color: Colors.grey,
                            ),
                      ),
                     /* trailing: IconButton(
                        onPressed: null,
                        icon: Icon(
                          Icons.more_horiz,
                          color: Theme.of(context).iconTheme.color,
                        ),
                      ),*/
                    ),
                    socialMediaNewsPostsData[index].postText == null
                        ? Container()
                        : Padding(
                            padding:
                                const EdgeInsets.only(top: 3.0, bottom: 3.0),
                            child: Text(
                              socialMediaNewsPostsData[index].postText!,
                              textAlign: TextAlign.left,
                            ),
                          ),
                    socialMediaNewsPostsData[index].postImageUrl == null
                        ? Container()
                        : Padding(
                            padding:
                                const EdgeInsets.only(top: 3.0, bottom: 3.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                socialMediaNewsPostsData[index].postImageUrl!,
                                height: 200,
                                width: MediaQuery.of(context).size.width,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              onPressed: null,
                              icon: Icon(UniconsLine.favorite,
                                  color: Theme.of(context).iconTheme.color),
                            ),
                            /*
                            IconButton(
                                onPressed: null,
                                icon: Icon(UniconsLine.thumbs_up,
                                    color: Theme.of(context).iconTheme.color)
                                    ,),
                            IconButton(
                                onPressed: null,
                                icon: Icon(UniconsLine.comment_lines,
                                    color: Theme.of(context).iconTheme.color)
                                    ,)*/
                          ],
                        ),
                        IconButton(
                            onPressed: null,
                            icon: Icon(
                              UniconsLine.telegram_alt,
                              color: Theme.of(context).iconTheme.color,
                            ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (context, index) => const Divider(),
          itemCount: socialMediaNewsPostsData == null
              ? 0
              : socialMediaNewsPostsData.length),
    );
  }
}
