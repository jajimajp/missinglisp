# MissingLisp
## Overview

[🇯🇵 日本語版 README](./README.ja.md)

MissingLisp is a minimalist Lisp interpreter embedded in Ruby. It allows you to write and evaluate Lisp expressions with Ruby's variable names.

## Installation

```bash
gem install missinglisp
```

## Usage

```sh
$ irb
irb(main):001> require 'missinglisp'
=> true
irb(main):002> Lquote_hello_world_J
=> [:hello, :world]
irb(main):003> Ladd_1_2_3J
=> 6
```

Other examples can be found in the `examples` directory.

## Language Specification

### Overview

MissingLisp implements a subset of Lisp.

### Syntax

- Uses `L` instead of `(` to open expressions
- Uses `J` instead of `)` to close expressions
  - Note: `Lfoo_barJ` is tokenized as `L`, `foo` `barJ`. If you want to use `J` as closing parentheses, you must use `_` to separate the token: `Lfoo_bar_J`
- Symbols are written as normal identifiers (e.g., `add`, `define`, `lambda`)
- Numbers are written as normal numbers
- Whitespace is ignored. Uses `_` instead of spaces

### Special Forms

- `Lif_test_then_elseJ` - Conditional expression
- `Lquote_expressionJ` - Returns the expression without evaluating it
- `Ldefine_symbol_expressionJ` - Defines a symbol in the current environment
- `Llambda_Lparameters_J_bodyJ` - Creates a function

### Built-in Functions

MissingLisp provides several built-in functions:

#### List Operations
- `car` - Returns the first element of a list
- `cdr` - Returns all but the first element of a list
- `cons` - Constructs a new list by prepending an element
- `list` - Creates a list from its arguments

#### Arithmetic Operations
- `add` - Adds numbers
- `sub` - Subtracts numbers
- `mult` - Multiplies numbers
- `div` - Divides numbers

#### Comparison Operations
- `eq` - Tests equality
- `lt` - Less than
- `leq` - Less than or equal
- `gt` - Greater than
- `geq` - Greater than or equal

#### Other
- `p` - Prints values (for debugging)
- `nil` - An empty list

## License

MIT
