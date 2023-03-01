import 'package:btl_kiemtra_flutter/data/movie.dart';
import 'package:btl_kiemtra_flutter/extensions/text_style_ext.dart';
import 'package:btl_kiemtra_flutter/models/movie_item.dart';
import 'package:btl_kiemtra_flutter/screens/movie_screen.dart';
import 'package:btl_kiemtra_flutter/shared/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlaylistAddScreen extends StatelessWidget {
  const PlaylistAddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(appPadding),
      child: Column(
        children: [
          Text('Playlist movies', style: const TextStyle().title),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: _buildList(context, likedMovies),
          ),
        ],
      ),
    );
  }
  Widget _buildList(BuildContext context, List<MovieItem> categories) {
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
        return GestureDetector(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
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
              SizedBox(
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(child: Text(item.title, style: const TextStyle().itemTitle)),
                    SizedBox(
                      width: 25,
                      child: Icon(
                        CupertinoIcons.hand_thumbsup_fill,
                        color: item.isLiked ? colorRed : colorPrimaryLight
                      ),
                    )
                  ],
                )
              ),
              SizedBox(height: 40, child: Text(item.subTitle, style: const TextStyle().itemSubTitle)),
            ],
          ),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const MovieScreen())
            );
          },
        );
      }
    );
  }
}