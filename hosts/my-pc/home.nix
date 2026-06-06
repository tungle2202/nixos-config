{pkgs, ... }: 

{

	home.username = "tungle";
	home.homeDirectory = "/home/tungle";

  	home.stateVersion = "26.05";

	programs.bash = {
		enable = true;
    		bashrcExtra = ''
			export PROMPT_COLOR='32m'
			export DIR_COLOR='33m'
			export GIT_COLOR='36m'
			export PS1="\n\[\033[$PROMPT_COLOR\]\u@\h:\[\033[$DIR_COLOR\]\w\[\033[0m\]\$ " 
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

