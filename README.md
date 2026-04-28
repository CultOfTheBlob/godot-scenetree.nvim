# godot-scenetree.nvim

A neovim plugin for interacting with godot scenes

<div align="center"><img src="assets/neovim_scenetree.png" width="800" alt="Screenshot of Neovim with a scene open in the scenetree."></div>

## Table of Contents

- [Features](#features)
- [Installation](#installation)
- [Usage](#usage)
- [Configuration](#configuration)

## Features

- View Godot scenes from inside Neovim
- Copy node paths, onready references and export variables
- Attach signals inside Neovim and get a callback function automatically
- Supports gdscript and c#

## Installation

### Nvf (Nix)

Add this flake as an input in your flake.nix

```nix
    godot-scenetree = {
      url = "github:CultOfTheBlob/godot-scenetree.nvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
```

Then add this inside programs.nvf (make sure you have [Nvf](https://nvf.notashelf.dev/) installed)

```nix
settings.vim.lazy.plugins."godot-scenetree" = {
    package = inputs.godot-scenetree.packages.${system}.default;

    setupModule = "godot-scenetree";

    setupOpts = {
        # this is where your config will go, see Configuration
    };

    event = ["VimEnter"];
};
```

You also need to install either mini.pick or telescope as a picker

#### [mini.pick](https://github.com/nvim-mini/mini.pick)

```nix
programs.nvf.settings.vim.mini.pick.enable = true;
```

#### [telescope](https://github.com/nvim-telescope/telescope.nvim)

```nix
programs.nvf.settings.vim.telescope.enable = true;
```

### Lazy.nvim

Add this to your config (make sure you have [Lazy.nvim](https://lazy.folke.io/installation) installed)

```lua
{
    "CultOfTheBlob/godot-scenetree.nvim",
    contig = function()
        require("godot-scenetree").setup({
            -- this is where your config will go, see Configuration
        })
    end,
}
```

You also need to install either [mini.pick](https://github.com/nvim-mini/mini.pick) or [telescope](https://github.com/nvim-telescope/telescope.nvim) as a picker

## Usage

Open the scene tree by running `:Scenetree` in any Godot project.
Inside of a scene you can:

- `p` to open your picker and select another scene
- `<C-x>` to copy an export reference to a node
- `<C-c>` to copy a nodes full path
- `<C-o>` to copy an onready reference to a node
- `<C-s>` to connect a signal from one node to another

### Connecting signals

Pressing `<C-s>` once while in a scene will select
the node that will be emitting the signal (the _from_ node),
and pressing it again will select the node the signal is going to (the _to_ node).
Make sure the _to_ node has a script attached to it
where your callback function can go.
A script icon is shown next to nodes that have a script attached to them.
The callback function will be automatically copied to the yank registry
And the syntax of the callback function will change based on the current buffer.

## Configuration

These are the default config options,
place them inside setupOpts or the setup function based on your [installation](#installation)

```lua
{
    picker = "mini.pick",
    width = 50,
    split = "right",
    mappings = {
        open_picker = "p",
        export_node = "<C-x>",
        get_node_path = "<C-c>",
        get_onready_node = "<C-o>",
        attach_signal = "<C-s>",
    },
}
```
