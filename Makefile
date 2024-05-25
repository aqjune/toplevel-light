toplevel_light: toplevel_light.ml
	ocamlc -I +compiler-libs -linkall ocamlcommon.cma ocamlbytecomp.cma ocamltoplevel.cma toplevel_light.ml -o toplevel_light

clean: ; rm toplevel_light toplevel_light.cmo toplevel_light.cmi
