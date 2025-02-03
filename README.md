# nSearch - Semantic Symbol Search for Neovim

## Features
- Semantic search across Lua function and class symbols
- Uses sentence transformers for intelligent matching
- FZF-based result display

## Prerequisites
- Neovim (0.7+)
- Python 3
- `sentence-transformers` Python package
- `fzf` plugin

## Installation
Using a plugin manager like Packer:

```lua
use {
    'pratikneupane/nSearch.nvim',
    requires = {'junegunn/fzf', 'nvim-treesitter/nvim-treesitter'},
    run = ':TSUpdate'
}
```

## Configuration
In your Neovim config:

```lua
require('nsearch').setup()
```

## Usage
- `<leader>fs`: Trigger semantic symbol search

## Dependencies
- Treesitter
- Sentence Transformers
- FZF
