import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: Image.asset(
                'resources/images/grimoire_bg.jpg',
              ).image,
              fit: BoxFit.cover),
        ),
        alignment: Alignment.center,
        child: SizedBox(
          width: isPortrait ? 500 : 640,
          child: Column(
            children: [
              const Spacer(
                flex: 1,
              ),
              Image.asset(
                'resources/icons/grimoire_logo_bw.png',
                scale: 2.5,
              ),
              const Spacer(
                flex: 1,
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: TextField(
                  decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(32))),
                      labelText: 'What do you seek ?'),
                ),
              ),
              const Spacer(flex: 1,),
              Row(
                children: [
                  appsContainer(),
                  const Spacer(),
                  appsContainer(),
                  const Spacer(),
                  appsContainer(),
                ],
              ),
              const Spacer(
                flex: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget appsContainer() {
    return Container(
                  width: 128,
                  height: 128,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 111, 86, 120),
                    borderRadius: BorderRadius.all(Radius.circular(16))
                  ),
                  child: Image.asset(
                    'resources/icons/grimoire_logo_bw.png',
                    scale: 10,
                  ),
                );
  }
}
