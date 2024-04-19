import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:precious/resources/app_export.dart';
import 'package:precious/resources/widgets/start_image_clip_path.dart';
import 'package:precious/views/login_or_sign_up_page.dart';

class StartPage extends StatefulWidget {
  static const name = "/start";

  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage>
    with SingleTickerProviderStateMixin {
  final _pageController = PageController();

  final CarouselController _controller = CarouselController();

  final pageAnimDuration = const Duration(milliseconds: 200);

  final pageCount = 3;

  final imagePathList = [
    'assets/images/necklace.jpg',
    'assets/images/necklace.jpg',
    'assets/images/necklace.jpg',
  ];

  bool hasRun = false;

  int currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: EdgeInsets.all(16.h),
          child: Flex(
            direction: Axis.vertical,
            children: [
              SizedBox(
                height: 670.v,
                child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: List.generate(pageCount, (i) {
                    return customPageView(
                        'assets/images/necklace.jpg',
                        AppLocalizations.of(context)!.startup_title_demo,
                        AppLocalizations.of(context)!.startup_subtitle_demo,
                        i);
                  }),
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 72,
                      child: CarouselSlider(
                          carouselController: _controller,
                          options: CarouselOptions(
                            height: 8,
                            initialPage: (pageCount / 2).floor(),
                            viewportFraction: 1 / pageCount,
                            autoPlay: false,
                            scrollPhysics: const NeverScrollableScrollPhysics(),
                          ),
                          items: [
                            for (int i = 0; i < pageCount; i++)
                              Container(
                                width: i == 0 ? 32 : 8,
                                height: 8,
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4.0),
                                    color: i == 0 ? Colors.black : Colors.grey),
                              )
                          ]),
                    ),
                    IconButton(
                        iconSize: 60.h,
                        onPressed: () {
                          if (currentPageIndex == pageCount - 1) {
                            Navigator.of(context)
                                .pushReplacementNamed(LoginOrSignUpPage.name);
                          }
                          currentPageIndex++;
                          _pageController
                              .nextPage(
                                  duration: pageAnimDuration,
                                  curve: Curves.linear)
                              .then((_) => setState(() {}));
                          _controller.previousPage(
                              duration: pageAnimDuration,
                              curve: Curves.decelerate);
                        },
                        icon: Icon(currentPageIndex >= pageCount - 1
                            ? Icons.check_circle
                            : Icons.arrow_circle_right_rounded))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget customPageView(
      String imageSrc, String title, String subtitle, int index) {
    return Column(
      children: [
        Container(
            height: 470,
            decoration: ShapeDecoration(
              shape: const StartImageClipPath(32.0),
              image: DecorationImage(
                  image: AssetImage(imageSrc), fit: BoxFit.cover),
            )),
        const SizedBox(height: 20),
        SizedBox(
            width: double.maxFinite,
            child: Text(title,
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.black))),
        const SizedBox(height: 20),
        SizedBox(
            width: double.maxFinite,
            child: Text(subtitle,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: Colors.black54))),
      ],
    );
  }
}
