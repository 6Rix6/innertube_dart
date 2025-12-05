import 'package:innertube_dart/innertube_dart.dart';

// TODO
class Section<T extends YTItem> {
  final String title;
  final List<T>? items;
  final String? moreEndpoint;

  const Section({required this.title, this.items, this.moreEndpoint});

  @override
  String toString() {
    return 'Section(title: $title, items: ${items?.length}, moreEndpoint: $moreEndpoint)';
  }
}

// ご提示のDartコードにあるようなジェネリクスを使ったクラスのインスタンスに対して、**実行時に** `if (section is Section<SongItem>)` のようなジェネリック型の型チェック（`is` 演算子）を行っても、**ジェネリック引数（$T$の部分）の違いを区別することはできません**。

// -----

// ## 🧐 型チェックの成立について

// 結論から言うと、ご提示の $if$ 文は、**ジェネリック引数の違いを区別する目的では成立しません**。

// ### 1\. **実行時とコンパイル時**

// Dart（および多くのJVM言語など）は、**実行時**にはジェネリック型引数の情報を削除する\*\*型消去（Type Erasure）\*\*というメカニズムを採用しています。

//   * **コンパイル時:** コンパイラはジェネリック引数（例：`<SongItem>`）をチェックし、型の安全性を保証します。
//   * **実行時:** `Section<SongItem>`も`Section<AlbumItem>`も、実行時には単なる `Section` 型として認識されます。

// ### 2\. **`is` 演算子の挙動**

// したがって、ご提示のコードの場合、以下のようになります。

// ```dart
// final Section<SongItem> section = Section(title: 'Songs', items: [...]);

// // 実行時、sectionの型は「Section」として見られます。
// if (section is Section<SongItem>){
//   // ここは常に true になります。
//   print("song section");
// } else if (section is Section<AlbumItem>){
//   // 上の if で true になるため、ここは実行されません。
//   print("album section");
// }
// ```

// ジェネリック型に対する `is` 演算子は、**ジェネリック引数 $T$ の部分は無視され**、ベースクラス（この場合は `Section`）の部分のみがチェックされます。どちらの $if$ の条件も実質的に `section is Section` と同じ意味になるため、**最初の $if$ ブロックが常に実行されます**。

// ### 3\. **型の区別を行うための方法**

// ジェネリック引数の違いによって処理を分けたい場合は、以下のような方法を検討する必要があります。

// #### **A. 実行時に区別できる情報を持つ**

// クラス `Section` 自体に、ジェネリック引数 $T$ の型情報を保持するフィールドや、それが何を表すかのフラグを追加します。

// ```dart
// class Section<T extends YTItem> {
//   // ... (既存のフィールド)
//   final String contentType; // 例: "song", "album" などを保持

//   const Section({required this.title, this.items, this.moreEndpoint, required this.contentType});
// }

// // チェック時
// if (section.contentType == "song") {
//   print("song section");
// } else if (section.contentType == "album") {
//   print("album section");
// }
// ```

// #### **B. サブクラスを使用する**

// ジェネリッククラスではなく、具体的な型引数を持った**サブクラス**を作成します。

// ```dart
// class SongSection extends Section<SongItem> {
//   const SongSection({required super.title, super.items, super.moreEndpoint});
// }

// class AlbumSection extends Section<AlbumItem> {
//   const AlbumSection({required super.title, super.items, super.moreEndpoint});
// }

// // チェック時（この場合は型の違いが実行時にも区別できます）
// final Section section = SongSection(title: 'Songs'); // 実行時の型は SongSection

// if (section is SongSection) {
//   print("song section"); // true になります
// } else if (section is AlbumSection) {
//   print("album section");
// }
// ```

// このサブクラスを使う方法が、より**Dartの型の安全性**を活かした、推奨されるパターンとなります。
