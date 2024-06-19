class Word {
  String vocab;
  String partOfSpeech;
  String meaning;
  char[] letters; // 存储字母的字符数组

  Word(String vocab, String partOfSpeech, String meaning, char[] letters) {
    this.vocab = vocab;
    this.partOfSpeech = partOfSpeech;
    this.meaning = meaning;
    this.letters = letters;
  }

  String getInfo() {
    //String lettersAsString = new String(letters); // 将字符数组转换为字符串
    return "單字: " + vocab + ", 詞性: " + partOfSpeech + ", 中文解釋: " + meaning;
  }
}
void displayword() {
  // 如果有选择的单词，显示选择的单词信息
  if (selectedWordIndex != -1) {
    textFont(TCSmall);
    text("隨機選擇的單字資訊:", 10, height - 50);
    text(words[selectedWordIndex].getInfo(), 10, height - 30);
  }
}

void pickword() {
  int newWordIndex;
  boolean isUnique;

  do {
    newWordIndex = int(random(words.length));
    isUnique = true;

    // 检查新选择的单词是否已经被吃掉
    for (int i = 0; i < eatenWordsCount; i++) {
      if (eatenWordIndices[i] == newWordIndex) {
        isUnique = false;
        break;
      }
    }
  } while (!isUnique);

  selectedWordIndex = newWordIndex;
}
