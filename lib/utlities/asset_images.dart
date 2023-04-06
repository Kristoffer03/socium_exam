class AssetImages {
  AssetImages._();

  static String _getAssetIconSvg(String fileName) => 'assets/images/$fileName.svg';

  static String _getAssetIconPng(String fileName) => 'assets/images/$fileName.png';

  static String _getAssetIconJpg(String fileName) => 'assets/images/$fileName.jpg';

  static String icCheck = _getAssetIconPng('ic_check');

  static String icX = _getAssetIconPng('ic_x');

  static String icTag = _getAssetIconPng('ic_tag');

  static String icGlass = _getAssetIconPng('ic_glass');

  static String icAlcoholic = _getAssetIconPng('ic_alcoholic');
}
