let standard_library_default = 
  Printf.sprintf "%s/.bondi" (Unix.getenv "HOME") in
  Unix.chdir standard_library_default

let run_file fileName = 
  Printf.sprintf "bondi tests/%s.bon" fileName
  |> Podge.Unix.read_process_output
  |> List.fold_left (^) ""

let read_expect fileName =
  Printf.sprintf "tests/%s.out" fileName
  |> Podge.Unix.read_all

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