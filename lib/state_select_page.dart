import 'package:flutter/material.dart';
import 'booking_page.dart';
import 'dart:math';
String? selectedCountry;
String? selectedState;
List<Hotel> hotels = [];



class Hotel {
  final String name;
  final String location;
  final double rating;
  final String imageUrl;
  final String distance;
  final double price;
  final bool isBestRated;
  final bool isAwarded;
  final bool isOnlyOneLeft;
  final bool isMegaSale;
  final bool isFreeCancellation;
  final bool isDomesticDeal;

  Hotel({
    required this.name,
    required this.location,
    required this.rating,
    required this.imageUrl,
    required this.distance,
    required this.price,
    this.isBestRated = false,
    this.isAwarded = false,
    this.isOnlyOneLeft = false,
    this.isMegaSale = false,
    this.isFreeCancellation = false,
    this.isDomesticDeal = false,
  });
}

class StateSelectionPage extends StatefulWidget {
  const StateSelectionPage({Key? key}) : super(key: key);

  @override
  State<StateSelectionPage> createState() => _StateSelectionPageState();
}

class _StateSelectionPageState extends State<StateSelectionPage> {
  final Map<String, List<String>> countryStates = {
    "Malaysia": ["Kuala Lumpur", "Petaling Jaya", "Penang", "Johor", "Sabah", "Sarawak"],
    "Thailand": ["Bangkok", "Phuket", "Chiang Mai", "Pattaya"],
    "Indonesia": ["Bali", "Jakarta", "Surabaya", "Yogyakarta"],
    "Vietnam": ["Hanoi", "Ho Chi Minh City", "Da Nang", "Nha Trang"],
    "Cambodia": ["Phnom Penh", "Siem Reap", "Sihanoukville"],
    "Singapore": ["Singapore City"],
    "USA": ["California", "Texas", "Florida", "New York", "Nevada"],
    "India": ["Delhi", "Maharashtra", "Karnataka", "Tamil Nadu", "Gujarat", "Punjab"],
    "Australia": ["Sydney", "Melbourne", "Brisbane", "Perth"],
    "Japan": ["Tokyo", "Osaka", "Kyoto", "Hokkaido"],
    "France": ["Paris", "Nice", "Lyon"],
  };

