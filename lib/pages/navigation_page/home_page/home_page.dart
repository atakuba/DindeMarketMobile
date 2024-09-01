import 'package:dinde_market/models/mock_data/mock_data.dart';
import 'package:dinde_market/utility/utilities.dart';
import 'package:dinde_market/widgets/category_card.dart';
import 'package:dinde_market/widgets/serach_bar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<NavigatorState> homePageNavigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Navigator(
        key: homePageNavigatorKey,
        onGenerateRoute: (RouteSettings settings) {
          // Define your routes here
          WidgetBuilder builder;
          switch (settings.name) {
            // case '/':
            //   builder = (BuildContext context) => _buildHomePageContent(context);
            //   break;
            // Add more routes here if needed
            default:
              builder = (BuildContext context) => _buildHomePageContent(context);
          }
          return MaterialPageRoute(builder: builder);
        },
      ),
    );
  }

  Widget _buildHomePageContent(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 155,
          child: Container(
            padding: EdgeInsets.only(
              left: Utilities.setWidgetWidthByPercentage(context, 13.9),
              right: Utilities.setWidgetWidthByPercentage(context, 13.9),
              top: Utilities.setWidgetWidthByPercentage(context, 12.4),
            ),
            child: Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image(
                    image: const AssetImage("assets/whats_app_logo.png"),
                    width: Utilities.setWidgetWidthByPercentage(context, 19.7),
                  ),
                  Image(
                    image: const AssetImage("assets/tiktok_logo.png"),
                    width: Utilities.setWidgetWidthByPercentage(context, 19.7),
                  ),
                  Image(
                    image: const AssetImage("assets/instagram_logo.png"),
                    width: Utilities.setWidgetWidthByPercentage(context, 19.7),
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          flex: 657,
          child: Container(
            color: const Color.fromRGBO(244, 245, 249, 1),
            child: Column(
              children: [
                Expanded(
                  flex: 35,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: CustomizedSearchBar(context: context,),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: Utilities.setWidgetWidthByPercentage(context, 4.5)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Stack(
                                alignment: Alignment.topCenter,
                                children: [
                                  _specialOfferBox(
                                    context: context,
                                    text: "Новинки",
                                    fileName: 'assets/offers/news_pic.png',
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(top: Utilities.setWidgetHeightByPercentage(context, 1)),
                                    child: Image(
                                      image: const AssetImage("assets/offers/news_pic_content.png"),
                                      width: Utilities.setWidgetWidthByPercentage(context, 20.5),
                                    ),
                                  )
                                ],
                              ),
                              _specialOfferBox(context: context, text: "Акции", fileName: 'assets/offers/sales_pic.png'),
                              _specialOfferBox(context: context, text: "Сезонные продукты", fileName: 'assets/offers/seasonal_products_pic.png'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 7,
                  child: Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: Utilities.setWidgetWidthByPercentage(context, 5)),
                    child: const Text("Категории", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                  ),
                ),
                Expanded(
                  flex: 53,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: Utilities.setWidgetWidthByPercentage(context, 4.3)),
                    child: _categoryScrollBar(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _specialOfferBox({required BuildContext context, required String text, required String fileName}) {
    return Column(
      children: [
        SizedBox(
          height: Utilities.setWidgetHeightByPercentage(context, 13.05),
          child: Image(
            image: AssetImage(fileName),
            width: Utilities.setWidgetWidthByPercentage(context, 28.3),
          ),
        ),
        Container(
          alignment: Alignment.center,
          height: Utilities.setWidgetHeightByPercentage(context, 3.1),
          width: Utilities.setWidgetWidthByPercentage(context, 28.3),
          child: Text(
            text,
            softWrap: true,
            overflow: TextOverflow.visible,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _categoryScrollBar() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 12,
      ),
      itemBuilder: (context, index) {
        final allCategories = MyCategories.categoryList[index];
        return CategoryCard(category: allCategories);
      },
      scrollDirection: Axis.vertical,
      itemCount: MyCategories.categoryList.length,
    );
  }
}
