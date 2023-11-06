import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/home_viewmodel.dart';

class ResponseView extends StatelessWidget {
  const ResponseView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, model, child) => Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomRight,
          colors: [Color(0xff0B1526), Color(0xff423757), Color(0xff4C759A)],
        )),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            centerTitle: true,
            title: Image.asset(
              'assets/images/logo.png',
              fit: BoxFit.cover,
              width: 150,
            ),
            toolbarHeight: 150,
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
                model.response = [];
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Image.asset('assets/images/back.png', fit: BoxFit.scaleDown),
              ),
            ),
          ),
          body: ListView.builder(
            itemCount: model.response.length,
            itemBuilder: (context, index) {
              // return ListTile(
              //   title: Text(model.response[index]),
              // );
              return item(model.response[index]);
            },
          ),
        ),
      ),
    );
  }
}

Widget item(text) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: text.length < 35 ? 60.0 : 20 , vertical: 40),
    child: Row(
      children: [
        Image.asset(
          'assets/images/start.png',
          fit: BoxFit.cover,
          width: 50,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: Text(
              text,
              textAlign: TextAlign.center,
              maxLines: 3,
              style: TextStyle(color: Colors.white,
                overflow: TextOverflow.ellipsis,),
            ),
          ),
        ),
        Image.asset(
          'assets/images/end.png',
          fit: BoxFit.cover,
          width: 50,
        ),
      ],
    ),
  );
}
