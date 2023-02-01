///----------------------------- 🌎 PROJECT IMPORTS -----------------------------///
import 'package:health_pulse/imports.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class NewsArticlesScreenMA extends StatefulWidget {
  const NewsArticlesScreenMA({Key? key}) : super(key: key);

  @override
  State<NewsArticlesScreenMA> createState() => _NewsArticlesScreenMAState();
}

class _NewsArticlesScreenMAState extends State<NewsArticlesScreenMA> with TickerProviderStateMixin {
  bool isLoading = false;

  /// VARIABLES USED TO FILTER SPECIALITIES
  late String? medicalSpecialityInitial = 'Physician';
  late String? medicalTopSpecialistInitial = 'Physician';

  /// VARIABLES USED TO DETERMINE SCREEN SIZE
  late ScrollController _scrollController;
  double _scrollPosition = 0;
  double _opacity = 0;

  _scrollListener() {
    setState(() {
      _scrollPosition = _scrollController.position.pixels;
    });
  }

  // late List<MapModel> _data;
  /// VARIABLES USED TO GET RESTful-API
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

  @override
  void initState() {
    readingResponseTopHeadlineNewsData();
    getUserInfo();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);

    selectedCategory = "All";

    _tabController = TabController(length: newsCategoriesList.length, vsync: this);
    _tabController.animateTo(0);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    ResponseTopHeadlinesNewsModel data = ResponseTopHeadlinesNewsModel();

    final postPageController = PageController(viewportFraction: 0.61);
    final latestNewsPageController = PageController(viewportFraction: 0.8);

    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(1.0),
      child: FutureBuilder<ResponseTopHeadlinesNewsModel?>(
        future: readingResponseTopHeadlineNewsData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return buildScaffold(
                readResponseTopHeadlineNewsContent,
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
    ResponseTopHeadlinesNewsModel? newsArticlesData,
    Size screenSize,
    BuildContext context,
  ) {
    return Scaffold(
      body: buildBody(
        newsArticlesData,
        screenSize,
        context,
      ),
      bottomNavigationBar: const CustomBottomNavBarMA(
        selectedMenu: MenuState.NewsScreen,
      ),
    );
  }

  ///--------------- BODY ---------------///
  buildBody(ResponseTopHeadlinesNewsModel? newsArticlesData, Size screenSize,
      BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        ///--- TOP BAR SECTION ---///
        buildTopBar(context),
        const SizedBox(height: 8.0),

        ///--- LATEST NEWS SECTION ---///
        Expanded(child: buildWidgetContentLatestNews(newsArticlesData, MediaQuery.of(context))),

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
          buildTopBarTabBar(context),
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
                text: 'News Today\n',

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
  late TabController _tabController = TabController(length: newsCategoriesList.length, vsync: this);

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
          tabs: List.generate(newsCategoriesList.length, (index) => Tab(
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

  Widget buildWidgetContentLatestNews(
      ResponseTopHeadlinesNewsModel? newsArticlesData, MediaQueryData mediaQuery) {
    List<ArticleModel?> filteredNewsArticlesData = newsArticlesData!.articles!;
    selectedCategory == "All" ? filteredNewsArticlesData = newsArticlesData.articles! : filteredNewsArticlesData = newsArticlesData.articles!.where((element) => element!.category!.contains(selectedCategory)).toList();

    return Padding(
      padding: const EdgeInsets.only(
        left: 16.0,
        top: 8.0,
        right: 16.0,
        // bottom: mediaQuery.padding.bottom + 8.0,
      ),
      child: ListView.separated(
        padding: EdgeInsets.zero,
        itemCount: filteredNewsArticlesData.length,
        separatorBuilder: (context, index) {
          return const Divider();
        },
        itemBuilder: (context, index) {
          ArticleModel itemArticle = filteredNewsArticlesData[index]!;
          if (index == 0) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Stack(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: itemArticle.urlToImage!,
                      height: 192.0,
                      width: mediaQuery.size.width,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Platform.isAndroid
                          ? const CircularProgressIndicator()
                          : const CupertinoActivityIndicator(),
                      errorWidget: (context, url, error) => Image.asset(
                        'assets/images/img_not_found.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (await canLaunch(itemArticle.url!)) {
                        await launch(itemArticle.url!);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Could not launch news'),
                        ));
                      }
                    },
                    child: Container(
                      width: mediaQuery.size.width,
                      height: 192.0,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(8.0),
                        ),
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withOpacity(0.8),
                            Colors.black.withOpacity(0.0),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: const [
                            0.0,
                            0.7,
                          ],
                        ),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 12.0,
                          top: 12.0,
                          right: 12.0,
                        ),
                        child: Text(
                          itemArticle.title!,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(
                          left: 12.0,
                          top: 4.0,
                          right: 12.0,
                        ),
                        child: Wrap(
                          children: <Widget>[
                            Icon(
                              Icons.launch,
                              color: Colors.white.withOpacity(0.8),
                              size: 12.0,
                            ),
                            const SizedBox(width: 4.0),
                            Text(
                              '${itemArticle.source!.name}',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.8),
                                fontSize: 11.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          } else {
            return GestureDetector(
              onTap: () async {
                if (await canLaunch(itemArticle.url!)) {
                  await launch(itemArticle.url!);
                }
              },
              child: Container(
                width: mediaQuery.size.width,

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
                    color: Colors.transparent,
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: SizedBox(
                        height: 150.0,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                itemArticle.title!,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  color: kDeepCove,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                "${DateFormat('E, dd MMMM yyyy').format(DateTime.parse(itemArticle.publishedDate!))} at ${DateFormat('kk:mm:ss').format(DateTime.parse(itemArticle.publishedDate!))}",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style:  const TextStyle(
                                  fontSize: 10.0,
                                  color: kShamrock,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                itemArticle.description!,
                                overflow: TextOverflow.fade,
                                maxLines: 3,
                                style: const TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: <Widget>[
                                  const Icon(
                                    Icons.launch,
                                    size: 12.0,
                                    color: kShamrock,
                                  ),
                                  const SizedBox(width: 4.0),
                                  Text(
                                    itemArticle.source!.name!,
                                    style: const TextStyle(
                                      color: kShamrock,
                                      fontSize: 12.0,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: ClipRRect(
                        /*child: Image.network(
                            itemArticle.urlToImage ??
                                'http://api.bengkelrobot.net:8001/assets/images/img_not_found.jpg',
                            width: 72.0,
                            height: 72.0,
                            fit: BoxFit.cover,
                          ),*/
                        borderRadius: const BorderRadius.all(
                          Radius.circular(4.0),
                        ),
                        /*child: Image.network(
                            itemArticle.urlToImage ??
                                'http://api.bengkelrobot.net:8001/assets/images/img_not_found.jpg',
                            width: 72.0,
                            height: 72.0,
                            fit: BoxFit.cover,
                          ),*/
                        child: CachedNetworkImage(
                          imageUrl: itemArticle.urlToImage!,
                          imageBuilder: (context, imageProvider) {
                            return Container(
                              width: 82.0,
                              height: 150.0,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                          placeholder: (context, url) => Container(
                            width: 82.0,
                            height: 120.0,
                            child: Center(
                              child: Platform.isAndroid
                                  ? const CircularProgressIndicator()
                                  : const CupertinoActivityIndicator(),
                            ),
                          ),
                          errorWidget: (context, url, error) => Image.asset(
                            'assets/images/img_not_found.jpg',
                            fit: BoxFit.cover,
                            width: 82.0,
                            height: 120.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

}
