//! LSP support for Bash and POSIX shell scripts, highlighting for ZSH.

#![warn(clippy::pedantic, clippy::nursery)]

use zed_extension_api::{self as zed, LanguageServerInstallationStatus};

const SERVER_PATH: &str = "node_modules/bash-language-server/out/cli.js";
const PACKAGE_NAME: &str = "bash-language-server";

#[derive(Debug)]
struct ShellExtension;

impl ShellExtension {
    fn server_exists(&self) -> bool {
        std::fs::metadata(SERVER_PATH).map_or(false, |stat| stat.is_file())
    }

    fn update_server(&mut self, language_server_id: &zed::LanguageServerId) -> zed::Result<bool> {
        zed::set_language_server_installation_status(
            language_server_id,
            &LanguageServerInstallationStatus::CheckingForUpdate,
        );

        let installed_version = zed::npm_package_installed_version(PACKAGE_NAME)?;
        let latest_version = match zed::npm_package_latest_version(PACKAGE_NAME) {
            Ok(latest_version) => latest_version,
            Err(err) => {
                // If something goes wrong, we could just fail, but it's likely
                // that the user doesn't have internet, so instead we'll use
                // the existing installed version if it exists.
                //
                // We'll actually fail if there is no installed version.

                if let Some(installed_version) = installed_version.clone() {
                    installed_version
                } else {
                    return Err(err);
                }
            }
        };

        // The language server needs an update if it's not installed, or if the
        // current version is older than the latest available.
        let needs_update = !self.server_exists()
            || installed_version
                .is_some_and(|installed_version| &installed_version != &latest_version);

        if needs_update {
            zed::set_language_server_installation_status(
                language_server_id,
                &LanguageServerInstallationStatus::Downloading,
            );

            zed::npm_install_package(PACKAGE_NAME, &latest_version)?;
        }

        Ok(true)
    }
}

impl zed::Extension for ShellExtension {
    fn new() -> Self {
        Self
    }

    fn language_server_command(
        &mut self,
        language_server_id: &zed::LanguageServerId,
        worktree: &zed::Worktree,
    ) -> zed::Result<zed::Command> {
        // If `bash-language-server` is already installed, we won't bother
        // installing it ourselves.
        if let Some(path) = worktree.which(PACKAGE_NAME) {
            return Ok(zed::Command {
                command: path,
                args: vec!["start".to_string()],
                env: Default::default(),
            });
        }

        // We're here assuming that `bash-language-server` does not exist, so
        // we'll update it if it does exist, or install it if it doesn't.
        self.update_server(language_server_id)?;

        let script_path = std::env::current_dir()
            .expect("Failed to get the current directory")
            .join(SERVER_PATH);

        Ok(zed::Command {
            command: zed::node_binary_path()?,
            args: vec![script_path.display().to_string(), "start".to_string()],
            env: Default::default(),
        })
    }
}

zed::register_extension!(ShellExtension);
