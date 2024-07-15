# shell.zed

Support for Bash, POSIX Shell, and ZSH.

- Tree Sitter: [tree-sitter-bash](https://github.com/tree-sitter/tree-sitter-bash)
- Language Server: [bash-language-server](https://github.com/bash-lsp/bash-language-server)

## Features

- Offline LSP Support
  - Auto-Detects installed language server
  - Falls back to installed language server if offline
- Syntax Highlighting
  - Adapted from [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter/blob/master/queries/bash/highlights.scm)
  - Highlights command flags
- Comprehensive Bracket Jumping
- Smart Indentation
- Linting[^1] and Formatting (when dependencies are installed)

## Linting and Formatting

Linting and formatting is handled through [bash-language-server
](https://github.com/bash-lsp/bash-language-server). For more information,
please view their [dependencies documentation
](https://github.com/bash-lsp/bash-language-server?tab=readme-ov-file#dependencies).

In short, you will need to install the following:

- `shellcheck` - Linting
- `shfmt` - Formatting

### Linux Installation

```bash
sudo apt-get install shellcheck shfmt
```

### Homebrew Installation

```bash
brew install shellcheck shfmt
```

[^1]: Linting is only available for Bash and POSIX Shell.
