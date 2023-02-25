import 'package:btl_kiemtra_flutter/bloc/dashboard_bloc.dart';
import 'package:btl_kiemtra_flutter/enums/category_type_enum.dart';
import 'package:btl_kiemtra_flutter/extensions/category_type_ext.dart';
import 'package:btl_kiemtra_flutter/extensions/text_style_ext.dart';
import 'package:btl_kiemtra_flutter/screens/movie_screen.dart';
import 'package:btl_kiemtra_flutter/shared/constants.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  final DashboardBloc _dashboardBloc = DashboardBloc();

  late final List<CategoryType> topItems;

  @override
  void initState() {
    topItems = [
      CategoryType.featured,
      CategoryType.newRelease,
      CategoryType.series,
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(appPadding),
      child: StreamBuilder<List<String>>(
        initialData: _dashboardBloc.images,
        stream: _dashboardBloc.streamImage,
        builder: (context, snapshot) {
          return Column(
            children: [
              Expanded(
                child: _buildTopSlider(context, snapshot.data ?? []),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.20,
                child: _buildBottomSlider(context),
              ),
            ],
          );
        }
      ),
    );
  }

  List<Widget> indicators(imagesLength, currentIndex) {
    return List<Widget>.generate(imagesLength, (index) {
      return Container(
        margin: const EdgeInsets.only(top: 3, left: 3, right: 3, bottom: 10),
        width: currentIndex == index ? 10 : 7,
        height: currentIndex == index ? 10 : 7,
        decoration: BoxDecoration(
          color: currentIndex == index ? Colors.white : Colors.grey,
          shape: BoxShape.circle
        ),
      );
    });
  }
  
  Widget _buildTopSlider(BuildContext context, List<String> images) {
    return Column(
      children: [
        SizedBox(
          height: 40,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: topItems.length,
            itemBuilder: (BuildContext context, int index) { 
              return StreamBuilder<CategoryType>(
                initialData: _dashboardBloc.initCategoryType,
                stream: _dashboardBloc.streamCategoryType,
                builder: (context, snapshot) {
                  return GestureDetector(
                    child: Container(
                      margin: const EdgeInsets.only(right: 10),
                      child: Text(
                        topItems[index].getName(),
                        style: snapshot.data == topItems[index]
                        ? const TextStyle().title
                        : const TextStyle().titleWhite
                      ),
                    ),
                    onTap: () {
                      _dashboardBloc.changeCategoryType(topItems[index]);
                    }
                  );
                }
              );
            },
          ),
        ),
        Expanded(
          child: Stack(
            children: [
              StreamBuilder<int>(
                initialData: _dashboardBloc.initActivePage,
                stream: _dashboardBloc.streamActivePage,
                builder: (context, snapshot) {
                  return PageView.builder(
                    itemCount: _dashboardBloc.images.length,
                    pageSnapping: true,
                    controller: _dashboardBloc.pageController,
                    onPageChanged: (page) {
                      _dashboardBloc.changeActivePage(page);
                    },
                    itemBuilder: (BuildContext context, int pagePosition) {
                      return GestureDetector(
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(
                                _dashboardBloc.images[pagePosition],
                              )
                            ),
                            borderRadius: const BorderRadius.all(Radius.circular(appRadius)),
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => const MovieScreen())
                          );
                        },
                      );
                    },
                  );
                }
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: StreamBuilder<int>(
                    initialData: _dashboardBloc.initActivePage,
                    stream: _dashboardBloc.streamActivePage,
                    builder: (context, snapshot) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: indicators(_dashboardBloc.images.length, snapshot.data ?? _dashboardBloc.initActivePage)
                      );
                    }
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10,),
      ],
    );
  }
  
  Widget _buildBottomSlider(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: const Text('What to watch', style:  TextStyle(color: colorRed, fontSize: 20)),
        ),
        Expanded(
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _bottomSliderData.length,
            itemBuilder: (ctx, index) {
              final double marginRight = ((index + 1) == _bottomSliderData.length) ? 0 : 15;
              return GestureDetector(
                child: Container(
                  margin: EdgeInsets.only(right: marginRight),
                  width: 105,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(appRadius)),
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage(
                        _bottomSliderData[index],
                      )
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const MovieScreen())
                  );
                },
              ); 
            },
          ),
        ),
      ],
    );
  }
  
  List<String> get _bottomSliderData => [
    'assets/113x136/pic1.png',
    'assets/113x136/pic2.png',
    'assets/113x136/pic3.png',
    'assets/113x136/pic1.png',
    'assets/113x136/pic2.png',
    'assets/113x136/pic3.png',
  ];
}