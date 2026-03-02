
{ pkgs, hostname, username, ... }:

#############################################################
#
#  Host & Users configuration
#
#############################################################

{
  networking.hostName = hostname;
  networking.computerName = hostname;
  system.defaults.smb.NetBIOSName = hostname;

  # Required in nix-darwin 25.05 for options that apply to a specific user
  system.primaryUser = username;

  users.users."${username}"= {
    home = "/Users/${username}";
    description = username;
    shell = pkgs.zsh;
  };

  nix.settings.trusted-users = [ username ];
}
