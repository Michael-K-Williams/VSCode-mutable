# VSCode-Nix

A NixOS flake for installing Visual Studio Code in a mutable way, allowing for extensions and settings to be modified after installation.

## Features

- Installs VS Code to `/opt/vscode-mutable` by default
- Creates desktop entries and symlinks
- Configurable installation directory and download URLs
- Support for custom fonts
- Proper library dependencies via nix-ld

## Usage

### Direct NixOS Module Import

You can import the module directly in your NixOS configuration without adding it as a flake input:

```nix
{
  imports = [
    (builtins.getFlake "github:Michael-K-Williams/VSCode-mutable/main").nixosModules.default
  ];

  programs.vscode-mutable = {
    enable = true;
    userName = "yourusername";
  };
}
```

### As a Flake Input

Add to your `flake.nix`:

```nix
```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    vscode-mutable = {
      url = "github:Michael-K-Williams/VSCode-mutable/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, vscode-mutable, ... }: {
    nixosConfigurations.yourhostname = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        vscode-mutable.nixosModules.default
        {
          programs.vscode-mutable = {
            enable = true;
            userName = "yourusername";
          };
        }
      ];
    };
  };
}
```
```

### Standalone Usage

```bash
# Run directly
nix run github:Michael-K-Williams/VSCode-mutable/main

# Build and install
nix build github:Michael-K-Williams/VSCode-mutable/main
./result/bin/vscode-mutable-installer
```

## Configuration Options

- `userName`: Username for VS Code installation (required)
- `installDir`: Installation directory (default: `/opt/vscode-mutable`)
- `vscodeUrl`: Primary download URL
- `fallbackUrl`: Fallback download URL if primary fails
- `fonts`: List of fonts to install for VS Code

## Why Mutable Installation?

Some VS Code extensions require modifying VS Code's actual application files to function properly, such as extensions that provide custom image backgrounds, theming modifications, or other deep UI customizations. The traditional Nix store approach makes these files read-only, preventing such extensions from working.

This mutable installation approach allows:

- Extensions that modify VS Code's core files (like image background extensions)
- Deep theming and UI customization extensions
- Extensions and settings to be installed and updated normally
- Settings and configurations to persist
- VS Code to update itself through its built-in update mechanism
- Better integration with system desktop environments

## License

This project is licensed under the MIT License.
