List<String> getLink(String s) {
  List<String> result = [];
  RegExp exp =
      RegExp(r'(?:(?:https?|ftp):\/\/)?[\w/\-?=%.]+\.[\w/\-?=%.]+');
  Iterable<RegExpMatch> matches = exp.allMatches(s);
  int index = 0;
  if (matches.isEmpty) result.add(s);
  for (var match in matches) {
    result.add(s.substring(index, match.start - 1));
    result.add(s.substring(match.start, match.end));
    index = match.end + 1;
  }
  return result;
}
