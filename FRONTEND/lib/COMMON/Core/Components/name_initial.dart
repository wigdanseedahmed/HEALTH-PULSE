// Thanks to StackOverflow user julemand101
// https://stackoverflow.com/a/61291045/16060347

String getInitials(String name) => name.isNotEmpty
    ? name.trim().split(RegExp(' +')).map((s) => s[0]).take(2).join()
    : '';
