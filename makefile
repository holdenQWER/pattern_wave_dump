#according to pattern's column/row change WIDTH/HEIGHT
WIDTH ?= 216
HEIGHT ?= 38

run: clean
	vcs -debug_access+all -kdb -lca -full64 -sverilog top.sv +define+WIDTH=${WIDTH}+HEIGHT=${HEIGHT} -R
	
wave:
	verdi -ssf wave.fsdb &

clean:
	-rm -rf sim* csrc
