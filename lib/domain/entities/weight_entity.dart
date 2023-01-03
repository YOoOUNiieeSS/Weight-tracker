class WeightEntity {
  final String id;
  final double weight;
  final bool isMale;
  final DateTime dateTime;

  WeightEntity(
      {required this.id,
      required this.isMale,
      required this.weight,
      required this.dateTime});

  factory WeightEntity.fromJson(Map<String, dynamic> json) => WeightEntity(
      id: json['id'],
      isMale: json['isMale'],
      weight: json['weight'],
      dateTime: json['dateTime'].toDate());

  Map<String, dynamic> toJson() => {
        'isMale': isMale,
        'weight': weight,
        'id': id,
        'dateTime': dateTime,
      };
}
