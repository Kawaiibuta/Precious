import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:precious/resources/widgets/start_image_clip_path.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> with SingleTickerProviderStateMixin {
  final _pageController = PageController();

  late AnimationController _controller;
  late List<double> _widthList;
  late List<Color> _colorList;

  final pageAnimDuration = const Duration(milliseconds: 500);

  final pageCount = 3;

  bool hasRun = false;

  int currentPageIndex = 0;

  late CurvedAnimation _curvedAnimation, _reverseCurvedAnimation;

  late ColorTween _colorTween;
  late Tween<double> _widthTween;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: pageAnimDuration)
      ..addListener(() => setState(() {
            _colorList[currentPageIndex] =
                _colorTween.evaluate(_curvedAnimation)!;
            _widthList[currentPageIndex] =
                _widthTween.evaluate(_curvedAnimation);

            for (var i = 0; i < pageCount; i++) {
              if (i != currentPageIndex && _widthList[i] > 8) {
                _colorList[i] =
                    _colorTween.evaluate(_reverseCurvedAnimation)!;
                _widthList[i] =
                    _widthTween.evaluate(_reverseCurvedAnimation);
              }
            }
          }));

    _colorList = List.filled(pageCount, Colors.grey);
    _colorList[0] = Colors.black;
    _widthList = List.filled(pageCount, 8.0);
    _widthList[0] = 32.0;
    _colorTween = ColorTween(begin: Colors.grey, end: Colors.black);
    _widthTween = Tween(begin: 8, end: 32);
    _curvedAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.linear);
    _reverseCurvedAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.linear.flipped);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(
                height: 690,
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
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 72,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          for (int i = 0; i < pageCount; i++)
                            Container(
                              width: _widthList[i],
                              height: 8,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4.0),
                                  color: _colorList[i]),
                            )
                        ]),
                  ),
                  IconButton(
                      iconSize: 60.0,
                      onPressed: () {
                        if (currentPageIndex == pageCount - 1) {
                          return;
                        }
                        hasRun = true;
                        currentPageIndex += 1;
                        _pageController.animateToPage(currentPageIndex,
                            duration: pageAnimDuration, curve: Curves.linear);
                        _controller.forward();
                      },
                      icon: Icon(currentPageIndex == pageCount - 1
                          ? Icons.check_circle
                          : Icons.arrow_circle_right_rounded))
                ],
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
                    .labelLarge!
                    .copyWith(color: Colors.black54))),
      ],
    );
  }
}
