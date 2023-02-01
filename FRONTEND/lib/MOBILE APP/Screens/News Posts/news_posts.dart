import 'dart:ui';

///----------------------------- 🌎 PROJECT IMPORTS -----------------------------///
import 'package:health_pulse/imports.dart';
import 'package:unicons/unicons.dart';
import 'package:http/http.dart' as http;

class NewsPostScreenMA extends StatefulWidget {
  const NewsPostScreenMA({super.key});

  @override
  State<NewsPostScreenMA> createState() => _NewsPostScreenMAState();
}

class _NewsPostScreenMAState extends State<NewsPostScreenMA>
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
      UserProfile.userPhotoFile = userInfo['data']["userPhotoFile"];
    });
  }

  ///--------------- NEWS ARTICLES DATA ---------------///
  ResponseTopHeadlinesNewsModel readResponseTopHeadlineNewsContent =
      ResponseTopHeadlinesNewsModel();

  Future<ResponseTopHeadlinesNewsModel>
      readingResponseTopHeadlineNewsData() async {
    /// String to URI, using the same url used in the nodejs code
    var uri = Uri.parse(AppUrl.responseTopHeadlineNewsBaseURL);

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
      readResponseTopHeadlineNewsContent =
          responseTopHeadlinesNewsFromJson(response.body)[0];
      // print("Read Physician Json File Content: $readResponseTopHeadlineNewsContent");

      return readResponseTopHeadlineNewsContent;
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
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
    readingResponseTopHeadlineNewsData();
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
    var strToday = getStrToday();
    var mediaQuery = MediaQuery.of(context);
    ResponseTopHeadlinesNewsModel data = ResponseTopHeadlinesNewsModel();

    final postPageController = PageController(viewportFraction: 0.61);
    final latestNewsPageController = PageController(viewportFraction: 0.85);

    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(1.0),
      child: FutureBuilder<ResponseTopHeadlinesNewsModel?>(
        future: readingResponseTopHeadlineNewsData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return FutureBuilder<List<SocialMediaNewsPostsModel>?>(
                future: readingSocialMediaPostsData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      return buildScaffold(
                          readResponseTopHeadlineNewsContent,
                          readSocialMediaNewsPostsContent,
                          mediaQuery,
                          strToday,
                          context,
                          postPageController,
                          latestNewsPageController);
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }
                  }

                  return const CircularProgressIndicator();
                },
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
      ResponseTopHeadlinesNewsModel? newsArticlesData,
      List<SocialMediaNewsPostsModel>? socialMediaNewsPostsData,
      MediaQueryData mediaQuery,
      String strToday,
      BuildContext context,
      PageController postPageController,
      PageController latestNewsPageController) {
    return Scaffold(
      body: buildBody(newsArticlesData, socialMediaNewsPostsData, mediaQuery,
          strToday, context, postPageController, latestNewsPageController),
      bottomNavigationBar: const CustomBottomNavBarMA(
        selectedMenu: MenuState.NewsScreen,
      ),
    );
  }

  ///--------------- BODY ---------------///
  buildBody(
      ResponseTopHeadlinesNewsModel? newsArticlesData,
      List<SocialMediaNewsPostsModel>? socialMediaNewsPostsData,
      MediaQueryData mediaQuery,
      String strToday,
      BuildContext context,
      PageController postPageController,
      PageController latestNewsPageController) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ///--- TOP BAR SECTION ---///
        buildTopBar(mediaQuery, strToday, context),
        const SizedBox(height: 8.0),

        ///--- SOCIAL POSTS SECTION ---///
        buildSocialMediaPosts(
            context, postPageController, socialMediaNewsPostsData),
        const SizedBox(height: 8.0),

        ///--- LATEST NEWS SECTION ---///
        buildLatestNews(context, latestNewsPageController, newsArticlesData),
      ],
    );
  }

  ///--------------- TOP BAR ---------------///

  buildTopBar(
      MediaQueryData mediaQuery, String strToday, BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFF1F5F9),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
        ),
      ),
      padding: EdgeInsets.only(
        top: mediaQuery.padding.top,
        bottom: 16.0,
      ),
      child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              buildTopBarTitle(strToday),
            ],
          ),
          // const SizedBox(height: 6.0),
          // buildTopBarTabBar(context),
          // SizedBox(height: 8.0),
          // buildWidgetSearch(),
          // const SizedBox(height: 12.0),
        ],
      ),
    );
  }

  buildTopBarTitle(String strToday) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'News Today\n',
                style: //Theme.of(context).textTheme.titleMedium!.merge
                    GoogleFonts.playfairDisplay(
                  fontSize: 45.6,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF325384),
                ),
              ),
              TextSpan(
                text: strToday,
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
          bottom: 8.0,
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

  ///--------------- SOCIAL MEDIA POSTS ---------------///

  Widget buildSocialMediaPosts(
    BuildContext context,
    PageController pageController,
    List<SocialMediaNewsPostsModel>? socialMediaNewsPostsData,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 280, // 218.4,
          color: Colors.transparent,
          margin: const EdgeInsets.only(top: 16),
          child: socialMediaNewsPostsData == null
              ? Container()
              : PageView(
                  physics: const BouncingScrollPhysics(),
                  controller: pageController,
                  scrollDirection: Axis.horizontal,
                  children: List.generate(11, (index) {
                    if (index == 10) {
                      return Container(
                        margin: const EdgeInsets.only(right: 10),
                        width: 150,
                        height: 260,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                          ),
                          color: Colors.transparent,
                          border: Border.all(
                            color: Colors.transparent,
                          ),
                        ),
                        child: Center(
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const SocialMediaPostsScreenMA()),
                              );
                            },
                            child: Text(
                              "Show All ",
                              style: GoogleFonts.lato(
                                fontSize: 16.8,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF8A8A8A),
                              ),
                            ),
                          ),
                        ),
                      );
                    } else {
                      return buildSocialMediaPostsContainer(
                          context, socialMediaNewsPostsData[index]);
                    }
                  }),
                ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 28.8, top: 28.8),
          child: SmoothPageIndicator(
            controller: pageController,
            count: 11,
            effect: const ExpandingDotsEffect(
              activeDotColor: Color(0xFF8A8A8A),
              dotColor: Color(0xFFABABAB),
              dotHeight: 4.8,
              dotWidth: 6,
              spacing: 4.8,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildSocialMediaPostsContainer(BuildContext context,
      SocialMediaNewsPostsModel socialMediaNewsPostsData) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      width: 248,
      height: socialMediaNewsPostsData.postImageUrl == null ||
              socialMediaNewsPostsData.postImageUrl!.isEmpty
          ? 116
          : socialMediaNewsPostsData.postText == null ||
                  socialMediaNewsPostsData.postText!.isEmpty
              ? 190
              : 260,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
          bottomLeft: Radius.circular(8),
          bottomRight: Radius.circular(8),
        ),
        color: DynamicTheme.of(context)?.brightness == Brightness.light
            ? Colors.white
            : Colors.white30,
        border: Border.all(
          color: DynamicTheme.of(context)?.brightness == Brightness.light
              ? const Color.fromRGBO(250, 250, 250, 1)
              : const Color.fromRGBO(48, 48, 48, 1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          socialMediaNewsPostsData.postImageUrl == null
              ? Container(
                  width: 248,
                  height: 144,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(7),
                      topRight: Radius.circular(7),
                    ),
                    color:
                        DynamicTheme.of(context)?.brightness == Brightness.light
                            ? const Color.fromRGBO(250, 250, 250, 1)
                            : const Color.fromRGBO(48, 48, 48, 1),
                    border: Border.all(
                      color: DynamicTheme.of(context)?.brightness == Brightness.light
                          ? const Color.fromRGBO(250, 250, 250, 1)
                          : const Color.fromRGBO(48, 48, 48, 1),
                    ),
                  ),
                )
              : Container(
                  width: 248,
                  height: 144,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                    border: Border.all(
                      color: Colors.transparent,
                    ),
                    image: DecorationImage(
                        image: NetworkImage(
                            socialMediaNewsPostsData.postImageUrl!),
                        fit: BoxFit.fitWidth),
                  ),
                ),
          socialMediaNewsPostsData.postText == null
              ? Container()
              : Container(
                  padding:
                      const EdgeInsets.only(top: 12.0, left: 12.0, right: 12.0),
                  width: 210,
                  height: 70,
                  child: Text(
                    socialMediaNewsPostsData.postText!,
                    textAlign: TextAlign.left,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      // color: Color.fromRGBO(9, 19, 60, 1),
                      fontFamily: 'Inter',
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      height: 1,
                    ),
                  ),
                ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    socialMediaNewsPostsData.userProfilePicture == null
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
                                '${socialMediaNewsPostsData.userFirstName![0]}${socialMediaNewsPostsData.userLastName![0]}'),
                          )
                        : Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.transparent,
                                width: 1,
                              ),
                              image: DecorationImage(
                                  image: NetworkImage(socialMediaNewsPostsData
                                      .userProfilePicture!),
                                  fit: BoxFit.cover),
                              borderRadius: const BorderRadius.all(
                                Radius.elliptical(30, 30),
                              ),
                            ),
                          ),

                    const SizedBox(width: 5.0),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Column(
                        children: [
                          Text(
                            '${socialMediaNewsPostsData.userFirstName} ${socialMediaNewsPostsData.userLastName}',
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                                // color: Color.fromRGBO(9, 19, 60, 1),
                                fontFamily: 'Inter',
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                height: 1),
                          ),
                          Text(
                            DateFormat().add_yMMMMd().format(DateTime.parse(
                                socialMediaNewsPostsData.dateCreated!)),
                            // '15 Jun 2018',
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                                color: Color.fromRGBO(195, 200, 223, 1),
                                fontFamily: 'Inter',
                                fontSize: 11,
                                fontWeight: FontWeight.normal,
                                height: 1),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    SizedBox(
                      width: 14,
                      height: 16,
                      child: Icon(UniconsLine.favorite),
                    ),
                    SizedBox(width: 14),
                    SizedBox(
                      width: 16.782285690307617,
                      height: 15.498687744140625,
                      child: Icon(UniconsLine.telegram_alt),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ///--------------- LATEST NEWS ---------------///

  Widget buildLatestNewsTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Latest News',
            style: GoogleFonts.playfairDisplay(
              fontSize: 28.0,
              fontWeight: FontWeight.w700,
              // color: const Color(0xFF000000),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const NewsArticlesScreenMA()),
              );
            },
            child: Text(
              "Show All ",
              style: GoogleFonts.lato(
                fontSize: 16.8,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF8A8A8A),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildLatestNewsSubtitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Text(
        'Top stories at the moment',
        textAlign: TextAlign.start,
        style: Theme.of(context).textTheme.caption!.merge(
              TextStyle(
                color: const Color(0xFF325384).withOpacity(0.5),
              ),
            ),
      ),
    );
  }

  Widget buildLatestNews(
      BuildContext context,
      PageController latestNewsPageController,
      ResponseTopHeadlinesNewsModel? newsArticlesData) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildLatestNewsTitle(context),
        buildLatestNewsSubtitle(context),
        const SizedBox(height: 16.0),
        newsArticlesData!.articles == null
            ? Container()
            : Container(
                height: 120,
                margin: const EdgeInsets.only(top: 16.0),
                child: PageView(
                  physics: const BouncingScrollPhysics(),
                  controller: latestNewsPageController,
                  scrollDirection: Axis.horizontal,
                  children: List.generate(
                    newsArticlesData.articles!.length,
                    (index) => Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: buildLatestNewsContainer(
                          context, newsArticlesData.articles![index]),
                    ),
                  ),
                ),
              ),
      ],
    );
  }

  Widget buildLatestNewsContainer(BuildContext context, ArticleModel? article) {
    return Container(
      width: 300,
      height: 111,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
          bottomLeft: Radius.circular(8),
          bottomRight: Radius.circular(8),
        ),
        color: DynamicTheme.of(context)?.brightness == Brightness.light
            ? Colors.white
            : Colors.white30,
        border: Border.all(color: Colors.transparent),
      ),
      child: Stack(
        children: <Widget>[
          Container(
            width: 113,
            height: 120,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(0),
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(8),
              ),
              border: Border.all(color: Colors.transparent),
              image: DecorationImage(
                  image: NetworkImage(article!.urlToImage!),
                  fit: BoxFit.cover),
            ),
          ),
          Positioned(
            top: 42,
            left: 125,
            child: SizedBox(
              width: 180,
              height: 90,
              child: Text(
                article.description!,
                textAlign: TextAlign.left,
                maxLines: 4,
                style: const TextStyle(
                    color: Color.fromRGBO(9, 19, 60, 1),
                    fontFamily: 'Inter',
                    fontSize: 12,
                    letterSpacing:
                        0 /*percentages not used in flutter. defaulting to zero*/,
                    fontWeight: FontWeight.normal,
                    height: 1),
              ),
            ),
          ),
          Positioned(
            top: 8,
            left: 125,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: SizedBox(
                width: 180,
                height: 90,
                child: Text(
                  article.title!.toUpperCase(),
                  textAlign: TextAlign.left,
                  maxLines: 2,
                  style: const TextStyle(
                    color: Color.fromRGBO(195, 201, 223, 1),
                    fontFamily: 'Inter',
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: 10,
            bottom: 10,
            child: Text(
              article.publishedDate!,
              textAlign: TextAlign.left,
              style: const TextStyle(
                  color: Color.fromRGBO(195, 201, 223, 1),
                  fontFamily: 'Inter',
                  fontSize: 10,
                  fontWeight: FontWeight.normal,
                  height: 1),
            ),
          ),
        ],
      ),
    );
  }
}

///------------------- NEWS CATEGORY SELECTION INDICATOR -------------------///
class RoundedRectangleTabIndicator extends Decoration {
  final BoxPainter _painter;

  RoundedRectangleTabIndicator({
    required Color colour,
    required double weight,
    required double width,
  }) : _painter = _RRectanglePainterColor(colour, width, weight);

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) => _painter;
}

class _RRectanglePainterColor extends BoxPainter {
  final Paint _painter;
  final double weight;
  final double width;

  _RRectanglePainterColor(Color color, this.width, this.weight)
      : _painter = Paint()
          ..color = color
          ..isAntiAlias = true;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final Offset customOffset = offset +
        Offset(configuration.size!.width / 2 - (width * 0.5),
            configuration.size!.height - weight);

    Rect myRect = customOffset & Size(width, weight);

    RRect myRRect = RRect.fromRectXY(myRect, weight, weight);

    canvas.drawRRect(myRRect, _painter);
  }
}
