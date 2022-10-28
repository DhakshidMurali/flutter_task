import 'package:amazin/model/top_cashback.dart';
import 'package:amazin/screen/add_amazon.dart';
import 'package:amazin/screen/add_cashback.dart';
import 'package:amazin/screen/add_categories.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreenUser extends StatefulWidget {
  const HomeScreenUser({super.key});

  @override
  State<HomeScreenUser> createState() => _HomeScreenUserState();
}

class _HomeScreenUserState extends State<HomeScreenUser> {
  final CarouselController _controller = CarouselController();
  int currentPage = 0;
  int selected_popup = 10;
  List<SliderClass> slider_data = [];
  //streambuilder is used in three places
  //list is not used
  //add button not required
  //only retrieve with firebase
  
  // Stream<QuerySnapshot> get_Data() {
  //   get_list();
  //   return FirebaseFirestore.instance.collection('slider').snapshots();
  // }

  // CollectionReference _collectionRef_amazon =
  //     FirebaseFirestore.instance.collection('amazon');
  // CollectionReference _collectionRef_slider =
  //     FirebaseFirestore.instance.collection('slider');
  // CollectionReference _collectionRef_top_cashback =
  //     FirebaseFirestore.instance.collection('top_cashback');
  // CollectionReference _collectionRef_top_catogories =
  //     FirebaseFirestore.instance.collection('top_catogories');
  @override
  // Future<void> get_list() async {
  // QuerySnapshot querySnapshot__amazon = await _collectionRef_amazon.get();
  // QuerySnapshot querySnapshot_slider = await _collectionRef_slider.get();
  // QuerySnapshot querySnapshot_top_cashback =
  //     await _collectionRef_top_cashback.get();
  // QuerySnapshot querySnapshot_top_catogories =
  //     await _collectionRef_top_catogories.get();
  //   await FirebaseFirestore.instance
  //       .collection('top_cashback')
  //       .get()
  //       .then((value) => {
  //             (value.docs.forEach((element) {
  //               if (top_cashback.length < value.size) {
  //                 top_cashback.add(CashBack(
  //                   cashback_percent: element.get('cashback_percent'),
  //                   date: element.get('date'),
  //                   image_url: element.get('image_url'),
  //                   link: element.get('link'),
  //                   offer_percent: element.get('offer_percent'),
  //                 ));
  //               }
  //             }))
  //           });

