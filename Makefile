build:
	@echo "Building binaries…"
	GOOS=darwin GOARCH=amd64 go build -o alfred-maestro-x86
	GOOS=darwin GOARCH=arm64 go build -o alfred-maestro-arm
	lipo -create -output alfred-maestro alfred-maestro-x86 alfred-maestro-arm
	@echo "Done."

pack: build
	@echo "Compiling Alfred package…"
	@mv alfred-maestro workflow/
	@zip --junk-paths --quiet "KeyboardMaestro.alfredworkflow" workflow/*
	@rm workflow/alfred-maestro
	@rm alfred-maestro-x86
	@rm alfred-maestro-arm
	@echo "Done."

# Documentation for M1/Intel cross-compilation and universal binary:
# https://www.yellowduck.be/posts/golang-vs-apple-silicon/
