//! Support for Bash, Zsh, and POSIX shell scripts via https://github.com/bash-lsp/bash-language-server.
#![warn(clippy::pedantic, clippy::nursery)]

use zed_extension_api as zed;

struct ShellExtension;

impl zed::Extension for ShellExtension {
    fn new() -> Self {
        todo!()
    }

    fn language_server_command(
        &mut self,
        language_server_id: &zed_extension_api::LanguageServerId,
        worktree: &zed_extension_api::Worktree,
    ) -> zed_extension_api::Result<zed_extension_api::Command> {
        todo!()
    }
}

zed::register_extension!(ShellExtension);
