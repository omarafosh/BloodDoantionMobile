

String insertNewLineAfterCharacterCount(String text, int charCount) {
  StringBuffer buffer = StringBuffer();
  int count = 0;

  for (int i = 0; i < text.length; i++) {
    buffer.write(text[i]);
    count++;

    if (count == charCount) {
      buffer.write('\n');
      count = 0;
    }
  }

  return buffer.toString();
}

