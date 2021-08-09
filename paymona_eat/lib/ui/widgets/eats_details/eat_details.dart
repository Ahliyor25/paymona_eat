import 'package:dart_lesson/library/widgets/Inherited/provider.dart';
import 'package:dart_lesson/ui/navigation/main_navigation.dart';
import 'package:dart_lesson/ui/utils/colors.dart';
import 'package:dart_lesson/ui/widgets/eats_details/eat_details_model.dart';
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
  int currentPageValue = 0;
  int previousPageValue = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    NotifierProvider.read<EatDetailsModel>(context)?.loadDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const _TiitleWidget(),
        ),
        body: const _BodyWidget());
  }
}

class _BodyWidget extends StatelessWidget {
  const _BodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<EatDetailsModel>(context);
    final eatsDetails = model?.eatDetails;
    if (eatsDetails == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return ListView(
      children: [
        const _ImageWidget(),
        NameFoods(),
        const _PriceFoodWidget(),
        const _Info_widget(),
        AppButton(
            bgColor: blue,
            borderRadius: 20,
            fontSize: 17,
            fontWeight: FontWeight.w600,
            onTap: () {
              Navigator.pushNamed(context, MainNavigationRouteNames.mainScreen);
            },
            text: 'Добавить в корзину ',
            textColor: Colors.white)
      ],
    );
  }
}

class _ImageWidget extends StatelessWidget {
  const _ImageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<EatDetailsModel>(context);
    final path_image = model?.eatDetails?.img ??
        'https://telegra.ph/file/9c9845d74a47e9de1c01b.png';
    return Column(children: [
      Container(
          height: MediaQuery.of(context).size.height * 0.35,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(1),
            image: DecorationImage(
                image: NetworkImage(
                  '$path_image',
                  scale: 1.0,
                ),
                fit: BoxFit.cover,
                scale: 1),
          )),
    ]);
  }
}

class _Info_widget extends StatelessWidget {
  const _Info_widget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<EatDetailsModel>(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 16),
          child: Align(
            alignment: Alignment.centerLeft,
            child: AppText(
              text: 'Описание',
              size: 17,
              color: Colors.black,
              weight: FontWeight.w600,
              textAlign: TextAlign.start,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 7),
          child: AppText(
            text: model?.eatDetails?.des ??
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
      ],
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
  NameFoods({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<EatDetailsModel>(context);
    return Padding(
        padding: const EdgeInsets.all(16),
        child: AppText(
          text: model?.eatDetails?.title ?? 'Загрузка',
          size: 28,
          color: Colors.black,
          weight: FontWeight.w700,
          textAlign: TextAlign.center,
        ));
  }
}

class _PriceFoodWidget extends StatelessWidget {
  const _PriceFoodWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<EatDetailsModel>(context);
    return AppText(
      text: model?.eatDetails?.price ?? 'Загрузка',
      size: 22,
      color: blue,
      weight: FontWeight.w700,
      textAlign: TextAlign.center,
    );
  }
}
