{}:

{
  config = {
    fileSystems."/" = {
      device = "tmpfs";
      fsType = "tmpfs";
      # You must set mode=755. The default is 777, and OpenSSH will complain and disallow logins
      options = [ "relatime" "mode=755" ];
    };

    fileSystems."/nix" = {
      device = "/dev/vda2";
      fsType = "ext4";
    };
  };
}
