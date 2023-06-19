isEmpty(String text) {
  if (text == 'null' || text == '' || text == null) {
    return '';
  } else {
    return text;
  }
}

isEmptyorUndefined(String text) {
  final undefined = Object();
  if (text == 'null' || text == '' || text == null || text == undefined) {
    return 'Bilgi Yok';
  } else {
    return text;
  }
}
