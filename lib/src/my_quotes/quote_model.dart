class QuoteApp {
  int id;
  String country;
  Map<String, dynamic>? quote;

  QuoteApp(this.id, this.country, this.quote);

  static QuoteApp fromStrapiResponse(Map<String, dynamic> data) {
    return QuoteApp(
        data['id'], data['attributes']['country'], data['attributes']['quote']);
  }
}
