# shell.zed

Support for Bash, POSIX Shell, and ZSH.

- Tree Sitter: [tree-sitter-bash](https://github.com/tree-sitter/tree-sitter-bash)
- Language Server: [bash-language-server](https://github.com/bash-lsp/bash-language-server)

## Features

- Syntax Highlighting
  - Adapted From: [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter/blob/master/queries/bash/highlights.scm)
  - Highlights Command Flags
- Comprehensive Bracket Jumping
- Smart Indentation
- Linting* and Formatting (when dependencies are installed)

- *: Linting is only available for Bash and POSIX Shell.

## Linting and Formatting

Linting and formatting is handled through [bash-language-server
](https://github.com/bash-lsp/bash-language-server). For more information,
please view their [dependencies documentation
](https://github.com/bash-lsp/bash-language-server?tab=readme-ov-file#dependencies).

In short, you will need to install the following:

- `shellcheck` - Linting
- `shfmt` - Formatting

### Linux

```bash
sudo apt-get install shellcheck shfmt
```

### Homebrew

```bash
brew install shellcheck shfmt
```
