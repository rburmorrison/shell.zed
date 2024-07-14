; Adapted from: https://github.com/nvim-treesitter/nvim-treesitter/blob/master/queries/bash/highlights.scm

[
  "("
  ")"
  "{"
  "}"
  "["
  "]"
  "[["
  "]]"
  "(("
  "))"
] @punctuation.bracket

[
  ";"
  ";;"
  ";&"
  ";;&"
  "&"
] @punctuation.delimiter

[
  ">"
  ">>"
  "<"
  "<<"
  "&&"
  "|"
  "|&"
  "||"
  "="
  "+="
  "=~"
  "=="
  "!="
  "&>"
  "&>>"
  "<&"
  ">&"
  ">|"
  "<&-"
  ">&-"
  "<<-"
  "<<<"
  ".."
  "!"
] @operator

[
  (string)
  (raw_string)
  (ansi_c_string)
  (heredoc_body)
] @string

[
  (heredoc_start)
  (heredoc_end)
] @label

(variable_assignment
  (word) @string)

(command
  argument: "$" @string) ; bare dollar

(concatenation
  (word) @string)

[
  "if"
  "then"
  "else"
  "elif"
  "fi"
  "case"
  "in"
  "esac"
] @keyword.conditional

[
  "for"
  "do"
  "done"
  "select"
  "until"
  "while"
] @keyword.repeat

[
  "declare"
  "typeset"
  "readonly"
  "local"
  "unset"
  "unsetenv"
] @keyword

"export" @keyword.import

"function" @keyword.function

(special_variable_name) @constant

((word) @boolean
  (#any-of? @boolean "true" "false"))

(comment) @comment

(test_operator) @operator

(command_substitution
  "$(" @punctuation.special
  ")" @punctuation.special)

(process_substitution
  [
    "<("
    ">("
  ] @punctuation.special
  ")" @punctuation.special)

(arithmetic_expansion
  [
    "$(("
    "(("
  ] @punctuation.special
  "))" @punctuation.special)

(arithmetic_expansion
  "," @punctuation.delimiter)

(ternary_expression
  [
    "?"
    ":"
  ] @keyword.conditional.ternary)

(binary_expression
  operator: _ @operator)

(unary_expression
  operator: _ @operator)

(postfix_expression
  operator: _ @operator)

(function_definition
  name: (word) @function)

(command_name
  (word) @function.call)

(command_name
  (word) @function.builtin
  (#any-of? @function.builtin
    "alias" "bg" "bind" "break" "builtin" "caller" "cd" "command" "compgen" "complete" "compopt"
    "continue" "coproc" "dirs" "disown" "echo" "enable" "eval" "exec" "exit" "fc" "fg" "getopts"
    "hash" "help" "history" "jobs" "kill" "let" "logout" "mapfile" "popd" "printf" "pushd" "pwd"
    "read" "readarray" "return" "set" "shift" "shopt" "source" "suspend" "test" "time" "times"
    "trap" "type" "typeset" "ulimit" "umask" "unalias" "wait"))

(declaration_command
  (word) @variable.parameter)

(unset_command
  (word) @variable.parameter)

(number) @number

((word) @number
  (#match? @number "^[0-9]+$"))

(file_redirect
  destination: (word) @variable.parameter)

(file_descriptor) @operator

(simple_expansion
  "$" @punctuation.special) @none

(expansion
  "${" @punctuation.special
  "}" @punctuation.special) @none

(expansion
  operator: _ @punctuation.special)

(expansion
  "@"
  .
  operator: _ @character.special)

((expansion
  (subscript
    index: (word) @character.special))
  (#any-of? @character.special "@" "*"))

"``" @punctuation.special

(variable_name) @variable

((variable_name) @constant
  (#match? @constant "^[A-Z][A-Z_0-9]*$"))

(case_item
  value: (_) @constant)

(regex) @string.regex

(command
  argument: [
    (number) @variable.parameter
    (word) @variable.parameter
    (word) @variable.parameter
    (concatenation
      (word) @variable.parameter)
    ([
        (word)
        (number)
      ] @constant
      (#match? @constant "^-"))
  ])

((program
  .
  (comment) @comment.doc)
  (#match? @comment.doc "^#!/"))
