import 'package:btl_kiemtra_flutter/enums/category_type_enum.dart';

extension CategoryTypeExtension on CategoryType {
  String getName() {
    switch (this) {
      case CategoryType.featured:
        return 'Featured';

      case CategoryType.newRelease:
        return 'New Release';

      case CategoryType.series:
        return 'Series';

      case CategoryType.channels:
        return 'Channels';

      case CategoryType.trending:
        return 'Trending';

      default:
        return '';
    }
  }

  int index() {
    switch (this) {
      case CategoryType.featured:
        return 0;

      case CategoryType.newRelease:
        return 1;

      case CategoryType.series:
        return 2;

      case CategoryType.channels:
        return 3;

      case CategoryType.trending:
        return 4;

      default:
      return -1;
    }
  }
}