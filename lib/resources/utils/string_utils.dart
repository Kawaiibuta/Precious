List<String> getLink(String s) {
  List<String> result = [];
  RegExp exp =
      new RegExp(r'(?:(?:https?|ftp):\/\/)?[\w/\-?=%.]+\.[\w/\-?=%.]+');
  Iterable<RegExpMatch> matches = exp.allMatches(s);
  int index = 0;
  if (matches.isEmpty) result.add(s);
  matches.forEach((match) {
    result.add(s.substring(index, match.start - 1));
    result.add(s.substring(match.start, match.end));
    index = match.end + 1;
  });
  return result;
}
