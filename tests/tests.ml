let exhaust ic =
  let all_input = ref [] in
  (try while true do all_input := input_line ic :: !all_input; done
   with End_of_file -> ());
  close_in ic;
  List.rev !all_input

let read_process_output p = Unix.open_process_in p |> exhaust

let read_all path = open_in path |> exhaust |> String.concat ""

let run_file fileName =
  Printf.sprintf "jbuilder exec bondi -- tests/%s.bon" fileName
  |> read_process_output
  |> List.fold_left (^) ""

let read_expect fileName =
  Printf.sprintf "tests/%s.out" fileName
  |> read_all

(* The tests *)
let test_expectation fileName () =
  Alcotest.(check (string)) "" (run_file fileName) (read_expect fileName)

let test_set = [
  "add_case.bon", `Quick, (test_expectation "add_case");
  "basic_tests.bon", `Quick, (test_expectation "basic_tests");
  "datum_tests.bon", `Quick, (test_expectation "datum_tests");
  "declaration_tests.bon", `Quick, (test_expectation "declaration_tests");
  "dynamic_tests.bon", `Quick, (test_expectation "dynamic_tests");
  "errors.bon", `Quick, (test_expectation "errors");
  "fibonacci.bon", `Quick, (test_expectation "fibonacci");
  "imperative_tests.bon", `Quick, (test_expectation "imperative_tests");
  "null.bon", `Quick, (test_expectation "null");
  "setPrev.bon", `Quick, (test_expectation "setPrev");
  "structure_poly_tests.bon", `Quick, (test_expectation "structure_poly_tests");
]

(* Run it *)
let () =
  Alcotest.run "Running bondi test suite" [
    "test_1", test_set;
  ]
