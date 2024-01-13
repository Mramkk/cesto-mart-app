import 'package:cesto_mart/config/urls.dart';
import 'package:flutter/material.dart';
import 'package:cesto_mart/config/colors.dart';
import 'package:cesto_mart/config/text_styles.dart';
import 'package:cesto_mart/models/store/store.dart';

class StoreDetails extends StatefulWidget {
  final StoreModel store;
  const StoreDetails({super.key, required this.store});

  @override
  State<StoreDetails> createState() => _StoreDetailsState();
}

class _StoreDetailsState extends State<StoreDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Store Details",
          style: appbarStyle,
        ),
        backgroundColor: appbarColor,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              widLbl(lbl: "Name"),
              widText(txt: widget.store.name),
              const SizedBox(height: 5),
              widLbl(lbl: "Email"),
              widText(txt: widget.store.email),
              const SizedBox(height: 5),
              widLbl(lbl: "Mobile No."),
              widText(txt: widget.store.mobile),
              const SizedBox(height: 5),
              widLbl(lbl: "Whatsapp No."),
              widText(txt: widget.store.whatsapp),
              const SizedBox(height: 5),
              widLbl(lbl: "Aadhar No."),
              widText(txt: widget.store.aadhar),
              const SizedBox(height: 5),
              widLbl(lbl: "Pan No."),
              widText(txt: widget.store.pan),
              const SizedBox(height: 5),
              widLbl(lbl: "GSTIN No."),
              widText(txt: widget.store.gstin),
              const SizedBox(height: 5),
              widLbl(lbl: "State"),
              widText(txt: widget.store.state),
              const SizedBox(height: 5),
              widLbl(lbl: "City"),
              widText(txt: widget.store.city),
              const SizedBox(height: 5),
              widLbl(lbl: "Division"),
              widText(txt: widget.store.division),
              const SizedBox(height: 5),
              widLbl(lbl: "Area"),
              widText(txt: widget.store.area),
              const SizedBox(height: 5),
              widLbl(lbl: "Postal Code"),
              widText(txt: widget.store.pincode),
              const SizedBox(height: 5),
              widLbl(lbl: "Address"),
              widText(txt: widget.store.address),
              const SizedBox(height: 5),
              widLbl(lbl: "Document"),
              Container(
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(baseUrl + widget.store.document),
                      fit: BoxFit.cover),
                ),
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }

  widLbl({required String lbl}) {
    return Text(
      lbl,
      style: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        fontFamily: fontFamily,
        color: Colors.black54,
      ),
    );
  }

  widText({required String txt}) {
    return Text(
      txt,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        fontFamily: fontFamily,
      ),
    );
  }
}
