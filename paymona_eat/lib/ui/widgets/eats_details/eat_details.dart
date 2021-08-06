import 'package:dart_lesson/library/widgets/Inherited/provider.dart';
import 'package:dart_lesson/ui/utils/colors.dart';
import 'package:dart_lesson/ui/widgets/eats_details/eat_details_model.dart';
import 'package:dart_lesson/ui/widgets/widgets/circle_dot_widget.dart';
import 'package:dart_lesson/ui/widgets/widgets/custom_button.dart';
import 'package:dart_lesson/ui/widgets/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class EatsDetails extends StatefulWidget {
  EatsDetails({
    Key? key,
  }) : super(key: key);

  @override
  _EatsDetailsState createState() => _EatsDetailsState();
}

class _EatsDetailsState extends State<EatsDetails> {
  late PageController _pageController;
  int currentPageValue = 0;
  int previousPageValue = 0;
  double _moveBar = 0.0;
  final List<Widget> images = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    NotifierProvider.read<EatDetailsModel>(context)?.loadDetails();
  }

  @override
  void initState() {
    images.add(Image.asset('images/one.png'));
    images.add(Image.asset('images/two.png'));
    images.add(Image.asset('images/three.png'));
    images.add(Image.asset('images/four.png'));
    super.initState();
    _pageController = PageController(initialPage: currentPageValue);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void animatePage(int page) {
    currentPageValue = page;

    if (previousPageValue == 0) {
      previousPageValue = currentPageValue;
      _moveBar = _moveBar + 0.14;
    } else {
      if (previousPageValue < currentPageValue) {
        previousPageValue = currentPageValue;
        _moveBar = _moveBar + 0.14;
      } else {
        previousPageValue = currentPageValue;
        _moveBar = _moveBar - 0.14;
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const _TiitleWidget(),
      ),
      body: ListView(children: [
        Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              child: PageView.builder(
                physics: const ClampingScrollPhysics(),
                itemBuilder: (context, index) {
                  return images[index];
                },
                onPageChanged: (int page) {
                  animatePage(page);
                },
                itemCount: images.length,
                controller: _pageController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  for (int i = 0; i < images.length; i++)
                    if (i == currentPageValue) ...[
                      CircleDotWidget(
                        isActive: true,
                        color: blue,
                        borderColor: blue,
                      )
                    ] else
                      CircleDotWidget(
                        isActive: false,
                        color: silver_one,
                        borderColor: silver_one,
                      ),
                ],
              ),
            ),
            NameFoods(
              key: null,
            ),
            AppText(
              text: 'N1,900',
              size: 22,
              color: blue,
              weight: FontWeight.w700,
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: AppText(
                  text: 'Информация о доставке',
                  size: 17,
                  color: Colors.black,
                  weight: FontWeight.w600,
                  textAlign: TextAlign.start,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
              child: AppText(
                text:
                    'Доставляется с понедельника  по четверг, с 09:00 до 23:00.',
                size: 15,
                color: black_50,
                weight: FontWeight.w400,
                textAlign: TextAlign.start,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: AppText(
                  text: 'Политика возврата',
                  size: 17,
                  color: Colors.black,
                  weight: FontWeight.w600,
                  textAlign: TextAlign.start,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
              child: AppText(
                text:
                    'Все наши продукты проходят двойную проверку перед тем, как покинуть наши магазины, поэтому в любом случае, если вы обнаружите испорченный продукт, немедленно свяжитесь с нашей горячей линией. ',
                size: 15,
                color: black_50,
                weight: FontWeight.w400,
                textAlign: TextAlign.start,
              ),
            ),
            AppButton(
                bgColor: blue,
                borderRadius: 20,
                fontSize: 17,
                fontWeight: FontWeight.w600,
                onTap: () {
                  // Navigator.pushNamed(context, Routes.home);
                },
                text: 'Добавить в корзину ',
                textColor: Colors.white)
          ],
        )
      ]),
    );
  }
}

class _TiitleWidget extends StatelessWidget {
  const _TiitleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<EatDetailsModel>(context);
    return Text(model?.eatDetails?.title ?? 'Загрузка');
  }
}

class NameFoods extends StatelessWidget {
  NameFoods({required Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16),
        child: AppText(
          text: 'КАРТОШКА ФРИ',
          size: 28,
          color: Colors.black,
          weight: FontWeight.w700,
          textAlign: TextAlign.center,
        ));
  }
}
