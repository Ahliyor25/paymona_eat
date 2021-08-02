import 'package:dart_lesson/library/widgets/Inherited/provider.dart';
import 'package:dart_lesson/ui/widgets/main_screen/eat_list_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EatListWidget extends StatelessWidget {
  const EatListWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<EatListModel>(context);
    if (model == null) return const SizedBox.shrink();
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        elevation: 0,
        brightness: Brightness.light,
        leading: const Icon(null),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.shopping_basket,
              color: Colors.grey[800],
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Food Delivery',
                    style: TextStyle(
                        color: Colors.grey[80],
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                      height: 50,
                      child: ListView.builder(
                          itemCount: model.eats.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            // final eat = model.eats[index];
                            return makeCategory(isActive: true, title: 'Pizaa');
                          })),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                'Free Delivery',
                style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    itemExtent: 203,
                    itemCount: model.eats.length,
                    itemBuilder: (BuildContext context, int index) {
                      final eat = model.eats[index];
                      final path_image = eat.img;

                      path_image != null
                          ? Image.network(path_image)
                          : const SizedBox.shrink();
                      return Stack(children: [
                        AspectRatio(
                          aspectRatio: 1 / 1.5,
                          child: Container(
                            margin: const EdgeInsets.only(right: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                image: NetworkImage(
                                  "$path_image",
                                  scale: 1.0,
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  gradient: LinearGradient(
                                      begin: Alignment.bottomCenter,
                                      stops: [
                                        .2,
                                        .9
                                      ],
                                      colors: [
                                        Colors.black.withOpacity(.9),
                                        Colors.black.withOpacity(.3),
                                      ])),
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Align(
                                      alignment: Alignment.topRight,
                                      child: Icon(
                                        Icons.favorite,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          eat.price,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 40,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          eat.title,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        // makeItem(
                        //     image: path_image ?? '0',
                        //     title: eat.title,
                        //     price: eat.price),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(20),
                            onTap: () => model.onEatTap(context, index),
                          ),
                        ),
                      ]);
                    }),
              ),
            ),
            const SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }

  Widget makeCategory({required bool isActive, required String title}) {
    return AspectRatio(
      aspectRatio: isActive ? 3 : 2.5 / 1,
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          color: isActive ? Colors.yellow[700] : Colors.white,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Align(
          child: Text(
            title,
            style: TextStyle(
                color: isActive ? Colors.white : Colors.grey[500],
                fontSize: 18,
                fontWeight: isActive ? FontWeight.bold : FontWeight.w100),
          ),
        ),
      ),
    );
  }

//   Widget makeItem(
//       {required String image, required String title, required String price}) {
//     // return AspectRatio(
//     //   aspectRatio: 1 / 1.5,
//     //   child: Container(
//     //     margin: const EdgeInsets.only(right: 20),
//     //     decoration: BoxDecoration(
//     //       borderRadius: BorderRadius.circular(20),
//     //       image: DecorationImage(
//     //         image: NetworkImage(
//     //           image,
//     //           scale: 1.0,
//     //         ),
//     //         fit: BoxFit.cover,
//     //       ),
//     //     ),
//     //     child: Container(
//     //       decoration: BoxDecoration(
//     //           borderRadius: BorderRadius.circular(20),
//     //           gradient: LinearGradient(begin: Alignment.bottomCenter, stops: [
//     //             .2,
//     //             .9
//     //           ], colors: [
//     //             Colors.black.withOpacity(.9),
//     //             Colors.black.withOpacity(.3),
//     //           ])),
//     //       child: Padding(
//     //         padding: const EdgeInsets.all(20.0),
//     //         child: Column(
//     //           crossAxisAlignment: CrossAxisAlignment.start,
//     //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     //           children: [
//     //             const Align(
//     //               alignment: Alignment.topRight,
//     //               child: Icon(
//     //                 Icons.favorite,
//     //                 color: Colors.white,
//     //               ),
//     //             ),
//     //             Column(
//     //               crossAxisAlignment: CrossAxisAlignment.start,
//     //               children: [
//     //                 Text(
//     //                   price,
//     //                   style: const TextStyle(
//     //                       color: Colors.white,
//     //                       fontSize: 40,
//     //                       fontWeight: FontWeight.bold),
//     //                 ),
//     //                 const SizedBox(
//     //                   height: 10,
//     //                 ),
//     //                 Text(
//     //                   title,
//     //                   style: const TextStyle(color: Colors.white, fontSize: 20),
//     //                 )
//     //               ],
//     //             )
//     //           ],
//     //         ),
//     //       ),
//     //     ),
//     //   ),
//     // );
//   }
// }
}
