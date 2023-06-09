import 'package:flutter/material.dart';

import '../../home.dart';
import '../../login.dart';
import '../../../../mainPage.dart';
import '../../../../tests/login_page.dart';
import 'content_boarding.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  int currentPage = 0;
  late PageController varController;

  @override
  void initState() {
    super.initState();
    varController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    super.dispose();
    varController.dispose();
  }

  List<Map<String, String>> listBoarding = [
    {
      "titulo": "Bienvenido!",
      "imagen": "assets/images/boardin.png",
      "descripcion": "Sitio donde hayarás modelos de redes neuronales",
    },
    {
      "titulo": "Comienza tu aventura",
      "imagen": "assets/images/logo.png",
      "descripcion": "BrainBits te aguarda",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 600,
            child: PageView.builder(
              controller: varController,
              onPageChanged: (value) {
                setState(() {
                  currentPage = value;
                });
              },
              itemBuilder: (context, index) => ContentBoarding(
                text: listBoarding[index]['titulo'],
                image: listBoarding[index]['imagen'],
                descripcion: listBoarding[index]['descripcion'],
              ),
              itemCount: listBoarding.length,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(listBoarding.length,
                (index) => pages(index: index, currentePage: currentPage)),
          ),
          SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: SizedBox(
                    height: 50,
                    width: 300,
                    child: MaterialButton(
                      color: currentPage == listBoarding.length - 1
                          ? Colors.orange
                          : Colors.white,
                      onPressed: () async {
                        currentPage == listBoarding.length - 1
                            ? Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (_) => MainPage()))
                            : varController.nextPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeInOut);
                      },
                      textColor: currentPage == listBoarding.length - 1
                          ? Colors.white
                          : Colors.grey,
                      shape: RoundedRectangleBorder(
                          side: const BorderSide(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(
                          currentPage == listBoarding.length - 1
                              ? 'Continuar'
                              : "Siguiente",
                          style: const TextStyle(fontSize: 16)),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

AnimatedContainer pages({required int index, required int currentePage}) {
  return AnimatedContainer(
    margin: const EdgeInsets.only(right: 5),
    width: currentePage == index ? 30 : 20,
    height: 5,
    duration: kThemeAnimationDuration,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: currentePage == index
            ? Colors.orange
            : const Color.fromARGB(255, 175, 171, 171)),
  );
}
