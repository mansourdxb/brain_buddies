class Letter {
  final String letter;
  final String word;
  final String image;
  final String audio;

  Letter({
    required this.letter,
    required this.word,
    required this.image,
    required this.audio,
  });

  factory Letter.fromJson(Map<String, dynamic> json) {
    return Letter(
      letter: json['letter'],
      word: json['word'],
      image: json['image'],
      audio: json['audio'],
    );
  }
}
