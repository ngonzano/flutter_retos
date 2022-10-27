class City {
  const City({
    this.name,
    this.price,
    this.place,
    this.date,
    this.image,
    this.reviews,
  });

  final String? name;
  final String? price;
  final String? place;
  final String? date;
  final String? image;
  final List<CityReview>? reviews;
}

class CityReview {
  const CityReview({
    this.avatar,
    this.date,
    this.title,
    this.subtitle,
    this.descripcion,
    this.image,
  });
  final String? avatar;
  final DateTime? date;
  final String? title;
  final String? subtitle;
  final String? descripcion;
  final String? image;
}

final cities = <City>[
  City(
    name: 'Tokyo',
    price: '580USD',
    place: 'place 1',
    date: '25/03/22',
    image: 'assets/img/delivery.png',
    reviews: [
      CityReview(
        avatar: 'assets/img/bag.png',
        date: DateTime(2022, 3, 22, 7, 0, 0),
        title: 'titulo CityReview',
        subtitle: 'subtitulo CityReview',
        descripcion: 'descripcion CityReview',
        image: 'assets/img/Delivery3.png',
      )
    ],
  ),
  City(
    name: 'Tokyo 2',
    price: '2580USD',
    place: 'place 2',
    date: '26/03/22',
    image: 'assets/img/mastercard.png',
    reviews: [
      CityReview(
        avatar: 'assets/img/bag.png',
        date: DateTime(2022, 3, 22, 7, 0, 0),
        title: 'titulo CityReview 2',
        subtitle: 'subtitulo CityReview 2',
        descripcion: 'descripcion CityReview 2',
        image: 'assets/img/no-image.png',
      )
    ],
  )
];
