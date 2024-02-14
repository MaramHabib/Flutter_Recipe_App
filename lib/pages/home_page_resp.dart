import 'package:flutter/material.dart';

class HomePageResp extends StatefulWidget {
  const HomePageResp({super.key});

  @override
  State<HomePageResp> createState() => _HomePageRespState();
}

class _HomePageRespState extends State<HomePageResp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:Drawer(
        child:Column(
          children:[
            UserAccountsDrawerHeader(
                accountName: Text("Maram Ashraf"),
                accountEmail: Text("maram@gmail.com"),
            currentAccountPicture:CircleAvatar(
              child:Text('M')
            ))
          ]
        )
      ),
      appBar: AppBar(
        title:Text("Resposive Home Page"),
      ),
      body:Center(
        child:Column(
          children: [
            // MediaQuery.of(context).size.width > 700
            // ? const Text("Desktop View")
            // : MediaQuery.of(context).size.width >500
            //   ? const Text("Tablet View")
            //   : const Text("Mobile View")

            ...List.generate(15,
                (index) => Card(
                  child:ListTile(
                    title: Text('title : $index'),
                    subtitle: Text('desc : $index'),
                  )
                ))
          ],
        )
      )
    );
  }
}

Widget desktopView(){
  return Scaffold(
    body:Row(
      children:[
        Expanded(flex:1,child:Container()),
        Expanded(flex:3,
            child:Column())

      ]
    )
  );
}