  final Map<String, Map<String, List<Hotel>>> hotelData = {
    "Malaysia": {
      "Kuala Lumpur": [
        Hotel(
          name: "Sunway Pyramid Hotel",
          location: "Bandar Sunway, Kuala Lumpur - 12.1 km to center",
          rating: 8.4,
          imageUrl: "https://example.com/sunway_pyramid.jpg",
          distance: "12.1 km to center",
          price: 100 + Random().nextDouble() * 300,
          isOnlyOneLeft: true,
          isMegaSale: true,
          isFreeCancellation: true,
        ),
        Hotel(
          name: "Sleeping Lion Suites",
          location: "Bukit Bintang, Kuala Lumpur - City center",
          rating: 9.0,
          imageUrl: "https://example.com/sleeping_lion.jpg",
          distance: "City center",
          price: 100 + Random().nextDouble() * 300,
          isBestRated: true,
          isFreeCancellation: true,
        ),
        Hotel(
          name: "Cititel Mid Valley Hotel",
          location: "Mid Valley / Bangsar, Kuala Lumpur - 3.1 km to center",
          rating: 8.2,
          imageUrl: "https://example.com/cititel_mid_valley.jpg",
          distance: "3.1 km to center",
          price: 100 + Random().nextDouble() * 300,
          isAwarded: true,
          isOnlyOneLeft: true,
          isDomesticDeal: true,
        ),
        Hotel(
          name: "The Majestic Hotel",
          location: "Jalan Sultan Hishamuddin, Kuala Lumpur - City center",
          rating: 8.6,
          imageUrl: "https://example.com/majestic_hotel.jpg",
          distance: "City center",
          price: 100 + Random().nextDouble() * 300,
          isBestRated: true,
          isFreeCancellation: true,
        ),
        Hotel(
          name: "Traders Hotel Kuala Lumpur",
          location: "Kuala Lumpur City Centre - City center",
          rating: 8.3,
          imageUrl: "https://example.com/traders_hotel.jpg",
          distance: "City center",
          price: 100 + Random().nextDouble() * 300,
          isDomesticDeal: true,
        ),
      ],
      "Petaling Jaya": [
        Hotel(
          name: "PJ Business Hotel",
          location: "Petaling Jaya - City center",
          rating: 8.0,
          imageUrl: "https://example.com/pj_business.jpg",
          distance: "City center",
          price: 100 + Random().nextDouble() * 300,
          isBestRated: true,
          isFreeCancellation: true,
        ),
        Hotel(
          name: "Sunway Resort Hotel",
          location: "Sunway, Petaling Jaya - Resort",
          rating: 8.5,
          imageUrl: "https://example.com/sunway_resort.jpg",
          distance: "Resort",
          price: 100 + Random().nextDouble() * 300,
          isMegaSale: true,
          isFreeCancellation: true,
        ),
        Hotel(
          name: "PJ Budget Inn",
          location: "Petaling Jaya - Budget",
          rating: 7.8,
          imageUrl: "https://example.com/pj_budget_inn.jpg",
          distance: "City center",
          price: 100 + Random().nextDouble() * 300,
          isDomesticDeal: true,
        ),
        Hotel(
          name: "The PJ Suites",
          location: "Petaling Jaya - City center",
          rating: 8.2,
          imageUrl: "https://example.com/pj_suites.jpg",
          distance: "City center",
          price: 100 + Random().nextDouble() * 300,
          isAwarded: true,
          isFreeCancellation: true,
        ),
        Hotel(
          name: "PJ Luxury Hotel",
          location: "Petaling Jaya - Luxury",
          rating: 9.0,
          imageUrl: "https://example.com/pj_luxury.jpg",
          distance: "City center",
          price: 100 + Random().nextDouble() * 300,
          isBestRated: true,
          isFreeCancellation: true,
        ),
      ],
      "Penang": [
        Hotel(
          name: "Batu Ferringhi Hotel",
          location: "Batu Ferringhi, Penang - Beachfront",
          rating: 8.7,
          imageUrl: "https://example.com/batu_ferringhi.jpg",
          distance: "Beachfront",
          price: 100 + Random().nextDouble() * 300,
          isBestRated: true,
          isFreeCancellation: true,
        ),
        Hotel(
          name: "George Town Heritage Hotel",
          location: "George Town, Penang - City center",
          rating: 8.5,
          imageUrl: "https://example.com/george_town.jpg",
          distance: "City center",
          price: 100 + Random().nextDouble() * 300,
          isAwarded: true,
          isDomesticDeal: true,
        ),
        Hotel(
          name: "Penang Beach Resort",
          location: "Batu Ferringhi, Penang - Beachfront",
          rating: 8.3,
          imageUrl: "https://example.com/penang_beach_resort.jpg",
          distance: "Beachfront",
          price: 100 + Random().nextDouble() * 300,
          isMegaSale: true,
          isFreeCancellation: true,
        ),
        Hotel(
          name: "Penang City Hotel",
          location: "George Town, Penang - City center",
          rating: 8.1,
          imageUrl: "https://example.com/penang_city_hotel.jpg",
          distance: "City center",
          price: 100 + Random().nextDouble() * 300,
          isDomesticDeal: true,
        ),
        Hotel(
          name: "Penang Luxury Suites",
          location: "George Town, Penang - Luxury",
          rating: 9.2,
          imageUrl: "https://example.com/penang_luxury_suites.jpg",
          distance: "City center",
          price: 100 + Random().nextDouble() * 300,
          isBestRated: true,
          isFreeCancellation: true,
        ),
      ],
    },
    "Thailand": {
      "Bangkok": [
        Hotel(
          name: "Bangkok Riverside Hotel",
          location: "Riverside, Bangkok - City center",
          rating: 8.5,
          imageUrl: "https://example.com/bangkok_riverside.jpg",
          distance: "City center",
          price: 100 + Random().nextDouble() * 300,
          isBestRated: true,
          isFreeCancellation: true,
        ),
        Hotel(
          name: "Sukhumvit Suites",
          location: "Sukhumvit, Bangkok - City center",
          rating: 8.2,
          imageUrl: "https://example.com/sukhumvit_suites.jpg",
          distance: "City center",
          price: 100 + Random().nextDouble() * 300,
          isDomesticDeal: true,
        ),
        Hotel(
          name: "Silom Budget Inn",
          location: "Silom, Bangkok - Budget",
          rating: 7.8,
          imageUrl: "https://example.com/silom_budget_inn.jpg",
          distance: "City center",
          price: 100 + Random().nextDouble() * 300,
          isMegaSale: true,
          isFreeCancellation: true,
        ),
      ],
      "Phuket": [
        Hotel(
          name: "Phuket Beach Resort",
          location: "Patong Beach, Phuket - Beachfront",
          rating: 8.7,
          imageUrl: "https://example.com/phuket_beach_resort.jpg",
          distance: "Beachfront",
          price: 100 + Random().nextDouble() * 300,
          isBestRated: true,
          isFreeCancellation: true,
        ),
        Hotel(
          name: "Patong Bay Hotel",
          location: "Patong, Phuket - City center",
          rating: 8.3,
          imageUrl: "https://example.com/patong_bay_hotel.jpg",
          distance: "City center",
          price: 100 + Random().nextDouble() * 300,
          isDomesticDeal: true,
        ),
        Hotel(
          name: "Phuket Budget Inn",
          location: "Karon Beach, Phuket - Budget",
          rating: 7.9,
          imageUrl: "https://example.com/phuket_budget_inn.jpg",
          distance: "City center",
          price: 100 + Random().nextDouble() * 300,
          isMegaSale: true,
          isFreeCancellation: true,
        ),
      ],
      "Chiang Mai": [
        Hotel(
          name: "Chiang Mai Riverside Hotel",
          location: "Riverside, Chiang Mai - City center",
          rating: 8.4,
          imageUrl: "https://example.com/chiang_mai_riverside.jpg",
          distance: "City center",
          price: 100 + Random().nextDouble() * 300,
          isBestRated: true,
          isFreeCancellation: true,
        ),
        Hotel(
          name: "Old City Boutique Hotel",
          location: "Old City, Chiang Mai - Boutique",
          rating: 8.1,
          imageUrl: "https://example.com/old_city_boutique.jpg",
          distance: "City center",
          price: 100 + Random().nextDouble() * 300,
          isAwarded: true,
          isFreeCancellation: true,
        ),
        Hotel(
          name: "Chiang Mai Budget Inn",
          location: "Nimmanhaemin, Chiang Mai - Budget",
          rating: 7.7,
          imageUrl: "https://example.com/chiang_mai_budget_inn.jpg",
          distance: "City center",
          price: 100 + Random().nextDouble() * 300,
          isDomesticDeal: true,
        ),
      ],
      "Pattaya": [
        Hotel(
          name: "Pattaya Beach Resort",
          location: "Beachfront, Pattaya - Resort",
          rating: 8.6,
          imageUrl: "https://example.com/pattaya_beach_resort.jpg",
          distance: "Beachfront",
          price: 100 + Random().nextDouble() * 300,
          isBestRated: true,
          isFreeCancellation: true,
        ),
        Hotel(
          name: "Central Pattaya Hotel",
          location: "Central Pattaya - City center",
          rating: 8.2,
          imageUrl: "https://example.com/central_pattaya_hotel.jpg",
          distance: "City center",
          price: 100 + Random().nextDouble() * 300,
          isDomesticDeal: true,
        ),
        Hotel(
          name: "Pattaya Budget Inn",
          location: "Pattaya - Budget",
          rating: 7.8,
          imageUrl: "https://example.com/pattaya_budget_inn.jpg",
          distance: "City center",
          price: 100 + Random().nextDouble() * 300,
          isMegaSale: true,
          isFreeCancellation: true,
        ),
      ],
    },
    "Indonesia": {
      "Bali": [
        Hotel(
          name: "Bali Beach Resort",
          location: "Kuta Beach, Bali - Beachfront",
          rating: 8.7,
          imageUrl: "https://example.com/bali_beach_resort.jpg",
          distance: "Beachfront",
          price: 100 + Random().nextDouble() * 300,
          isBestRated: true,
          isFreeCancellation: true,
        ),
        Hotel(
          name: "Ubud Jungle Hotel",
          location: "Ubud, Bali - Jungle",
          rating: 8.3,
          imageUrl: "https://example.com/ubud_jungle_hotel.jpg",
          distance: "Jungle",
          price: 100 + Random().nextDouble() * 300,
          isMegaSale: true,
          isFreeCancellation: true,
        ),
        Hotel(
          name: "Seminyak Suites",
          location: "Seminyak, Bali - Luxury",
          rating: 9.0,
          imageUrl: "https://example.com/seminyak_suites.jpg",
          distance: "Luxury",
          price: 100 + Random().nextDouble() * 300,
          isBestRated: true,
          isFreeCancellation: true,
        ),
      ],
      "Jakarta": [
        Hotel(
          name: "Jakarta City Hotel",
          location: "Central Jakarta - City center",
          rating: 8.2,
          imageUrl: "https://example.com/jakarta_city_hotel.jpg",
          distance: "City center",
          price: 100 + Random().nextDouble() * 300,
          isBestRated: true,
          isFreeCancellation: true,
        ),
        Hotel(
          name: "Jakarta Budget Inn",
          location: "South Jakarta - Budget",
          rating: 7.8,
          imageUrl: "https://example.com/jakarta_budget_inn.jpg",
          distance: "City center",
          price: 100 + Random().nextDouble() * 300,
          isDomesticDeal: true,
        ),
        Hotel(
          name: "Jakarta Luxury Suites",
          location: "Central Jakarta - Luxury",
          rating: 9.1,
          imageUrl: "https://example.com/jakarta_luxury_suites.jpg",
          distance: "City center",
          price: 100 + Random().nextDouble() * 300,
          isBestRated: true,
          isFreeCancellation: true,
        ),
      ],
      "Surabaya": [
        Hotel(
          name: "Surabaya City Hotel",
          location: "Surabaya - City center",
          rating: 8.0,
          imageUrl: "https://example.com/surabaya_city_hotel.jpg",
          distance: "City center",
          price: 100 + Random().nextDouble() * 300,
          isBestRated: true,
          isFreeCancellation: true,
        ),
        Hotel(
          name: "Surabaya Budget Inn",
          location: "Surabaya - Budget",
          rating: 7.5,
          imageUrl: "https://example.com/surabaya_budget_inn.jpg",
          distance: "City center",
          price: 100 + Random().nextDouble() * 300,
          isDomesticDeal: true,
        ),
        Hotel(
          name: "Surabaya Luxury Suites",
          location: "Surabaya - Luxury",
          rating: 9.0,
          imageUrl: "https://example.com/surabaya_luxury_suites.jpg",
          distance: "City center",
          price: 100 + Random().nextDouble() * 300,
          isBestRated: true,
          isFreeCancellation: true,
        ),
      ],
      "Yogyakarta": [
        Hotel(
          name: "Yogyakarta City Hotel",
          location: "Yogyakarta - City center",
          rating: 8.1,
          imageUrl: "https://example.com/yogyakarta_city_hotel.jpg",
          distance: "City center",
          price: 100 + Random().nextDouble() * 300,
          isBestRated: true,
          isFreeCancellation: true,
        ),
        Hotel(
          name: "Yogyakarta Budget Inn",
          location: "Yogyakarta - Budget",
          rating: 7.7,
          imageUrl: "https://example.com/yogyakarta_budget_inn.jpg",
          distance: "City center",
          price: 100 + Random().nextDouble() * 300,
          isDomesticDeal: true,
        ),
        Hotel(
          name: "Yogyakarta Luxury Suites",
          location: "Yogyakarta - Luxury",
          rating: 9.2,
          imageUrl: "https://example.com/yogyakarta_luxury_suites.jpg",
          distance: "City center",
          price: 100 + Random().nextDouble() * 300,
          isBestRated: true,
          isFreeCancellation: true,
        ),
      ],
    },
    "Vietnam": {
      "Hanoi": [
        Hotel(
          name: "Hanoi Old Quarter Hotel",
          location: "Old Quarter, Hanoi - City center",
          rating: 8.3,
          imageUrl: "https://example.com/hanoi_old_quarter.jpg",
          distance: "City center",
          price: 100 + Random().nextDouble() * 300,
          isBestRated: true,
          isFreeCancellation: true,
        ),
        Hotel(
          name: "Hanoi Riverside Suites",
          location: "Riverside, Hanoi - Luxury",
          rating: 8.7,
          imageUrl: "https://example.com/hanoi_riverside_suites.jpg",
          distance: "Luxury",
          price: 100 + Random().nextDouble() * 300,
          isMegaSale: true,
          isFreeCancellation: true,
        ),
        Hotel(
          name: "Hanoi Budget Inn",
          location: "Old Quarter, Hanoi - Budget",
          rating: 7.9,
          imageUrl: "https://example.com/hanoi_budget_inn.jpg",
          distance: "City center",
          price: 100 + Random().nextDouble() * 300,
          isDomesticDeal: true,
        ),
      ],
      "Ho Chi Minh City": [
        Hotel(
          name: "Saigon Central Hotel",
          location: "District 1, Ho Chi Minh City - City center",
          rating: 8.4,
          imageUrl: "https://example.com/saigon_central_hotel.jpg",
          distance: "City center",
          price: 100 + Random().nextDouble() * 300,
          isBestRated: true,
          isFreeCancellation: true,
        ),
        Hotel(
          name: "Ho Chi Minh Budget Inn",
          location: "District 3, Ho Chi Minh City - Budget",
          rating: 7.8,
          imageUrl: "https://example.com/ho_chi_minh_budget_inn.jpg",
          distance: "City center",
          price: 100 + Random().nextDouble() * 300,
          isDomesticDeal: true,
        ),
        Hotel(
          name: "Saigon Riverside Suites",
          location: "District 1, Ho Chi Minh City - Luxury",
          rating: 8.9,
          imageUrl: "https://example.com/saigon_riverside_suites.jpg",
          distance: "Luxury",
          price: 100 + Random().nextDouble() * 300,
          isBestRated: true,
          isFreeCancellation: true,
        ),
      ],
      "Da Nang": [
        Hotel(
          name: "Da Nang Beach Resort",
          location: "My Khe Beach, Da Nang - Beachfront",
          rating: 8.6,
          imageUrl: "https://example.com/da_nang_beach_resort.jpg",
          distance: "Beachfront",
          price: 100 + Random().nextDouble() * 300,
          isBestRated: true,
          isFreeCancellation: true,
        ),
        Hotel(
          name: "Da Nang City Hotel",
          location: "City center, Da Nang",
          rating: 8.2,
          imageUrl: "https://example.com/da_nang_city_hotel.jpg",
          distance: "City center",
          price: 100 + Random().nextDouble() * 300,
          isDomesticDeal: true,
        ),
        Hotel(
          name: "Da Nang Budget Inn",
          location: "City center, Da Nang - Budget",
          rating: 7.7,
          imageUrl: "https://example.com/da_nang_budget_inn.jpg",
          distance: "City center",
          price: 100 + Random().nextDouble() * 300,
          isMegaSale: true,
          isFreeCancellation: true,
        ),
      ],
      "Nha Trang": [
        Hotel(
          name: "Nha Trang Beach Resort",
          location: "Beachfront, Nha Trang",
          rating: 8.5,
          imageUrl: "https://example.com/nha_trang_beach_resort.jpg",
          distance: "Beachfront",
          price: 100 + Random().nextDouble() * 300,
          isBestRated: true,
          isFreeCancellation: true,
        ),
        Hotel(
          name: "Nha Trang City Hotel",
          location: "City center, Nha Trang",
          rating: 8.1,
          imageUrl: "https://example.com/nha_trang_city_hotel.jpg",
          distance: "City center",
          price: 100 + Random().nextDouble() * 300,
          isDomesticDeal: true,
        ),
        Hotel(
          name: "Nha Trang Budget Inn",
          location: "City center, Nha Trang - Budget",
          rating: 7.8,
          imageUrl: "https://example.com/nha_trang_budget_inn.jpg",
          distance: "City center",
          price: 100 + Random().nextDouble() * 300,
          isMegaSale: true,
          isFreeCancellation: true,
        ),
      ],
    },
    "Cambodia": {
      "Phnom Penh": [
        Hotel(
          name: "Phnom Penh City Hotel",
          location: "City center, Phnom Penh",
          rating: 8.2,
          imageUrl: "https://example.com/phnom_penh_city_hotel.jpg",
          distance: "City center",
          price: 100 + Random().nextDouble() * 300,
          isBestRated: true,
          isFreeCancellation: true,
        ),
        Hotel(
          name: "Phnom Penh Budget Inn",
          location: "City center, Phnom Penh - Budget",
          rating: 7.7,
          imageUrl: "https://example.com/phnom_penh_budget_inn.jpg",
          distance: "City center",
          price: 100 + Random().nextDouble() * 300,
          isDomesticDeal: true,
        ),
        Hotel(
          name: "Phnom Penh Riverside Suites",
          location: "Riverside, Phnom Penh - Luxury",
          rating: 8.8,
          imageUrl: "https://example.com/phnom_penh_riverside_suites.jpg",
          distance: "Luxury",
          price: 100 + Random().nextDouble() * 300,
          isBestRated: true,
          isFreeCancellation: true,
        ),
      ],
      "Siem Reap": [
        Hotel(
          name: "Siem Reap City Hotel",
          location: "City center, Siem Reap",
          rating: 8.3,
          imageUrl: "https://example.com/siem_reap_city_hotel.jpg",
          distance: "City center",
          price: 100 + Random().nextDouble() * 300,
          isBestRated: true,
          isFreeCancellation: true,
        ),
        Hotel(
          name: "Siem Reap Budget Inn",
          location: "City center, Siem Reap - Budget",
          rating: 7.8,
          imageUrl: "https://example.com/siem_reap_budget_inn.jpg",
          distance: "City center",
          price: 100 + Random().nextDouble() * 300,
          isDomesticDeal: true,
        ),
        Hotel(
          name: "Siem Reap Luxury Suites",
          location: "City center, Siem Reap - Luxury",
          rating: 9.0,
          imageUrl: "https://example.com/siem_reap_luxury_suites.jpg",
          distance: "City center",
          price: 100 + Random().nextDouble() * 300,
          isBestRated: true,
          isFreeCancellation: true,
        ),
      ],
      "Sihanoukville": [
        Hotel(
          name: "Sihanoukville Beach Resort",
          location: "Beachfront, Sihanoukville",
          rating: 8.4,
          imageUrl: "https://example.com/sihanoukville_beach_resort.jpg",
          distance: "Beachfront",
          price: 100 + Random().nextDouble() * 300,
          isBestRated: true,
          isFreeCancellation: true,
        ),
        Hotel(
          name: "Sihanoukville City Hotel",
          location: "City center, Sihanoukville",
          rating: 8.0,
          imageUrl: "https://example.com/sihanoukville_city_hotel.jpg",
          distance: "City center",
          price: 100 + Random().nextDouble() * 300,
          isDomesticDeal: true,
        ),
        Hotel(
          name: "Sihanoukville Budget Inn",
          location: "City center, Sihanoukville - Budget",
          rating: 7.6,
          imageUrl: "https://example.com/sihanoukville_budget_inn.jpg",
          distance: "City center",
          price: 100 + Random().nextDouble() * 300,
          isMegaSale: true,
          isFreeCancellation: true,
        ),
      ],
    },
    "Singapore": {
      "Singapore City": [
        Hotel(
          name: "Singapore City Hotel",
          location: "City center, Singapore City",
          rating: 8.5,
          imageUrl: "https://example.com/singapore_city_hotel.jpg",
          distance: "City center",
          price: 100 + Random().nextDouble() * 300,
          isBestRated: true,
          isFreeCancellation: true,
        ),
        Hotel(
          name: "Singapore Budget Inn",
          location: "City center, Singapore City - Budget",
          rating: 7.8,
          imageUrl: "https://example.com/singapore_budget_inn.jpg",
          distance: "City center",
          price: 100 + Random().nextDouble() * 300,
          isDomesticDeal: true,
        ),
        Hotel(
          name: "Singapore Luxury Suites",
          location: "City center, Singapore City - Luxury",
          rating: 9.1,
          imageUrl: "https://example.com/singapore_luxury_suites.jpg",
          distance: "City center",
          price: 100 + Random().nextDouble() * 300,
          isBestRated: true,
          isFreeCancellation: true,
        ),
      ],
    },
    "USA": {
      "California": [
        Hotel(
          name: "California Beach Resort",
          location: "Santa Monica, California - Beachfront",
          rating: 8.6,
          imageUrl: "https://example.com/california_beach_resort.jpg",
          distance: "Beachfront",
          price: 100 + Random().nextDouble() * 300,
          isBestRated: true,
          isFreeCancellation: true,
        ),
        Hotel(
          name: "Golden Gate Hotel",
          location: "San Francisco, California - City center",
          rating: 8.7,
          imageUrl: "https://example.com/golden_gate_hotel.jpg",
          distance: "City center",
          price: 100 + Random().nextDouble() * 300,
          isBestRated: true,
          isFreeCancellation: true,
        ),
        Hotel(
          name: "Hollywood Inn",
          location: "Hollywood, California - Entertainment district",
          rating: 8.3,
          imageUrl: "https://example.com/hollywood_inn.jpg",
          distance: "Entertainment district",
          price: 100 + Random().nextDouble() * 300,
          isDomesticDeal: true,
          isMegaSale: true,
          isFreeCancellation: true,
        ),
        Hotel(
          name: "Santa Monica Suites",
          location: "Santa Monica, California - Beachfront",
          rating: 8.5,
          imageUrl: "https://example.com/santa_monica_suites.jpg",
          distance: "Beachfront",
          price: 100 + Random().nextDouble() * 300,
          isAwarded: true,
          isFreeCancellation: true,
        ),
        Hotel(
          name: "San Diego Bay Hotel",
          location: "San Diego, California - Bayfront",
          rating: 8.4,
          imageUrl: "https://example.com/san_diego_bay_hotel.jpg",
          distance: "Bayfront",
          price: 100 + Random().nextDouble() * 300,
          isBestRated: true,
          isFreeCancellation: true,
        ),
      ],
      "Texas": [
        Hotel(
          name: "Austin City Hotel",
          location: "Austin, Texas - City center",
          rating: 8.2,
          imageUrl: "https://example.com/austin_city_hotel.jpg",
          distance: "City center",
          price: 100 + Random().nextDouble() * 300,
          isBestRated: true,
          isFreeCancellation: true,
        ),
        Hotel(
          name: "Dallas Luxury Suites",
          location: "Dallas, Texas - Luxury",
          rating: 9.0,
          imageUrl: "https://example.com/dallas_luxury_suites.jpg",
          distance: "City center",
          price: 100 + Random().nextDouble() * 300,
          isBestRated: true,
          isFreeCancellation: true,
        ),
        Hotel(
          name: "Houston Budget Inn",
          location: "Houston, Texas - Budget",
          rating: 7.8,
          imageUrl: "https://example.com/houston_budget_inn.jpg",
          distance: "City center",
          price: 100 + Random().nextDouble() * 300,
          isDomesticDeal: true,
        ),
      ],
      "New York": [
        Hotel(
          name: "New York City Hotel",
          location: "Manhattan, New York - City center",
          rating: 8.8,
          imageUrl: "https://example.com/new_york_city_hotel.jpg",
          distance: "City center",
          price: 100 + Random().nextDouble() * 300,
          isBestRated: true,
          isFreeCancellation: true,
        ),
        Hotel(
          name: "Brooklyn Budget Inn",
          location: "Brooklyn, New York - Budget",
          rating: 7.9,
          imageUrl: "https://example.com/brooklyn_budget_inn.jpg",
          distance: "City center",
          price: 100 + Random().nextDouble() * 300,
          isDomesticDeal: true,
        ),
        Hotel(
          name: "Manhattan Luxury Suites",
          location: "Manhattan, New York - Luxury",
          rating: 9.2,
          imageUrl: "https://example.com/manhattan_luxury_suites.jpg",
          distance: "City center",
          price: 100 + Random().nextDouble() * 300,
          isBestRated: true,
          isFreeCancellation: true,
        ),
      ],
    },
  };


