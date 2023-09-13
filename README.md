# MD407 Firmware Template
This is intended to be a template for MD407 embedded projects. Please submit a **PR** if you encounter a bug or just want a feature to be added.

## Building 
To build your project simply do `$ make`. It should output a `build/` directory with `output.s19` and `output.elf` in it.

### Uploading to hardware
`make upload` will run the [`upload.py`](/upload.py) script. Take a look at it.

### GDB & Simserver
Make sure you have started simserver before you do anything.

Then do: `$ make clean && make && arm-none-eabi-gdb` (or just `$ arm-none-eabi-gdb`)

You can also just do `$ make gdb` and it will launch & compile everything for you.

## Development Environment

### VSCode
It is recommended to use the `clang` + `Makefile` extensions for linting and such if you use vscode.

`LLVM` extension is also kinda nice.

### (Neo)Vim
Same as the above. I use `null-ls` and `lsp-zero`. 
```lua
return require("packer").startup(function(use)
	use {
		"VonHeikemen/lsp-zero.nvim",
		branch = "v2.x",
		requires = {
			-- LSP Support
			{ "neovim/nvim-lspconfig" }, -- Required
			{
				-- Optional
				"williamboman/mason.nvim",
				run = function()
					pcall(vim.cmd, "MasonUpdate")
				end,
			},
			{ "williamboman/mason-lspconfig.nvim" }, -- Optional

			-- Autocompletion
			{ "hrsh7th/nvim-cmp" }, -- Required
			{ "hrsh7th/cmp-nvim-lsp" }, -- Required
			{ "L3MON4D3/LuaSnip" }, -- Required
		}
	}
	use "jose-elias-alvarez/null-ls.nvim"
end)
```
You can also refer [**to my dotfiles**](https://github.com/almqv/dotfiles). 

### OBS: WIP
