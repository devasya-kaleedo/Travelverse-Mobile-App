import 'package:flutter/material.dart';
import 'package:travelverse_mobile_app/src/my_quotes/my_quotes_2.dart';
import 'package:travelverse_mobile_app/src/utils/call.dart';
import 'package:travelverse_mobile_app/src/utils/datetime.dart';

class ItineraryApp {
  int? id;
  String? startDate;
  String? endDate;
  int? travelDays;
  String? placesToTravel;
  int? adults;
  int? children;
  String? country;
  String? createdAt;
  String? updatedAt;
  String? publishedAt;
  String? discounts_complimentaries;
  List<Map<String, dynamic>>? itineraryDays;
  Map<String, dynamic>? inclusions;
  Map<String, dynamic>? exclusions;
  Map<String, dynamic>? image;
  Map<String, dynamic>? voucher_doc;

  ItineraryApp(
      {this.startDate,
      this.endDate,
      this.travelDays,
      this.placesToTravel,
      this.adults,
      this.children,
      this.country,
      this.createdAt,
      this.updatedAt,
      this.publishedAt,
      this.discounts_complimentaries,
      this.inclusions,
      this.exclusions,
      this.image,
      this.voucher_doc});

  ItineraryApp.fromJson(Map<String, dynamic> json) {
    startDate = json['start_date'];
    endDate = json['end_date'];
    travelDays = json['travel_days'];
    placesToTravel = json['places_to_travel'];
    adults = json['adults'];
    children = json['children'];
    country = json['country'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    publishedAt = json['publishedAt'];
    discounts_complimentaries = json['discounts_complimentaries'];
    inclusions = json['inclusions'];
    exclusions = json['exclusions'];
    image = json['image'];
    voucher_doc = json['voucher_doc'];
    //itineraryDays = json['itinerary_days'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['travel_days'] = this.travelDays;
    data['places_to_travel'] = this.placesToTravel;
    data['adults'] = this.adults;
    data['children'] = this.children;
    data['country'] = this.country;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['publishedAt'] = this.publishedAt;
    data['discounts_complimentaries'] = this.discounts_complimentaries;
    data['inclusions'] = this.inclusions;
    data['exclusions'] = this.exclusions;
    data['image'] = this.image;
    data['voucher_doc'] = this.voucher_doc;
    //data['itinerary_days'] = this.itineraryDays;
    return data;
  }

  static ItineraryApp fromStrapiResponse(Map<String, dynamic> data) {
    Map<String, dynamic> attributes = data['attributes'];

    ItineraryApp itineraryApp = ItineraryApp.fromJson(attributes);

    if (attributes.containsKey('itinerary_days')) {
      List<Map<String, dynamic>> itinerary_days = <Map<String, dynamic>>[];
      List<dynamic> res_days = attributes['itinerary_days']['data'];
      res_days.forEach((day) {
        Map<String, dynamic> mapped_day = {};
        mapped_day['id'] = day['id'];
        mapped_day['date'] = day['attributes']['date'];
        mapped_day['day_items'] = day['attributes']['day_items'];
        itinerary_days.add(mapped_day);
      });
      itineraryApp.itineraryDays = itinerary_days;
    }
    itineraryApp.id = data['id'];
    return itineraryApp;
  }

  static Widget getDayItemChildren(Map<String, dynamic> dayItem) {
    switch (dayItem['__component']) {
      case 'flight.flight':
        return Padding(
          padding: const EdgeInsets.only(left: 55),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Wrap(
                    direction: Axis.vertical,
                    crossAxisAlignment: WrapCrossAlignment.start,
                    children: [
                      Text('From',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF6f6f6f))),
                      Text(dayItem['departure']!,
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF6f6f6f))),
                      Text(
                          dayItem['departureTime'] != null
                              ? formatDateTime(dayItem['departureTime'])
                              : '',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF6f6f6f)))
                    ],
                  ),
                  Wrap(
                    direction: Axis.vertical,
                    children: [
                      Text(
                        'To',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF6f6f6f)),
                      ),
                      Text(dayItem['arrival'],
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF6f6f6f))),
                      Text(
                          dayItem['arrivalTime'] != null
                              ? formatDateTime(dayItem['arrivalTime'])
                              : '',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF6f6f6f)))
                    ],
                  )
                ],
              ),
              if (dayItem['file']?['data']?['attributes'] != null)
                ActionButton(
                    callback: () {
                      openFile(dayItem['file']['data']['attributes']['url'],
                          dayItem['file']['data']['attributes']['name']);
                    },
                    title: 'Download',
                    iconAsset: 'assets/images/PDFIcon.png'),
              if (dayItem['meals'] != null)
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                      'MEALS: ${dayItem['meals']!} ${dayItem['mealsPreference']!}',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF6f6f6f))),
                ),
              if (dayItem['additional_text'] != null)
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('${dayItem['additional_text']!}',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF6f6f6f))),
                ),
            ],
          ),
        );
      case 'transportation.transportations':
        List<String> detailsList = dayItem['additionalDetails'] != null
            ? dayItem['additionalDetails']!.split('\n')
            : [];
        return Padding(
          padding: const EdgeInsets.only(left: 55),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Wrap(
                    direction: Axis.vertical,
                    crossAxisAlignment: WrapCrossAlignment.start,
                    children: [
                      Text('From',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF6f6f6f))),
                      Text(dayItem['departure'],
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF6f6f6f)))
                    ],
                  ),
                  Wrap(
                    direction: Axis.vertical,
                    children: [
                      Text('To',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF6f6f6f))),
                      Text(dayItem['arrival'],
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF6f6f6f)))
                    ],
                  ),
                ],
              ),
              if (dayItem['contactDetailsPhone'] != null &&
                  dayItem['contactDetailsPhone'] != '')
                ActionButton(
                    callback: () {
                      launchCaller('tel:${dayItem['contactDetailsPhone']}');
                    },
                    title: 'Contact',
                    iconAsset: 'assets/images/PhoneIcon.png'),
              if (dayItem['file']?['data']?['attributes'] != null)
                ActionButton(
                    callback: () {
                      openFile(dayItem['file']['data']['attributes']['url'],
                          dayItem['file']['data']['attributes']['name']);
                    },
                    title: 'Download',
                    iconAsset: 'assets/images/PDFIcon.png'),
              Wrap(direction: Axis.vertical, children: [
                SizedBox(
                  height: 12,
                ),
                ...detailsList
                    .map((item) => Text(item,
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF6f6f6f))))
                    .toList(),
                if (dayItem['additional_text'] != null)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('${dayItem['additional_text']!}',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF6f6f6f))),
                  ),
              ])
            ],
          ),
        );
      case 'stay.stay':
        return Padding(
          padding: EdgeInsets.only(left: 55),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (dayItem['name'] != null && dayItem['name'] != '')
                Text('${dayItem['name']!}',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF6f6f6f))),
              if (dayItem['category'] != null && dayItem['category'] != '')
                Text('${dayItem['category']!}',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF6f6f6f))),
              if (dayItem['breakfast'] != null && dayItem['breakfast'] != '')
                Text('Breakfast : ${dayItem['breakfast']!}',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF6f6f6f))),
              if (dayItem['address'] != null && dayItem['address'] != '')
                ActionButton(
                  callback: () {
                    launchMap(dayItem['address']);
                  },
                  title: 'Get Directions',
                  iconAsset: 'assets/images/BedIcon.png',
                ),
              if (dayItem['file']?['data']?['attributes'] != null)
                ActionButton(
                    callback: () {
                      openFile(dayItem['file']['data']['attributes']['url'],
                          dayItem['file']['data']['attributes']['name']);
                    },
                    title: 'Download',
                    iconAsset: 'assets/images/PDFIcon.png'),
              if (dayItem['additionalDetails'] != null)
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('${dayItem['additionalDetails']!}',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF6f6f6f))),
                ),
            ],
          ),
        );

      case 'activities.activities':
        switch (dayItem['category']) {
          case 'Food':
            return Column(
              children: [
                if (dayItem['address'] != null && dayItem['address'] != '')
                  ActionButton(
                    callback: () {
                      launchMap(dayItem['address']);
                    },
                    title: 'Get Directions',
                    iconAsset: 'assets/images/CompassIcon.png',
                  ),
                if (dayItem['file']?['data']?['attributes'] != null)
                  ActionButton(
                      callback: () {
                        openFile(dayItem['file']['data']['attributes']['url'],
                            dayItem['file']['data']['attributes']['name']);
                      },
                      title: 'Download',
                      iconAsset: 'assets/images/PDFIcon.png'),
                if (dayItem['description'] != null)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('${dayItem['description']!}',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF6f6f6f))),
                  ),
              ],
            );
          case 'Explore':
          default:
            return Column(
              children: [
                if (dayItem['address'] != null && dayItem['address'] != '')
                  ActionButton(
                    callback: () {
                      launchMap(dayItem['address']);
                    },
                    title: 'Get Directions',
                    iconAsset: 'assets/images/CompassIcon.png',
                  ),
                if (dayItem['file']?['data']?['attributes'] != null)
                  ActionButton(
                      callback: () {
                        openFile(dayItem['file']['data']['attributes']['url'],
                            dayItem['file']['data']['attributes']['name']);
                      },
                      title: 'Download',
                      iconAsset: 'assets/images/PDFIcon.png'),
                if (dayItem['description'] != null)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('${dayItem['description']!}',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF6f6f6f))),
                  ),
              ],
            );
        }
      default:
        return SampleItem();
    }
  }
}

