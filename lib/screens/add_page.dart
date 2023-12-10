import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:passport_copy/db/sql_helper.dart';
import 'package:passport_copy/model/passport.dart';
import 'package:passport_copy/screens/main_page.dart';
import 'package:passport_copy/widget/my_text_field.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final _picker = ImagePicker();
  final _fullName = TextEditingController();
  final _city = TextEditingController();
  final _homeAddress = TextEditingController();
  final _passportGotDate = TextEditingController();
  final _passportExpireDate = TextEditingController();
  XFile? _xFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new Passport'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [_xFile == null ? _defaultImage() : _passportImage()
          ,const SizedBox(height: 20,),
            MyTextField(hint: 'Full Name', controller: _fullName),
            const SizedBox(height: 20,),
            MyTextField(hint: 'Address', controller: _homeAddress),
            const SizedBox(height: 20,),
            MyTextField(hint: 'city', controller: _city),
            const SizedBox(height: 20,),
            MyTextField(hint: 'Got Date', controller: _passportGotDate),
            const SizedBox(height: 20,),
            MyTextField(hint: 'Exp date', controller: _passportExpireDate),
            const SizedBox(height: 20,),
            ElevatedButton(onPressed: _savePassports, child:const  Text('Save'))
          ],
        ),
      ),
    );
  }

  Widget _defaultImage() {
    return Container(
      height: 150,
      width: 150,
      decoration:
          BoxDecoration(border: Border.all(color: Colors.black, width: 2)),
      child: InkWell(
        onTap: () async {
          _xFile = await _picker.pickImage(source: ImageSource.gallery);
          setState(() {});
        },
        child: const Center(
          child: Icon(Icons.image),
        ),
      ),
    );
  }
  _passportImage(){
    return Container(
      height: 200,
      width: 200,
      decoration:
    BoxDecoration(border: Border.all(color: Colors.black, width: 2)),
      child: Image.file(File(_xFile?.path ?? ""),fit: BoxFit.cover,),
    );
  }
  void _savePassports() {
    final newPassport = Passport(null, _fullName.text, _homeAddress.text, _city.text, _xFile?.path, _passportExpireDate.text, _passportGotDate.text);
    SqlHelper.saveNewPassport(newPassport).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('save')));
      Navigator.of(context).pushAndRemoveUntil(CupertinoPageRoute(builder: (context)=>const MainPage()), (route) => false);
    });
  }
}
