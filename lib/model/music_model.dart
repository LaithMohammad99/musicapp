class MusicModel {
  final String? path;
  final int? id;
  final String? image;
  final String? name;
  final String? nameTow;
  int? duration;
  bool? isEnabled;

  MusicModel(
      { this.nameTow,
       this.id,
       this.path,
       this.image,
       this.isEnabled,
       this.name,
       this.duration});
}
