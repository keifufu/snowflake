#
#  Laptop specific hardware configuration.
#
#  flake.nix
#   └─ ./hosts
#       ├─ hosts.nix
#       └─ ./laptop
#           ├─ configuration.nix !
#           └─ hardware-configuration.nix *
#

{ lib, modulesPath, host, ... }:

{
  imports = [(modulesPath + "/installer/scan/not-detected.nix")];

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  services.tlp.enable = true;
}
