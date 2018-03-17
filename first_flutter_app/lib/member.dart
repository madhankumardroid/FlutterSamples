class Member {
  //To use a custom type for JSON mapping
  final String login;
  final String avatarUrl; //To show the member avatar

  Member(this.login, this.avatarUrl) {
    if (login == null) {
      throw new ArgumentError("login of Member cannot be null. "
          "Received: '$login'");
    }
    if (avatarUrl == null) {
      throw new ArgumentError("avatarUrl of Member cannot be null"
          "Received: '$avatarUrl'");
    }
  }
}