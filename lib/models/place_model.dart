class Place {
  final String name;
  final String photoUrl;
  final String address;
  final double latitude;
  final double longitude;
  final String placeId;
  final double rating;

  Place(
      {required this.name,
      required this.photoUrl,
      required this.address,
      required this.latitude,
      required this.placeId,
      required this.rating,
      required this.longitude});
}
