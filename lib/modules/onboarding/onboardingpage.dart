import 'package:flutter/material.dart';
import 'package:shopping/modules/login/login.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../shared/componant/componant.dart';
import '../../shared/shared_preference/cachHelper.dart';
import '../../shared/styles/colors.dart';

class onBordingPage extends StatefulWidget {
  @override
  State<onBordingPage> createState() => _onBordingPageState();
}

class _onBordingPageState extends State<onBordingPage> {
  var pageController = PageController();

  bool islast = false;

  List<titlepageview> pagesView = [
    titlepageview(
        image: 'assets/shop.png',
        title: "hello dear",
        desc: "all what you want is here"),
    titlepageview(
        image: 'assets/kindg.png',
        title: "good offert",
        desc: "shopping and get offerts"),
    titlepageview(
        image: 'assets/shoppingf.png',
        title: "lets get some offerts",
        desc: "why you wait login now"),
  ];
  void submit() {
    CacheHelper.saveData(key: "onBoarding", value: true).then((value) {
      if (value) NavigatFinsh(context, login());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: submit,
              child: Text(
                "SKIP..",
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: PageView.builder(
              itemBuilder: (context, index) => pageViewItem(pagesView[index]),
              itemCount: pagesView.length,
              controller: pageController,
              physics: BouncingScrollPhysics(),
              onPageChanged: (index) {
                if (index == pagesView.length - 1) {
                  setState(() {
                    islast = true;
                  });
                } else {
                  setState(() {
                    islast = false;
                  });
                }
              },
            )),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: pageController,
                  effect: ExpandingDotsEffect(
                    activeDotColor: defultColor,
                    dotColor: Colors.grey,
                    dotHeight: 10,
                    dotWidth: 10,
                    spacing: 5.0,
                    expansionFactor: 4,
                  ),
                  count: pagesView.length,
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (islast) {
                      submit();
                    } else {
                      pageController.nextPage(
                          duration: Duration(milliseconds: 750),
                          curve: Curves.fastLinearToSlowEaseIn);
                    }
                    ;
                  },
                  child: Icon(Icons.arrow_forward_ios),
                )
              ],
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