  @override
  void initState() {
    super.initState();
    selectedCountry = countryStates.keys.first;
    selectedState = countryStates[selectedCountry!]!.first;
    updateHotels();
  }

  void updateHotels() {
    setState(() {
      if (selectedCountry != null && selectedState != null) {
        final statesHotels = hotelData[selectedCountry!];
        if (statesHotels != null) {
          final stateHotels = statesHotels[selectedState!];
          if (stateHotels != null) {
            hotels = stateHotels;
          } else {
            hotels = [];
          }
        } else {
          hotels = [];
        }
      } else {
        hotels = [];
      }
    });
  }

  void onCountrySelected(String country) {
    setState(() {
      selectedCountry = country;
      selectedState = countryStates[country]!.first;
      updateHotels();
    });
  }

  void onStateSelected(String state) {
    setState(() {
      selectedState = state;
      updateHotels();
    });
  }

  Widget buildHotelCard(Hotel hotel) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => BookingPage(packageTitle: hotel.name, price: hotel.price),
              ),
            );
          },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  hotel.imageUrl,
                  width: 120,
                  height: 90,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 120,
                    height: 90,
                    color: Colors.grey[300],
                    child: const Icon(Icons.broken_image, size: 40),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      hotel.name,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.orange, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          hotel.rating.toStringAsFixed(1),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          hotel.location,
                          style: const TextStyle(color: Colors.blue, fontSize: 12),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Wrap(
                      spacing: 6,
                      runSpacing: 4,
                      children: const [],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        if (hotel.isDomesticDeal)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.pink[100],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Text(
                              "Domestic Deal",
                              style: TextStyle(fontSize: 12, color: Colors.pink),
                            ),
                          ),
                        if (hotel.isOnlyOneLeft)
                          Container(
                            margin: const EdgeInsets.only(left: 8),
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.red[100],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Text(
                              "ONLY 1 LEFT",
                              style: TextStyle(fontSize: 12, color: Colors.red),
                            ),
                          ),
                        if (hotel.isMegaSale)
                          Container(
                            margin: const EdgeInsets.only(left: 8),
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Text(
                              "MEGA SALE",
                              style: TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ),
                        if (hotel.isFreeCancellation)
                          Container(
                            margin: const EdgeInsets.only(left: 8),
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.green[100],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Text(
                              "FREE CANCELLATION",
                              style: TextStyle(fontSize: 12, color: Colors.green),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "RM ${hotel.price.toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 4),
                  if (hotel.isMegaSale)
                    const Text(
                      "Per night before taxes and fees",
                      style: TextStyle(fontSize: 10, color: Colors.black54),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Removed calculateDiscountedPrice method

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Country and State'),
        backgroundColor: Colors.teal[700],
      ),
      body: Column(
        children: [
          // Country selector - horizontal list
          Container(
            height: 50,
            color: Colors.grey[200],
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: countryStates.keys.length,
              itemBuilder: (context, index) {
                final country = countryStates.keys.elementAt(index);
                final isSelected = country == selectedCountry;
                return GestureDetector(
                  onTap: () => onCountrySelected(country),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.teal[300] : Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        country,
                        style: TextStyle(
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          color: isSelected ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          // State selector - horizontal list
          Container(
            height: 50,
            color: Colors.grey[100],
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: countryStates[selectedCountry]?.length ?? 0,
              itemBuilder: (context, index) {
                final state = countryStates[selectedCountry]![index];
                final isSelected = state == selectedState;
                return GestureDetector(
                  onTap: () => onStateSelected(state),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.teal[300] : Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        state,
                        style: TextStyle(
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          color: isSelected ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          // Hotel list
          Expanded(
            child: ListView.builder(
              itemCount: hotels.length,
              itemBuilder: (context, index) {
                return buildHotelCard(hotels[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

