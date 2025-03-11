enum ApodReaction {
  like,
  unlike;

  String get name {
    switch (this) {
      case ApodReaction.like:
        return 'like';
      case ApodReaction.unlike:
        return 'unlike';
    }
  }
}
