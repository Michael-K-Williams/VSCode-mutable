{ pkgs ? import <nixpkgs> {} }:

{
  vscode-mutable = pkgs.callPackage ./vscode.nix {};
}
