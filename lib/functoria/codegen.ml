(*
 * Copyright (c) 2013-2020 Thomas Gazagnaire <thomas@gazagnaire.org>
 * Copyright (c) 2013-2020 Anil Madhavapeddy <anil@recoil.org>
 * Copyright (c) 2015-2020 Gabriel Radanne <drupyog@zoho.com>
 *
 * Permission to use, copy, modify, and distribute this software for any
 * purpose with or without fee is hereby granted, provided that the above
 * copyright notice and this permission notice appear in all copies.
 *
 * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
 * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
 * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
 * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 *)

open Astring

let main_ml = ref None

let generated_header ?(argv = Sys.argv) () =
  Format.asprintf "Generated by %S."
    (String.concat ~sep:" " (Array.to_list argv))

let append oc fmt = Format.fprintf oc (fmt ^^ "@.")

let newline oc = append oc ""

let append_main fmt =
  match !main_ml with None -> failwith "main_ml" | Some oc -> append oc fmt

let newline_main () =
  match !main_ml with None -> failwith "main_ml" | Some oc -> newline oc

let set_main_ml file =
  let oc = Format.formatter_of_out_channel @@ open_out file in
  main_ml := Some oc
