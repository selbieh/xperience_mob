class PaginationModel<T> {
  int? count;
  String? next;
  String? previous;
  List<T>? results;

  PaginationModel({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  factory PaginationModel.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT,
  ) {
    var resultsList = json['results'] as List;
    List<T> resultList = resultsList.map((i) => fromJsonT(i)).toList();

    return PaginationModel(
      count: json['count'],
      next: json['next'],
      previous: json['previous'],
      results: resultList,
    );
  }

  Map<String, dynamic> toJson(Map<String, dynamic> Function(T) toJsonT) {
    return {
      'count': count,
      'next': next,
      'previous': previous,
      'results': results?.map((result) => toJsonT(result)).toList(),
    };
  }
}

/*

{
    "count": 15,
    "next": "http://impressive-domini-royals-1be52931.koyeb.app/api/car-services/?limit=10&offset=10",
    "previous": null,
    "results": [
        {
            "id": 3,
            "model": "8Glld",
            "make": "BMW",
            "description": "Comfort Car",
            "number_of_seats": 6,
            "year": 2022,
            "color": "Black",
            "type": "SUV",
            "cool": true,
            "image": "http://impressive-domini-royals-1be52931.koyeb.app/media/car_image/Screenshot_from_2024-05-26_16-50-46.png"
        },
        {
            "id": 4,
            "model": "8Glld",
            "make": "BMW",
            "description": "Comfort Car",
            "number_of_seats": 6,
            "year": 2022,
            "color": "Black",
            "type": "SUV",
            "cool": true,
            "image": "http://impressive-domini-royals-1be52931.koyeb.app/media/car_image/Screenshot_from_2024-05-26_16-50-46.png"
        }
    ]
}

*/