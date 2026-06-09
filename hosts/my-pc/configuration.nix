{ config, pkgs, inputs, ... }:

{
	imports = [./hardware-configuration.nix] ++ [ inputs.fcitx5-lotus.nixosModules.fcitx5-lotus ];

	boot.loader = {
		systemd-boot.enable = true;
		efi.canTouchEfiVariables = true;
	};

  	time.timeZone = "Asia/Ho_Chi_Minh";

  	networking = {
		hostName = "nixos";
  		networkmanager.enable = true;
	};

  	fonts = {
		packages = with pkgs; [
			inter
			nerd-fonts.jetbrains-mono
		];

		fontconfig.defaultFonts = {
			sansSerif = ["Inter"];
			serif = ["Inter"];
			monospace = ["JetBrainsMono Nerd Font"];
		};
	};

  	i18n = {
		defaultLocale = "en_US.UTF-8";

		inputMethod = {
			enable = true;
			type = "fcitx5";
			fcitx5.addons = with pkgs; [
				inputs.fcitx5-lotus.packages.${pkgs.stdenv.hostPlatform.system}.fcitx5-lotus
			];
		};

		extraLocaleSettings = {
			LC_ADDRESS = "vi_VN";
			LC_IDENTIFICATION = "vi_VN";
			LC_MEASUREMENT = "vi_VN";
			LC_MONETARY = "vi_VN";
			LC_NAME = "vi_VN";
			LC_NUMERIC = "vi_VN";
			LC_PAPER = "vi_VN";
			LC_TELEPHONE = "vi_VN";
			LC_TIME = "vi_VN";
		};
	};

  	services = {
		displayManager = {
			sddm = {
				enable = true;
				wayland.enable = true;
			};
		};

		desktopManager = {
			plasma6.enable = true;
		};

		printing.enable = true;

		pulseaudio.enable = false;

		pipewire = {
			enable = true;
			alsa.enable = true;
			alsa.support32Bit = true;
			pulse.enable = true;
		};
	};

  	environment = {
		plasma6.excludePackages = with pkgs.kdePackages; [
			kate
			okular
			konsole
			elisa
			gwenview
		];

		variables = {
			GTK_IM_MODULE = "fcitx";
			QT_IM_MODULE = "fcitx";
			XMODIFIERS = "@im=fcitx";
			TERMINAL = "kitty";
			TERM = "xterm-kitty";
		};

		systemPackages = with pkgs; [
			neovim 
			wget
			git
			wl-clipboard
			kitty
			fastfetch
			jetbrains.idea
			direnv
		];
	};


  	security.rtkit.enable = true;

  	users.users."tungle" = {
   		isNormalUser = true;
    		description = "Le Son Tung";
    		extraGroups = [ "networkmanager" "wheel" ];
  	};

  	home-manager = {
  		useUserPackages = true;
		useGlobalPkgs = true;
		backupFileExtension = "backup";
  	};
  	programs = {
  		firefox.enable = true;
		nix-ld = {
			enable = true;
			libraries = with pkgs; [
				stdenv.cc.cc.lib
				zlib
				fuse3
				alsa-lib
				cups
				libGL
				libuuid
				libx11
				libxext
				libxrender
				libxrandr
				libxcb
				libxcursor
				libxshmfence
				libxxf86vm
				wayland
				libxkbcommon
				glfw
				freetype
				fontconfig
			];
		};
	};

	nixpkgs.config.allowUnfree = true;
	nix.settings.experimental-features = ["nix-command" "flakes"];

	system.stateVersion = "26.05";

}
