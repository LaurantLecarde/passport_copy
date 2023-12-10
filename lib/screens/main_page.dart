import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:passport_copy/db/sql_helper.dart';
import 'package:passport_copy/model/passport.dart';
import 'package:passport_copy/screens/add_page.dart';
import 'package:passport_copy/screens/detail_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: SqlHelper.getAllPassport(),
        builder: (context, snapshot){
          if(snapshot.data != null && snapshot.data?.isNotEmpty == true){
            final list = snapshot.data?.reversed.toList();
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index){
                final p =list?[index];
                return ListTile(
                  onTap: (){Navigator.of(context).push(CupertinoPageRoute(builder: (context)=>DetailPage(passport: p)));},
                  leading: Text("${index +1}",style: const TextStyle(fontSize: 20,color: Colors.black),),
                  title: Text(p?.fullName ?? "",style: TextStyle(fontSize: 20,color: Colors.black),),
                  subtitle:  Text(p?.city ?? "",style: TextStyle(fontSize: 20,color: Colors.black),),
                  trailing: IconButton(
                    onPressed: (){
                      _showActionSheet(p);
                    },
                    icon: Icon(Icons.more_vert_sharp),
                  ),
                );
              },
            );
          }else if (snapshot.data?.isEmpty == true){
            return Center(child: Icon(CupertinoIcons.clock),);
          }else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(onPressed: (){setState(() {

                  });}, child: Text('Refresh')),
                  CupertinoActivityIndicator(),
                ],
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()=>Navigator.of(context).push(CupertinoPageRoute(builder: (context)=>AddScreen())),
        child: Icon(Icons.add),
      ),
    );
  }
  void _deletePassport(int? id,BuildContext context){
    SqlHelper.deletePassport(id).then((value) {
      setState(() {});
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Deleted')));
    });
  }
  void _updatePassport(int? id){
    SqlHelper.updatePassport(id, Passport(id, 'fullName', 'address', 'city', 'image', 'passportExpire', 'passportGot')).then((value) {
      setState(() {});
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Updated')));
    });
  }
  void _showActionSheet(Passport? passport) {
    showCupertinoModalPopup(context: context, builder: (context) => CupertinoActionSheet(
      actions: [
        CupertinoActionSheetAction(
          onPressed: () {
            Navigator.of(context).pop();
            _updatePassport(passport?.id);
          }, child: Text("Update"),
        ),
        CupertinoActionSheetAction(
          isDestructiveAction: true,
          onPressed: () {
            Navigator.of(context).pop();
            _deletePassport(passport?.id, context);
          }, child: Text("Delete"),
        ),
      ],
    ));
  }
}
