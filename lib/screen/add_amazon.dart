import 'package:amazin/model/top_cashback.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

typedef void BoolCallBack(bool cancel);

class AddAmazon extends StatelessWidget {
  final Amazon? input_Data;
  final bool edit;
  final String index;
  final BoolCallBack onCancelPressed;
  AddAmazon(
      {required this.onCancelPressed,
      required this.input_Data,
      required this.index,
      required this.edit,
      super.key});
  final TextEditingController _linkcentController = TextEditingController();
  final TextEditingController _imageurlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (edit == true) {
      _imageurlController.text = input_Data!.image_url ?? "";
      _linkcentController.text = input_Data!.link ?? "";
    }
    return Card(
      elevation: 5,
      shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.4,
        width: MediaQuery.of(context).size.width * 0.35,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Color.fromRGBO(34, 34, 34, 1),
        ),
        //title
        //text field : image url + link
        //buttons : add + cancel
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //title
            Text(
              'Amazon top selling mobiles'.toUpperCase(),
              style: GoogleFonts.kadwa(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            //textfield
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.25,
              child: TextFormField(
                controller: _imageurlController,
                style: GoogleFonts.kadwa(color: Colors.white),
                decoration: InputDecoration(
                    hintText: 'Image URL',
                    hintStyle:
                        GoogleFonts.kadwa(color: Colors.white, fontSize: 16),
                    filled: true,
                    fillColor: Colors.black,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            width: 2,
                            color: Color.fromARGB(255, 255, 106, 0)))),
              ),
            ),
            //link text field
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.25,
              child: TextFormField(
                controller: _linkcentController,
                style: GoogleFonts.kadwa(color: Colors.white),
                decoration: InputDecoration(
                    hintText: 'Link',
                    hintStyle:
                        GoogleFonts.kadwa(color: Colors.white, fontSize: 16),
                    filled: true,
                    fillColor: Colors.black,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            width: 2,
                            color: Color.fromARGB(255, 255, 106, 0)))),
              ),
            ),
            // buttons
            //add + cancel
            Container(
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width * 0.24,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    //add
                    InkWell(
                      onTap: () async {
                        if (edit) {
                          await FirebaseFirestore.instance
                              .collection('amazon')
                              .doc(index)
                              .update({
                            'image_url': _imageurlController.text,
                            'link': _linkcentController.text,
                          });
                        }
                        await FirebaseFirestore.instance
                            .collection('amazon')
                            .add(({
                              'image_url': _imageurlController.text,
                              'link': _linkcentController.text,
                            }));
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
                            !edit ? 'Add' : "edit",
                            style: GoogleFonts.kadwa(
                                color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                    //cancel
                    InkWell(
                      onTap: () {
                        print("hello");
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
                            'Cancel',
                            style: GoogleFonts.kadwa(
                                color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: edit,
                      child: InkWell(
                        onTap: () {
                          FirebaseFirestore.instance
                              .collection('amazon')
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
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
