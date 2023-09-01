# kcctl-nix

Nix [flake](https://nixos.wiki/wiki/Flakes) for [kcctl](https://github.com/kcctl/kcctl)

## Usage

This `kcctl` `nix` flake assumes you have already [installed nix](https://determinate.systems/posts/determinate-nix-installer)

### Option 1. Use the `kcctl` CLI within your own flake

```nix
{
  inputs.nixpkgs.url = "github:nixos/nixpkgs";
  inputs.kcctl.url = "github:rupurt/kcctl-nix";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    kcctl,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [
            kcctl.overlay
          ];
        };
      in rec
      {
        packages = {
          kcctl = pkgs.kcctl {};
        };

        devShells.default = pkgs.mkShell {
          packages = [
            packages.kcctl
          ];
        };
      }
    );
}
```

The above config will add `kcctl` to your dev shell and also allow you to execute it
through the `nix` CLI utilities.

```sh
# run from devshell
nix develop -c $SHELL
kcctl
```

```sh
# run default package
nix run
```

### Option 2. Run the `kcctl` CLI directly with `nix run`

```nix
nix run github:rupurt/kcctl-nix
```

## Authors

- Alex Kwiatkowski - alex+git@fremantle.io

## License

`kcctl-nix` is released under the MIT license
