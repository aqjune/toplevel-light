# Toplevel-light

Toplevel-light is a very lightweight OCaml toplevel program tailored for
communication between OCaml REPL process and external editor.
Before OCaml REPL reads from or writes to the terminal, it prints a single-line
message that is wrapped with `$` stating what kind of interaction is being made.

```
bash $ ./toplevel_light
$STDIN$
```

`$STDIN$` states that the OCaml toplevel is now waiting for an input.

Let's assume that a user wrote `let _ = print_endline "hello, world!" in 10;;`.
toplevel_light will print:

```
hello, world!

$SUCCESS$
- : int = 10
$STDIN$
```

`$SUCCESS$` states that the statement is successfully evaluated by OCaml.
The lines before `$SUCCESS$` is the printed output of the statement, and the
line after `$SUCCESS$` is its value.

If the input was syntactically incorrect, `$ERROR$` will appear.

```
$STDIN$
1 + "a";;
$ERROR$
Line 1, characters 4-7:
1 | 1 + "a";;
        ^^^
Error: This expression has type string but an expression was expected of type
         int
$STDIN$
```

## How to build

Using OCaml 4.14 is recommended.

```
make
```

## Message Kinds

- `$STDIN$`: The toplevel is waiting for input. This will appear in every
             input line.
- `$SUCCESS$`: The toplevel successfully evaluated the statement
- `$EXCEPTION$`: The statement raised an exception.
- `$ERROR$`: The toplevel could not parse the statement.

Message sequence:

If there is no `#use` or `Topdir.dir_use`:

`$STDIN$` (can appear multiple times until one toplevel phrase is parsed) ->
  one of `$SUCCESS$`,`$EXCEPTION$` and `$ERROR$`

If there is `#use` or `Topdir.dir_use`: `$SUCCESS$`,`$EXCEPTION$` and `$ERROR$`
  can appear multiple times.

## Caveats

- The user should not print a line that is syntactically equal to one of the
  messages.
- The outputs printed to stderr cannot be delineated by the `$..$` messages.
