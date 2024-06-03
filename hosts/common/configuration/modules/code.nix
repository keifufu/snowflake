{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    nodejs_18
    nodePackages.pnpm
    bun
    rustup
    clang-tools
    gf
    virtualenv
    (pkgs.python3.withPackages(ps: with ps; [ aiohttp opencv4 ]))
  ];
}