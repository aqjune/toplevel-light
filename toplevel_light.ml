let print_endline s =
  Format.print_flush (); (* flush Format buffer *)
  Printf.printf "%!%s\n" s;;

Toploop.print_out_phrase :=
  let orgfun = !Toploop.print_out_phrase in
  fun fmt out_phr ->
    begin match out_phr with
    | Ophr_exception _ -> print_endline "\n$EXCEPTION$"
    | _ -> print_endline "\n$SUCCESS$" end;
    orgfun fmt out_phr;;

Toploop.read_interactive_input :=
  let orgfun = !Toploop.read_interactive_input in
  fun s b i ->
    (* This read_interactive_input will print '$STDIN$' for every newline in
       stdin.
       Printing "$STDIN" only once in the first line will look more
       succinct, and there already is Topcommon.first_line, but this cannot be
       used because it is set to false before Toploop.read_interactive_input
       is invoked. *)
    print_endline "$STDIN$";
    orgfun s b i;;


(* Set the parsing error printer to a batch mode printer. *)
Location.report_printer := fun () ->
  print_endline "$ERROR$";
  Location.batch_mode_printer;;

(* Don't print '# '. *)
Clflags.noprompt := true;;
(* Don't print indentation and '* '. *)
Clflags.nopromptcont := true;;
(* Don't print OCaml version. *)
Clflags.noversion := true;;

Topmain.main();;
