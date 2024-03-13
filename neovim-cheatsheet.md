# Neovim Keymappings Cheatsheet

## Navigation

| Key | Description |
| --- | ----------- |
| `<C-h>` | Navigate to the left window |
| `<C-j>` | Navigate to the bottom window |
| `<C-k>` | Navigate to the top window |
| `<C-l>` | Navigate to the right window |

## Terminal

| Key | Description |
| --- | ----------- |
| `<C-h>` | Navigate to the left window in terminal mode |
| `<C-j>` | Navigate to the bottom window in terminal mode |
| `<C-k>` | Navigate to the top window in terminal mode |
| `<C-l>` | Navigate to the right window in terminal mode |
| `<C-o>` | Switch to normal mode in terminal |

## LSP and Diagnostics

| Key | Description |
| --- | ----------- |
| `[d` | Go to previous diagnostic message |
| `]d` | Go to next diagnostic message |
| `K` | Hover documentation |
| `gd` | Go to definition |
| `gr` | Go to references |

## Misc

| Key | Description |
| --- | ----------- |
| `<C-s>` | Save changes |
| `,mv` | Rename file |
| `,nh` | No highlight |
| `,o` | Only keep current pane |
| `,pp` | Paste from clipboard |
| `,q` | Close buffer |
| `,rm` | Remove file |
| `,vv` | New vertical split |
| `,yy` | Copy to clipboard (in visual mode) |

## Plugin Specific

### fzf-lua

| Key | Description |
| --- | ----------- |
| `,<` | Find files |
| `,ca` | Code actions |
| `,bb` | Find buffers |
| `,fd` | Search for ruby method definition |
| `,ff` | Grep |
| `,fr` | Resume search |
| `,fw` | Grep for word under cursor |
| `,gr` | LSP references |

### neoterm

| Key | Description |
| --- | ----------- |
| `,tc` | Clear terminal |
| `,to` | Toggle terminal |
| `,tl` | Test local changes |
| `,ty` | Sorbet typecheck |

### gitsigns.nvim

| Key | Description |
| --- | ----------- |
| `,ghs` | Git stage hunk |
| `,ghu` | Git undo stage hunk |
| `,ghr` | Git reset hunk |
| `]h` | Go to next hunk |
| `[h` | Go to previous hunk |
| `ah` | Text object for git hunks |

### devdocs.vim

| Key | Description |
| --- | ----------- |
| `,dd` | Open devdocs.io |

### vim-fugitive

| Key | Description |
| --- | ----------- |
| `,gbl` | Git blame |
| `,ghp` | Open Github PR |
| `,gs` | Git status |
| `,gbr` | Git browse |

### vim-rails

| Key | Description |
| --- | ----------- |
| `,s` | Toggle test and code files |

### vim-test

| Key | Description |
| --- | ----------- |
| `,tf` | Test current file |
| `,tn` | Test nearest |
| `,ts` | Test suite |
| `,tt` | Rerun last test |
