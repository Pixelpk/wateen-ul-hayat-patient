extension RestrictString on String {
  String limitToSpecificLength(int limit) {
    final val = this.length > limit ? (this.substring(0, limit) + '...') : this;
    return val;
  }
}
