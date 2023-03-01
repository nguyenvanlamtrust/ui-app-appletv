import 'package:btl_kiemtra_flutter/shared/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MovieScreen extends StatelessWidget {

  const MovieScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
              child: SizedBox(
                width: double.infinity,
                child: Image.network(
                    'https://upload.wikimedia.org/wikipedia/en/0/0d/Avengers_Endgame_poster.jpg',
                    fit: BoxFit.fill,
                  ),
              ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.4,
                color: colorPrimary,
              ),
            ],
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.3,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: 40,
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  border: Border.all(color: colorPrimaryLight, width: 2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(CupertinoIcons.play_arrow_solid, size: 16),
              ),
            ),
          ),
          Positioned(
            top: appMargin * 3,
            left: appMargin,
            right: appMargin,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  child: const Icon(Icons.arrow_back_ios_new, size: 20,),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                Container(
                  width: 40,
                  height: 40,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle
                  ),
                  child: const Icon(Icons.thumb_up_alt_sharp, color: colorPrimaryLight, size: 20,),
                ),
              ],
            ),
          ),
          
          Positioned(
            left: 0,
            right: 0,
            bottom: 0, 
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.45,
              margin: const EdgeInsets.all(appMargin),
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    //color: colorPrimaryLight.withOpacity(0.2),
                    //spreadRadius: 5,
                    blurRadius: 10,
                    //offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
                color: colorPrimary,
                borderRadius: BorderRadius.all(Radius.circular(appRadius))
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(appPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 6),
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                color: colorYellow,
                                borderRadius: BorderRadius.all(Radius.circular(4))
                              ),
                              child: const Text('IMDb', style: TextStyle(color: Colors.white, fontSize: 12)),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 7),
                              child: const Text('8.6', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12),)
                            ),
                            Container(
                              padding: const EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: colorPrimaryLight,
                                  width: 2,
                                ),
                                borderRadius: const BorderRadius.all(Radius.circular(4))
                              ),
                              child: const Text('PC-16', style: TextStyle(color: colorPrimaryLight, fontWeight: FontWeight.bold, fontSize: 12)),
                            ),
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: const Text(
                            'Avengers: Endgame',
                            style: TextStyle(fontSize: 18, overflow: TextOverflow.ellipsis),
                          ),
                        ),
                        const Text(
                          'USA, 2019 / 2h 10min',
                          style: TextStyle(
                            color: Colors.grey
                          ),
                        ),
                        const Text(
                          'Action, Fantocy',
                          style: TextStyle(
                            color: colorPrimaryLight
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(appPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('More Movies', style: TextStyle(color: Colors.white)),
                          const SizedBox(height: 10,),
                          Expanded(
                            child: _buildBottomSlider(context),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 50,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(appRadius)
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          colorRed,
                          colorRedLight,
                        ],
                      )
                    ),
                    child: const Text(
                      'Watch now',
                      style: TextStyle(
                        fontSize: 20
                      )
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<String> get _bottomSliderData => [
    'assets/113x136/pic2.png',
    'assets/113x136/pic1.png',
    'assets/113x136/pic3.png',
    'assets/113x136/pic1.png',
    'assets/113x136/pic2.png',
    'assets/113x136/pic3.png',
  ];

  Widget _buildBottomSlider(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: _bottomSliderData.length,
      itemBuilder: (ctx, index) {
        final double marginRight = ((index + 1) == _bottomSliderData.length) ? 0 : appMargin;
        return Container(
          margin: EdgeInsets.only(right: marginRight),
          width: 90,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(appRadius)),
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage(
                _bottomSliderData[index],
              )
            ),
          ),
        ); 
      },
    );
  }
}