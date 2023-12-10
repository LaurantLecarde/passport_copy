import 'dart:io';

import 'package:flutter/material.dart';
import 'package:passport_copy/model/passport.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key,required this.passport});
  final Passport? passport;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(passport?.fullName ?? ""),),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [
            Image.file(File(passport?.image ?? "")),
            SizedBox(height: 20,),
            Text(passport?.address ?? "")
          ],
        ),
      ),
    );
  }
}