  //   await FirebaseFirestore.instance
  //       .collection('amazon')
  //       .get()
  //       .then((value) => {
  //             if (amazon_data.length < value.size)
  //               {
  //                 (value.docs.forEach((element) {
  //                   amazon_data.add(Amazon(
  //                       link: element.get('link'),
  //                       image_url: element.get('image_url')));
  //                 }))
  //               }
  //           });
  //   await FirebaseFirestore.instance
  //       .collection('top_catogories')
  //       .get()
  //       .then((value) => {
  //             (value.docs.forEach((element) {
  //               if (top_Categories.length < value.size) {
  //                 top_Categories.add(TopOffer(
  //                   link: element.get('link'),
  //                   image_url: element.get('image_url'),
  //                   title: element.get('title'),
  //                 ));
  //               }
  //             }))
  //           });
  //   return await FirebaseFirestore.instance
  //       .collection('slider')
  //       .get()
  //       .then((value) => {
  //             if (slider_data.length < value.size)
  //               {
  //                 (value.docs.forEach((element) {
  //                   slider_data
  //                       .add(SliderClass(image_url: element.get('image_url')));
  //                 }))
  //               }
  //           });
  // }
  String logo_url =
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSYugcd50H-J9k2aqtQ8GgebajaY3aMC7k7uw&usqp=CAU";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Color.fromRGBO(34, 34, 34, 1),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width,
            child: StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection('slider').snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    if (!snapshot.hasData) {
                      return Container(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          color: Colors.black87,
                          child: Center(child: CircularProgressIndicator()));
                    }
                  }
                  snapshot.data!.docs.forEach((element) {
                    slider_data
                        .add(SliderClass(image_url: element.get('image_url')));
                  });
                  return Stack(
                    children: [
                      CarouselSlider(
                        carouselController: _controller,
                        items: [
                          slider_widget(
                            image_url: slider_data.isEmpty
                                ? logo_url
                                : slider_data[0].image_url ?? logo_url,
                          ),
                          slider_widget(
                            image_url: slider_data.isEmpty
                                ? logo_url
                                : slider_data[1].image_url ?? logo_url,
                          ),
                          slider_widget(
                            image_url: slider_data.isEmpty
                                ? logo_url
                                : slider_data[2].image_url ?? logo_url,
                          ),
                          slider_widget(
                            image_url: slider_data.isEmpty
                                ? logo_url
                                : slider_data[3].image_url ?? logo_url,
                          ),
                          slider_widget(
                            image_url: slider_data.isEmpty
                                ? logo_url
                                : slider_data[4].image_url ?? logo_url,
                          ),
                        ],
                        options: CarouselOptions(
                          onPageChanged: (index, reason) {
                            currentPage = index;

                            setState(() {});
                          },
                          height: MediaQuery.of(context).size.height * 0.5,
                          autoPlay: true,
                          aspectRatio: 16 / 9,
                          autoPlayCurve: Curves.fastOutSlowIn,
                          autoPlayAnimationDuration:
                              Duration(milliseconds: 800),
                          viewportFraction: 1,
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.04,
                          width: MediaQuery.of(context).size.width * 0.2,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              CircleAvatar(
                                radius: 3,
                                backgroundColor: currentPage == 0
                                    ? Colors.red
                                    : Colors.black,
                              ),
                              CircleAvatar(
                                radius: 3,
                                backgroundColor: currentPage == 1
                                    ? Colors.red
                                    : Colors.black,
                              ),
                              CircleAvatar(
                                radius: 3,
                                backgroundColor: currentPage == 2
                                    ? Colors.red
                                    : Colors.black,
                              ),
                              CircleAvatar(
                                radius: 3,
                                backgroundColor: currentPage == 3
                                    ? Colors.red
                                    : Colors.black,
                              ),
                              CircleAvatar(
                                radius: 3,
                                backgroundColor: currentPage == 4
                                    ? Colors.red
                                    : Colors.black,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  );
                }),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.2,
            width: MediaQuery.of(context).size.width,
            color: Colors.transparent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Top Categories'.toUpperCase(),
                    style: GoogleFonts.kadwa(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.14,
                  width: MediaQuery.of(context).size.width,
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('top_catogories')
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          if (!snapshot.hasData) {
                            return Container(
                                height: MediaQuery.of(context).size.height,
                                width: MediaQuery.of(context).size.width,
                                color: Colors.black87,
                                child:
                                    Center(child: CircularProgressIndicator()));
                          }
                        }

                        return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            // itemCount: 10,
                            itemCount: snapshot.data!.size,
                            itemBuilder: (BuildContext context, int index) {
                              DocumentSnapshot items =
                                  snapshot.data!.docs[index];
                              return InkWell(
                                onTap: () async {
                                  //todo 1
                                  print(items.get('link'));
                                  Uri url = Uri.parse(items.get('link'));
                                  if (await canLaunchUrl(url)) {
                                    await launchUrl(url,
                                        mode: LaunchMode.externalApplication);
                                  } else {
                                    throw 'Could not launch $url';
                                  }
                                },
                                child: Container(
                                  margin: EdgeInsets.only(right: 16),
                                  height:
                                      MediaQuery.of(context).size.height * 0.07,
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        // 'Fashion',
                                        items.get('title'),
                                        style: GoogleFonts.kadwa(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black),
                                      ),
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.1,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.1,
                                        child: Image.network(
                                          // "data:image/png;base64,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",
                                          // top_Categories[index].image_url ?? "",
                                          items.get('image_url'),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            });
                      }),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          //container 2
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width,
            color: Colors.transparent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Top cashback stories'.toUpperCase(),
                    style: GoogleFonts.kadwa(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.22,
                  width: MediaQuery.of(context).size.width,
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('top_cashback')
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          if (!snapshot.hasData) {
                            return Container(
                                height: MediaQuery.of(context).size.height,
                                width: MediaQuery.of(context).size.width,
                                color: Colors.black87,
                                child:
                                    Center(child: CircularProgressIndicator()));
                          }
                        }
                        return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data!.size,
                            itemBuilder: (BuildContext context, int index) {
                              DocumentSnapshot items =
                                  snapshot.data!.docs[index];
                              return InkWell(
                                onTap: () async {
                                  //todo
                                  Uri url = Uri.parse(items.get('link'));
                                  if (await canLaunchUrl(url)) {
                                    await launchUrl(url,
                                        mode: LaunchMode.externalApplication);
                                  } else {
                                    throw 'Could not launch $url';
                                  }
                                },
                                child: Container(
                                  margin: EdgeInsets.only(right: 16),
                                  height:
                                      MediaQuery.of(context).size.height * 0.25,
                                  width:
                                      MediaQuery.of(context).size.width * 0.34,
                                  decoration: BoxDecoration(
                                      color: Colors.black45,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.1,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.3,
                                        child: Stack(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(top: 16),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.3,
                                              child: Image.network(
                                                // "data:image/png;base64,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",
                                                // top_cashback[index].image_url ??
                                                //     "",
                                                items.get('image_url'),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.035,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.2,
                                                color: Colors.red,
                                                child: Center(
                                                  child: Text(
                                                    // 'upto 70% off'
                                                    // 'upto ${top_cashback[index].offer_percent} off',
                                                    'upto ${items.get('offer_percent')} off'
                                                        .toUpperCase(),
                                                    style: GoogleFonts.kadwa(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.04,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.3,
                                        color: Color.fromARGB(255, 255, 106, 0),
                                        child: Center(
                                          child: Text(
                                            // 'earn ${top_cashback[index].cashback_percent} cashback now'
                                            //     .toUpperCase(),
                                            'earn ${items.get('cashback_percent')} cashback now'
                                                .toUpperCase(),
                                            style: GoogleFonts.kadwa(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(bottom: 16),
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.03,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.24,
                                        color: Color.fromARGB(255, 252, 5, 5),
                                        child: Center(
                                          child: Text(
                                            // 'Hurry Up only ${top_cashback[index].date} days left'
                                            //     .toUpperCase(),
                                            'Hurry Up only ${items.get('date')} days left'
                                                .toUpperCase(),
                                            style: GoogleFonts.kadwa(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                      }),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 24,
          ),
          //container 2
          Container(
            height: MediaQuery.of(context).size.height * 0.28,
            width: MediaQuery.of(context).size.width,
            color: Colors.transparent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Amazon- gif top selling mobiles'.toUpperCase(),
                    style: GoogleFonts.kadwa(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.width,
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('amazon')
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          if (!snapshot.hasData) {
                            return Container(
                                height: MediaQuery.of(context).size.height,
                                width: MediaQuery.of(context).size.width,
                                color: Colors.black87,
                                child:
                                    Center(child: CircularProgressIndicator()));
                          }
                        }
                        return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data!.size,
                            itemBuilder: (BuildContext context, int index) {
                              DocumentSnapshot items =
                                  snapshot.data!.docs[index];
                              return InkWell(
                                onTap: () async {
                                  //todo
                                  Uri url = Uri.parse(items.get('link'));
                                  if (await canLaunchUrl(url)) {
                                    await launchUrl(url,
                                        mode: LaunchMode.externalApplication);
                                  } else {
                                    throw 'Could not launch $url';
                                  }
                                },
                                child: Container(
                                  margin: EdgeInsets.only(right: 16),
                                  height:
                                      MediaQuery.of(context).size.height * 0.2,
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.15,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.4,
                                        child: Image.network(
                                          // "data:image/png;base64,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",
                                          // amazon_data[index].image_url ?? "",
                                          items.get('image_url'),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.05,
                                        color: Colors.black,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(
                                                  right: 10, top: 3),
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.03,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.15,
                                              color: Color.fromARGB(
                                                  255, 255, 106, 0),
                                              child: Center(
                                                child: Text(
                                                  'Grab deal'.toUpperCase(),
                                                  style: GoogleFonts.kadwa(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                      }),
                ),
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.04,
          )
        ],
      )),
    ));
  }
}

class slider_widget extends StatelessWidget {
  final String image_url;
  const slider_widget({
    required this.image_url,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.all(6.0),
      decoration: BoxDecoration(
        color: Colors.indigo,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Image.network(
        image_url,
        scale: 1,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            return child;
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
        fit: BoxFit.fill,
      ),
    );
  }
}
