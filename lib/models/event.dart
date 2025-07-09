class Event {
  final String title;
  final String description;
  final String startDate;
  final String endDate;
  final String? image;

  Event({
    required this.title,
    required this.description,
    required this.startDate,
    required this.endDate,
    this.image,
  });
}