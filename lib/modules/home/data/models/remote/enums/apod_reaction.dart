enum ApodReaction {
  like,
  unlike,
  all;

  String get name {
    switch (this) {
      case ApodReaction.like:
        return 'like';
      case ApodReaction.unlike:
        return 'unlike';
      case ApodReaction.all:
        return 'all';
    }
  }
}
