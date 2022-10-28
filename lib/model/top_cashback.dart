class CashBack {
  String? cashback_percent;
  String? date;
  String? image_url;
  String? offer_percent;
  String? link;
  CashBack({
    required this.cashback_percent,
    required this.date,
    required this.image_url,
    required this.offer_percent,
    required this.link,
  });
}

class Amazon {
  String? link;
  String? image_url;
  Amazon({
    required this.link,
    required this.image_url,
  });
}

class TopOffer {
  String? link;
  String? image_url;
  String? title;
  TopOffer({required this.link, required this.image_url, required this.title});
}

class SliderClass {
  String? image_url;
  SliderClass({
    required this.image_url,
  });
}
