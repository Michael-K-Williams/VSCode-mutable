{ pkgs ? import <nixpkgs> {} }:

{
  vscode-mutable = pkgs.callPackage ./vscode.nix {};
  vscode-fhs = pkgs.callPackage ./vscode-fhs.nix {};
}