class SampleItem extends StatelessWidget {
  const SampleItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Wrap(
                direction: Axis.vertical,
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(right: 70, left: 12),
                            backgroundColor: Color(0xFF03C3DF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            )),
                        child: Wrap(
                          direction: Axis.horizontal,
                          alignment: WrapAlignment.start,
                          runAlignment: WrapAlignment.start,
                          spacing: 11.5,
                          children: [
                            Align(
                              child: Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                    border: Border.all(color: Colors.black)),
                                child: Center(
                                    child: Image.asset(
                                  'assets/images/CompassIcon.png',
                                  width: 17,
                                )),
                              ),
                            ),
                            Text('Action',
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white))
                          ],
                        ),
                      )
                    ],
                  ),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 12,
                        ),
                        ...['Taxi Number:ZUR DT 3210']
                            .map((item) => Text(item,
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF6f6f6f))))
                            .toList()
                      ])
                ],
              ),
              SizedBox(height: 14.5),
              Padding(
                padding: const EdgeInsets.only(right: 40),
                child: Divider(
                    thickness: 1, color: Color(0xFF707070).withOpacity(0.21)),
              )
            ],
          ),
        )
      ],
    );
  }
}

class ActionButton extends StatelessWidget {
  const ActionButton(
      {super.key,
      required this.title,
      required this.iconAsset,
      required this.callback});
  final String title;
  final String iconAsset;
  final VoidCallback callback;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        callback();
      },
      style: ElevatedButton.styleFrom(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(right: 70, left: 12),
          backgroundColor: Color(0xFF03C3DF),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          )),
      child: Row(
        children: [
          Image.asset(
            iconAsset,
            width: 17,
            fit: BoxFit.contain,
          ),
          SizedBox(
            width: 12,
          ),
          Text(title,
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white))
        ],
      ),
    );
  }
}
