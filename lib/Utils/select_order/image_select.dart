String selectImageOrder(String orderType) {
  String icon;
  if (orderType == 'Dyshez Direct') {
    icon = 'assets/images/dyshezDirect.png';
    return icon;
  } else if (orderType == 'Promo Live') {
    icon = 'assets/images/promoLive.png';
    return icon;
  } else {
    icon = 'assets/images/defaultIcon.png';
    return icon;
  }
}
