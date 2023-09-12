# MD407 Firmware Template

## Usage & Building 
`$ make` to build. Take a look at the [`Makefile`](/Makefile) for other commands.

When building, it will create a `build/` directory containing the raw bytes of the program and a `.s19` version of that.

## Uploading to the MD407
You can use `$ make upload` to upload the .s19. Check out the [`upload.py`](/upload.py) python script if you want to change anything.

## IDE
It is recommended to use the `clang` extension for linting and such if you use vscode or neovim. 

As long as your LSP parses the Makefile (ideally via `compile_flags.txt`). 

### OBS: WIP
