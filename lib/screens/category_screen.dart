import 'package:btl_kiemtra_flutter/bloc/category_bloc.dart';
import 'package:btl_kiemtra_flutter/enums/category_type_enum.dart';
import 'package:btl_kiemtra_flutter/extensions/category_type_ext.dart';
import 'package:btl_kiemtra_flutter/extensions/text_style_ext.dart';
import 'package:btl_kiemtra_flutter/models/category_item.dart';
import 'package:btl_kiemtra_flutter/screens/movie_screen.dart';
import 'package:btl_kiemtra_flutter/shared/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {

  late final List<CategoryType> topItems;
  final CategoryBloc _categoryBLoc = CategoryBloc();

  @override
  void initState() {
    topItems = [
      CategoryType.channels,
      CategoryType.trending,
      CategoryType.series,
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(appPadding),
      child: Column(
        children: [
          SizedBox(
            height: 40,
            child: _buildTopFilter(context),
          ),
          Expanded(
            child: StreamBuilder<List<CategoryItem>>(
              initialData: _categoryBLoc.initCategories,
              stream: _categoryBLoc.listCategoryItemStream,
              builder: (context, snapshot) {
                return _buildList(context, snapshot.data ?? []);
              }
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTopFilter(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: topItems.length,
      itemBuilder: (context, index) {
        final double marginRight = (index + 1) == topItems.length ? 0 : appMargin;
        return StreamBuilder<CategoryType>(
          initialData: _categoryBLoc.initCategory,
          stream: _categoryBLoc.categoryStream,
          builder: (context, snapshot) {
            return GestureDetector(
              child: Container(
                margin: EdgeInsets.only(right: marginRight),
                child: Text(
                  topItems[index].getName(),
                  style: topItems[index] == snapshot.data
                  ? const TextStyle().title
                  : const TextStyle().titleWhite
                ),
              ),
              onTap: (){
                _categoryBLoc.changeCategory(topItems[index]);
              },
            );
          }
        );
      },
    );
  }

  Widget _buildList(BuildContext context, List<CategoryItem> categories) {
    final items = categories;
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: appMargin,
        crossAxisSpacing: appMargin,
        crossAxisCount: 2,
        mainAxisExtent: 340,
      ),
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        final item = categories[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            GestureDetector(
              child: Container(
                margin: const EdgeInsets.only(bottom: 10),
                width: double.infinity,
                height: 220,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(appRadius)),
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(item.image)
                  ),
                ),
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const MovieScreen())
                );
              },
            ),
            SizedBox(
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: GestureDetector(
                      child: Text(item.title, style: const TextStyle().itemTitle),
                      onTap: () {
                        Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const MovieScreen())
                      );
                      },
                    )
                  ),
                  SizedBox(
                    width: 25,
                    child: GestureDetector(
                      child: Icon(
                        CupertinoIcons.hand_thumbsup_fill,
                        color: item.isLiked ? colorRed : colorPrimaryLight
                      ),
                      onTap: () {
                        _categoryBLoc.toggleLike(index);
                      },
                    ),
                  )
                ],
              )
            ),
            SizedBox(height: 40, child: Text(item.subTitle, style: const TextStyle().itemSubTitle)),
            SizedBox(height: 30, child: Text(item.channelCounter, style: const TextStyle().itemChannelCounter)),
          ],
        );
      }
    );
  }
}