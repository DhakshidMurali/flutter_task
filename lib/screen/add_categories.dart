import 'package:amazin/model/top_cashback.dart';
import 'package:amazin/screen/screens.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

typedef void BoolCallBack(bool cancel);

class AddCategories extends StatelessWidget {
  final TopOffer? input_Data;
  bool edit;
  final String index;
  final BoolCallBack onCancelPressed;
  AddCategories(
      {required this.onCancelPressed,
      required this.input_Data,
      required this.index,
      required this.edit,
      super.key});
  TextEditingController _titleController = TextEditingController();
  TextEditingController _imageurlController = TextEditingController();
  TextEditingController _linkController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    if (edit == true) {
      print(edit);
      _titleController.text = input_Data!.title ?? "";
      _imageurlController.text = input_Data!.image_url ?? "";
      _linkController.text = input_Data!.link ?? "";
    }
    return Card(
      elevation: 5,
      shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.5,
        width: MediaQuery.of(context).size.width * 0.35,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Color.fromRGBO(34, 34, 34, 1),
        ),
        //title
        //textfield: title + image url + linking link
        // button : add + cancel
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //title
            Text(
              'Top Categories'.toUpperCase(),
              style: GoogleFonts.kadwa(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            //textfield
            //title
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.25,
                child: TextFormField(
                  controller: _titleController,
                  style: GoogleFonts.kadwa(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Title',
                    hintStyle: GoogleFonts.kadwa(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                    filled: true,
                    fillColor: Colors.black,
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            width: 2, color: Color.fromARGB(255, 255, 106, 0))),
                  ),
                )),

            //image_url
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.25,
                child: TextFormField(
                  controller: _imageurlController,
                  style: GoogleFonts.kadwa(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'image url',
                    hintStyle: GoogleFonts.kadwa(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                    filled: true,
                    fillColor: Colors.black,
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            width: 2, color: Color.fromARGB(255, 255, 106, 0))),
                  ),
                )),

            //linking link
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.25,
                child: TextFormField(
                  controller: _linkController,
                  style: GoogleFonts.kadwa(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'linking link',
                    hintStyle: GoogleFonts.kadwa(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                    filled: true,
                    fillColor: Colors.black,
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            width: 2, color: Color.fromARGB(255, 255, 106, 0))),
                  ),
                )),

            //button
            // add + cancel
            Container(
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
                            .collection('top_catogories')
                            .doc(index)
                            .update({
                          'image_url': _imageurlController.text,
                          'link': _linkController.text,
                          'title': _titleController.text
                        });
                      }
                      await FirebaseFirestore.instance
                          .collection('top_catogories')
                          .add(({
                            'image_url': _imageurlController.text,
                            'link': _linkController.text,
                            'title': _titleController.text
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
                            .collection('top_catogories')
                            .doc(index)
                            .delete();
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
                            'Delete',
                            style: GoogleFonts.kadwa(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
