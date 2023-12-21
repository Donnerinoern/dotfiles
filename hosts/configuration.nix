{ inputs, config, pkgs, lib, ... }:

{
  imports = [
    inputs.chaotic.nixosModules.default
    ./hardware-configuration.nix
    ./home-manager.nix
  ];
  
  # Bootloader.
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelPackages = pkgs.linuxPackages_latest;
    initrd.kernelModules = [ "kvm-amd" "amdgpu" ];
  };
  
  virtualisation.libvirtd.enable = true;

  networking = {
    hostName = "donnan-stasj";
    networkmanager.enable = true;
    wireless.enable = false;
  };

  systemd = {
    network.wait-online.enable = false;
    services.NetworkManager-wait-online.enable = false;
  };

  services.postgresql = {
    enable = true;
    ensureDatabases = [ "mydatabase" ];
    authentication = pkgs.lib.mkOverride 10 ''
      #type database DBuser origin-address auth-method
      local all      all                   trust
      host  all      all    127.0.0.1/32   trust
      host  all      all    ::1/128        trust
      '';
  };
  
  nix = {
    settings = {
      experimental-features = "nix-command flakes";
    };
  };

  # Set your time zone.
  time.timeZone = "Europe/Oslo";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "nb_NO.UTF-8";
    LC_IDENTIFICATION = "nb_NO.UTF-8";
    LC_MEASUREMENT = "nb_NO.UTF-8";
    LC_MONETARY = "nb_NO.UTF-8";
    LC_NAME = "nb_NO.UTF-8";
    LC_NUMERIC = "nb_NO.UTF-8";
    LC_PAPER = "nb_NO.UTF-8";
    LC_TELEPHONE = "nb_NO.UTF-8";
    LC_TIME = "nb_NO.UTF-8";
  };

  # Configure console keymap
  console.keyMap = "no";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  services.udisks2.enable = true;
  services.fstrim.enable = true;
  security.polkit.enable = true;
  
  services.greetd = {
    enable = true;
    settings = {
      default_session.command = ''
        ${pkgs.greetd.tuigreet}/bin/tuigreet \
        --time \
        --asterisks \
        --user-menu \
        --cmd Hyprland
      '';
    };
  };
  
  environment.etc."greetd/environments".text = ''
    Hyprland
  '';

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.donnan = {
    isNormalUser = true;
    description = "Donnan"; # TODO: Encrypt my real name. Add it here.
    extraGroups = [ "networkmanager" "wheel" "input" ];
    shell = pkgs.fish;
  };

  # Allow unfree packages
  nixpkgs = {
    config = {
      allowUnfree = true;
      permittedInsecurePackages = [
        "electron-25.9.0"
      ];
    };
    overlays = [
      inputs.neovim-nightly-overlay.overlay
      inputs.rust-overlay.overlays.default
      inputs.zig-overlay.overlays.default
    ];
  };

  chaotic.mesa-git.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [ # TODO: Move most of these to home.packages
    xwaylandvideobridge
    armcord
    glxinfo
    go
    gamescope
    ripgrep
    fd
       
    playerctl
    hyprpaper
    grim
    slurp
    ranger
    nwg-look
    wl-clipboard

    the-powder-toy
    protontricks

    nodejs
    sqlite
    audacity
    
    spotify
    webcord-vencord
    gimp
    neofetch
    bun
    python3
    prismlauncher

    zoom-us
    jetbrains.idea-ultimate

    vesktop
    rust-bin.stable.latest.default
    zigpkgs.master
  ];

  environment = {
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
      MOZ_USE_XINPUT2 = "1";
      XDG_CURRENT_DESKTOP = "hyprland";
    };
  };

  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      roboto
      source-code-pro
      iosevka
      nerdfonts
     ];
  };

  programs = {
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      package = pkgs.steam.override {
        extraPkgs = pkgs: with pkgs; [
          libkrb5
          keyutils
        ];
      };
    };
    
    hyprland = {
      enable = true;
    };
    
    ssh.startAgent = true;
    
    fish.enable = true;
  };
  
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  #networking.firewall.allowedTCPPorts = [
  #];
  #networking.firewall.allowedUDPPorts = [
  #];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}
