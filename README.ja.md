# MissingLisp
## 概要

Rubyの変数名でLispを書けるインタプリタ。

## インストール

```bash
gem install missinglisp
```

## 使い方

```sh
$ irb
irb(main):001> require 'missinglisp'
=> true
irb(main):002> Lquote_hello_world_J
=> [:hello, :world]
irb(main):003> Ladd_1_2_3J
=> 6
```

その他の例は`examples`ディレクトリにあります。

## 言語仕様

### 概要

MissingLispはLispのサブセットです。一部、利用可能文字の都合から、Lispの構文と異なる部分があります。

### 構文

- スペースの代わりに `_` を使用します。空白は無視されます
- 開き括弧として `(` の代わりに `L` を使います
- 閉じ括弧として `)` の代わりに `J` を使います
  - 注意: `Lfoo_barJ` は `L`、`foo`、 `barJ` とみなされます。閉じ括弧として`J`を使用したい場合は、`bar` と `J` を分けるために `_` を使用する必要があります: `Lfoo_bar_J`
- シンボルは通常の識別子として記述されます（例: `add`、`define`、`lambda`）
- 数値は通常の数値として記述されます

### 特殊形式

- `Lif_test_then_elseJ` - 条件式: `test` が真なら `then` を評価し、偽なら `else` を評価します
  - 例: `Lif_1_2_3J` => `2`
- `Lquote_expressionJ` - `expression` を評価せずに返します
  - 例: `Lquote_hello_world_J` => `[:hello, :world]`
- `Ldefine_symbol_expressionJ` - 現在の環境にシンボルを定義します
  - 例: `Ldefine_foo_1J` の後に `foo` は `1` になります
- `Llambda_Lparameters_J_bodyJ` - 関数を作成します
  - 例: 与えられた引数に 1 を加算する関数 `succ` を作成するには、`Ldefine_succ_Llambda_Lx_J_Ladd_x_1JJJ` と書きます

### 組み込み関数

MissingLispはいくつかの組み込み関数を提供しています:

#### リスト操作
- `car` - リストの最初の要素を返します
- `cdr` - 最初の要素を除くリストを返します
- `cons` - 要素を先頭に追加して新しいリストを構築します
- `list` - 引数からリストを作成します

#### 算術演算
- `add` - 数値を加算します
- `sub` - 数値を減算します
- `mult` - 数値を乗算します
- `div` - 数値を除算します

#### 比較演算
- `eq` - 等価性をテストします
- `lt` - 未満
- `leq` - 以下
- `gt` - より大きい
- `geq` - 以上

#### その他
- `p` - 値を表示します（デバッグ用）
- `nil` - 空のリスト

## ライセンス

MIT
