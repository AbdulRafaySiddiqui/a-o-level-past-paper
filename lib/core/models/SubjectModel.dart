class Subject {
  Subject(this.name, {this.isFavorite});
  String name;
  bool isFavorite = false;
  bool isVisible = true;
  toggleFavorite() {
    isFavorite = !isFavorite;
  }
}
