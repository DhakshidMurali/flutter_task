import 'package:amazin/model/top_cashback.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

typedef void BoolCallBack(bool cancel);

class add_cashback extends StatelessWidget {
  final CashBack? input_Data;
  final bool edit;
  final String index;
  final BoolCallBack onCancelPressed;
  add_cashback(
      {required this.onCancelPressed,
      required this.input_Data,
      required this.edit,
      required this.index,
      super.key});
  final TextEditingController _offerpercentController = TextEditingController();
  final TextEditingController _imageurlController = TextEditingController();
  final TextEditingController _linkController = TextEditingController();
  final TextEditingController _offerendingController = TextEditingController();
  final TextEditingController _cashbackpercentController =
      TextEditingController();
  final TextEditingController _titlepercentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    if (edit == true) {
      _offerpercentController.text = input_Data!.offer_percent ?? "";
      _imageurlController.text = input_Data!.image_url ?? "";
      _linkController.text = input_Data!.link ?? "";
      _offerendingController.text = input_Data!.date ?? "";
      _cashbackpercentController.text = input_Data!.cashback_percent ?? "";
    }
    return Card(
      elevation: 5,
      shape: BeveledRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.5,
        height: MediaQuery.of(context).size.height * 0.55,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Color.fromRGBO(34, 34, 34, 1)),
        //title
        //textfield : offer percent image url cashback percent offer ending date
        // button : add+ cancel
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Top cashback stories'.toUpperCase(),
              style: GoogleFonts.kadwa(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            //textfield
            //below row consist of offer percent + image url
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.19,
                  child: TextFormField(
                    controller: _offerpercentController,
                    style: GoogleFonts.kadwa(color: Colors.white),
                    decoration: InputDecoration(
                        hintText: 'Offer precentage',
                        hintStyle: GoogleFonts.kadwa(
                            fontSize: 16, color: Colors.white),
                        filled: true,
                        fillColor: Colors.black,
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              width: 2,
                              color: Color.fromARGB(255, 255, 106, 0),
                            ))),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.19,
                  child: TextFormField(
                    controller: _imageurlController,
                    style: GoogleFonts.kadwa(color: Colors.white),
                    decoration: InputDecoration(
                        hintText: 'Image url',
                        hintStyle: GoogleFonts.kadwa(
                            fontSize: 16, color: Colors.white),
                        filled: true,
                        fillColor: Colors.black,
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              width: 2,
                              color: Color.fromARGB(255, 255, 106, 0),
                            ))),
                  ),
                )
              ],
            ),
            // this below row consists of textfield for cashback + offer ending date
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.19,
                  child: TextFormField(
                    controller: _cashbackpercentController,
                    style: GoogleFonts.kadwa(color: Colors.white),
                    decoration: InputDecoration(
                        hintText: 'cash back precentage',
                        hintStyle: GoogleFonts.kadwa(
                            fontSize: 16, color: Colors.white),
                        filled: true,
                        fillColor: Colors.black,
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              width: 2,
                              color: Color.fromARGB(255, 255, 106, 0),
                            ))),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.19,
                  child: TextFormField(
                    controller: _offerendingController,
                    style: GoogleFonts.kadwa(color: Colors.white),
                    decoration: InputDecoration(
                        hintText: 'Offer ending date',
                        hintStyle: GoogleFonts.kadwa(
                            fontSize: 16, color: Colors.white),
                        filled: true,
                        fillColor: Colors.black,
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              width: 2,
                              color: Color.fromARGB(255, 255, 106, 0),
                            ))),
                  ),
                )
              ],
            ),
            // below is for linking link
            // so that we increase the width of container
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.29,
              child: TextFormField(
                controller: _linkController,
                style: GoogleFonts.kadwa(color: Colors.white),
                decoration: InputDecoration(
                    hintText: 'linking link',
                    hintStyle:
                        GoogleFonts.kadwa(fontSize: 16, color: Colors.white),
                    filled: true,
                    fillColor: Colors.black,
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          width: 2,
                          color: Color.fromARGB(255, 255, 106, 0),
                        ))),
              ),
            ),
            //button
            // add + cancel
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.24,
              height: MediaQuery.of(context).size.height * 0.1,
              child: Row(
                //add +cancel button
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  //add button
                  InkWell(
                    onTap: () async {
                      if (edit) {
                        await FirebaseFirestore.instance
                            .collection('top_cashback')
                            .doc(index)
                            .update({
                          'cashback_percent': _cashbackpercentController.text,
                          'date': _offerendingController.text,
                          'image_url': _imageurlController.text,
                          'link': _linkController.text,
                          'offer_percent': _offerpercentController.text,
                        });
                      }
                      print("added");
                      await FirebaseFirestore.instance
                          .collection('top_cashback')
                          .add(({
                            'cashback_percent': _cashbackpercentController.text,
                            'date': _offerendingController.text,
                            'image_url': _imageurlController.text,
                            'link': _linkController.text,
                            'offer_percent': _offerpercentController.text,
                          }));
                      onCancelPressed(false);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.07,
                      height: MediaQuery.of(context).size.height * 0.05,
                      decoration: BoxDecoration(
                          border: Border.all(width: 2, color: Colors.red),
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.black),
                      child: Center(
                        child: Text(
                          !edit ? 'Add' : "edit",
                          style: GoogleFonts.kadwa(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                  //cancel
                  InkWell(
                    onTap: () {
                      onCancelPressed(false);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.07,
                      height: MediaQuery.of(context).size.height * 0.05,
                      decoration: BoxDecoration(
                          border: Border.all(width: 2, color: Colors.red),
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.black),
                      child: Center(
                        child: Text(
                          'Cancel',
                          style: GoogleFonts.kadwa(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: edit,
                    child: InkWell(
                      onTap: () {
                        FirebaseFirestore.instance
                            .collection('top_cashback')
                            .doc(index)
                            .delete();
                        onCancelPressed(false);
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.07,
                        width: MediaQuery.of(context).size.width * 0.07,
                        decoration: BoxDecoration(
                          border: Border.all(width: 2, color: Colors.red),
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.black,
                        ),
                        child: Center(
                          child: Text(
                            'Delete',
                            style: GoogleFonts.kadwa(
                                color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
