{pkgs, inputs, ... }: 

{
	imports = [
		inputs.catppuccin.homeModules.catppuccin
	];
	home = {
		username = "tungle";
		homeDirectory = "/home/tungle";
  		stateVersion = "26.05";
		packages = with pkgs; [
			catppuccin-cursors.frappeBlue
			papirus-icon-theme
			catppuccin-kde
		];
	};



	catppuccin = {
		autoEnable = true;
		flavor = "frappe";
	};

	programs = {
		kitty = {
			enable = true;
			themeFile = "Catppuccin-Frappe";	
			settings = {
				font_family = "JetBrainsMono Nerd Font";
				font_size = "12";
			};
		};

		plasma = {
			enable = true;
			configFile = {
				kwinrc = {
					Plugins = {
						wobblywindowsEnabled = true;
						magiclampEnabled = true;
						windowgeometryEnabled = true;
					};
					Windows = {
						CornerRadius = 3; 
					};
				};
			};
		};

		bash = {
			enable = true;
    			bashrcExtra = ''
				parse_git_branch() {
     					git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
				}

				export PROMPT_COLOR='32m'
				export DIR_COLOR='33m'
				export GIT_COLOR='36m'
				export PS1="\n\[\033[$PROMPT_COLOR\]\u@\h:\[\033[$DIR_COLOR\]\w\[\033[$GIT_COLOR\] \$(parse_git_branch)\[\033[0m\]\$ " 
			 '';
	  	};

		neovim = {
			enable = true;
			defaultEditor = true;
		
			initLua = ''
				vim.opt.number = true
				vim.opt.relativenumber = true

				vim.opt.timeoutlen = 500
			'';
		};

		home-manager.enable = true;
	};
}

