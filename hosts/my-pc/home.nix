{pkgs, inputs, ... }: 

{
	imports = [
		inputs.catppuccin.homeModules.catppuccin
	];
	home.username = "tungle";
	home.homeDirectory = "/home/tungle";
  	home.stateVersion = "26.05";

	catppuccin = {
		enable = true;
		flavor = "frappe";
	};

	programs.kitty = {
		enable = true;
		themeFile = "Catppuccin-Frappe";	
		settings = {
			font_family = "JetBrainsMono Nerd Font";
			font_size = "12";
		};
	};

	programs.plasma = {
		enable = true;
		workspace.lookAndFeel = "Catppuccin-Frappe";
	};

	programs.bash = {
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

	programs.neovim = {
		enable = true;
		defaultEditor = true;
		
		initLua = ''
			vim.opt.number = true
			vim.opt.relativenumber = true

			vim.opt.timeoutlen = 500
		'';
	};

	programs.home-manager.enable = true;
}

