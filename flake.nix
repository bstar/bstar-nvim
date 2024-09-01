
{
  description = "A Lua-natic's neovim flake, with extra cats! nixCats!";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils = {
      url = "github:numtide/flake-utils";
      inputs.nixpkgs.follows = "nixpkgs"; 
    };

    "plugins-trouble" = {
      url = "github:folke/trouble.nvim";
      flake = false;
    };
    "plugins-nui" = {
      url = "github:MunifTanjim/nui.nvim";
      flake = false;
    };
    "plugins-chatGPT" = {
      url = "github:jackMort/ChatGPT.nvim";
      flake = false;
    };
    "plugins-copilot" = {
      url = "github:github/copilot.vim";
      flake = false;
    };
    "plugins-oil" = {
      url = "github:stevearc/oil.nvim";
      flake = false;
    };
    "plugins-nvim-dap-vscode-js" = {
      url = "github:mxsdev/nvim-dap-vscode-js";
      flake = false;
    };
    "plugins-conform" = {
      url = "github:stevearc/conform.nvim";
      flake = false;
    };
    "plugins-prettier" = {
      url = "github:MunifTanjim/prettier.nvim";
      flake = false;
    };
    "plugins-colorizer" = {
      url = "github:NvChad/nvim-colorizer.lua";
      flake = false;
    };
    "plugins-tailwindcss-colorizer-cmp" = {
      url = "github:roobert/tailwindcss-colorizer-cmp.nvim";
      flake = false;
    };
    "plugins-mini-indentscope" = {
      url = "github:echasnovski/mini.indentscope";
      flake = false;
    };
    "plugins-telescope-file-browser" = {
      url = "github:nvim-telescope/telescope-file-browser.nvim";
      flake = false;
    };
    "plugins-rose-pine" = {
      url = "github:rose-pine/neovim";
      flake = false;
    };
    "plugins-onedark-vim" = {
      url = "github:joshdick/onedark.vim";
      flake = false;
    };
    "plugins-catppuccin" = {
      url = "github:catppuccin/nvim";
      flake = false;
    };
    "plugins-gitsigns" = {
      url = "github:lewis6991/gitsigns.nvim";
      flake = false;
    };
    "plugins-which-key" = {
      url = "github:folke/which-key.nvim";
      flake = false;
    };
    "plugins-lualine" = {
      url = "github:nvim-lualine/lualine.nvim";
      flake = false;
    };
    "plugins-lspconfig" = {
      url = "github:neovim/nvim-lspconfig";
      flake = false;
    };
    "plugins-Comment" = {
      url = "github:numToStr/Comment.nvim";
      flake = false;
    };
    "plugins-hlargs" = {
      url = "github:m-demare/hlargs.nvim";
      flake = false;
    };
    "plugins-harpoon" = {
      url = "github:ThePrimeagen/harpoon";
      flake = false;
    };
    "plugins-fidget" = {
      url = "github:j-hui/fidget.nvim/legacy";
      flake = false;
    };

    nixd.url = "github:nix-community/nixd";
  };

  outputs = { self, nixpkgs, flake-utils, ... }@inputs:
    flake-utils.lib.eachDefaultSystem (system: let
      overlays = (import ./overlays inputs) ++ [
        inputs.nixd.outputs.overlays.default
      ];
      pkgs = import nixpkgs {
        inherit system overlays;
      };

      helpPath = "${self}/nixCatsHelp";
      nixVimBuilder = import ./builder helpPath self pkgs categoryDefinitions;

      categoryDefinitions = {
        propagatedBuildInputs = {
          generalBuildInputs = with pkgs; [
          ];
        };

        lspsAndRuntimeDeps = {
          general = with pkgs; [
            universal-ctags
            ripgrep
            fd
          ];
          neonixdev = with pkgs; [
            nix-doc
            nil
            lua-language-server
            nixd
          ];
        };

        startupPlugins = {
          debug = with pkgs.vimPlugins; [
            nvim-dap
            nvim-dap-ui
            nvim-dap-virtual-text
          ];
          neonixdev = with pkgs.vimPlugins; [
            neodev-nvim
            neoconf-nvim
          ];
          markdown = with pkgs.customPlugins; [
            markdown-preview-nvim
          ];
          gitPlugins = with pkgs.neovimPlugins; [
            catppuccin
            onedark-vim
            rose-pine
            gitsigns
            which-key
            harpoon
            lspconfig
            lualine
            hlargs
            Comment
            fidget
            telescope-file-browser
            colorizer
            tailwindcss-colorizer-cmp
            conform
            oil
            copilot
            nui
            chatGPT
            trouble
            nvim-dap-vscode-js
          ];
          general = with pkgs.vimPlugins; [
            telescope-fzf-native-nvim
            plenary-nvim
            telescope-nvim
            nvim-treesitter-textobjects
            nvim-treesitter.withAllGrammars
            nvim-cmp
            luasnip
            friendly-snippets
            cmp_luasnip
            cmp-buffer
            cmp-path
            cmp-nvim-lua
            cmp-nvim-lsp
            cmp-cmdline
            cmp-nvim-lsp-signature-help
            cmp-cmdline-history
            lspkind-nvim
            vim-sleuth
            vim-fugitive
            vim-rhubarb
            vim-repeat
            undotree
            nvim-surround
            indent-blankline-nvim
            nvim-web-devicons
          ];
        };

        optionalPlugins = {
          custom = with pkgs.customPlugins; [ ];
          gitPlugins = with pkgs.neovimPlugins; [ ];
          general = with pkgs.vimPlugins; [ ];
        };

        environmentVariables = {
          test = {
            CATTESTVAR = "It worked!";
          };
        };

        extraWrapperArgs = {
          test = [
            '' --set CATTESTVAR2 "It worked again!"''
          ];
        };

        extraPythonPackages = {
          test = [ (_:[]) ];
        };
        extraPython3Packages = {
          test = [ (_:[]) ];
        };
        extraLuaPackages = {
          test = [ (_:[]) ];
        };
      };

      settings = {
        nixCats = {
          wrapRc = true;
          configDirName = "bstar-nvim";
          viAlias = false;
          vimAlias = true;
        };
        unwrappedLua = {
          wrapRc = false;
          configDirName = "bstar-nvim";
          viAlias = false;
          vimAlias = true;
        };
      };

      packageDefinitions = {
        nixCats = nixVimBuilder {
          settings = settings.nixCats;
          categories = {
            generalBuildInputs = true;
            markdown = true;
            gitPlugins = true;
            general = true;
            custom = true;
            neonixdev = true;
            test = true;
            debug = true;
            lspDebugMode = false;
            colorscheme = "rose-pine";
            theWorstCat = {
              thing1 = [ "MEOW" "HISSS" ];
              thing2 = [
                {
                  thing3 = [ "give" "treat" ];
                }
                "I LOVE KEYBOARDS"
              ];
              thing4 = "couch is for scratching";
            };
          };
        };

        regularCats = nixVimBuilder {
          settings = settings.unwrappedLua;
          categories = {
            generalBuildInputs = true;
            markdown = true;
            gitPlugins = true;
            general = true;
            custom = true;
            neonixdev = true;
            debug = true;
            test = true;
            lspDebugMode = false;
            colorscheme = "rose-pine";
            theWorstCat = {
              thing1 = [ "MEOW" "HISSS" ];
              thing2 = [
                {
                  thing3 = [ "give" "treat" ];
                }
                "I LOVE KEYBOARDS"
              ];
              thing4 = "couch is for scratching";
            };
          };
        };
      };

    in {
      overlays = { default = self: super: { inherit (packageDefinitions) nixCats; }; }
        // builtins.mapAttrs (name: value: (self: super: { ${name} = value; })) packageDefinitions;

      packages = { default = packageDefinitions.nixCats; }
        // packageDefinitions;

      devShell = pkgs.mkShell {
        name = "nixCats.nvim";
        packages = [ packageDefinitions.nixCats ];
        inputsFrom = [ ];
        shellHook = ''
        '';
      };
      customPackager = nixVimBuilder;
      standardPluginOverlay = import ./overlays/standardPluginOverlay.nix;
      customBuilders = {
        fresh = import ./builder helpPath self;
        merged = newPkgs: categoryDefs:
          (import ./builder helpPath self (pkgs // newPkgs) (categoryDefinitions // categoryDefs));
        newLuaPath = import ./builder helpPath;
        mergedNewLuaPath = path: newPkgs: categoryDefs:
          (import ./builder helpPath path (pkgs // newPkgs) (categoryDefinitions // categoryDefs));
      };
    }
  ); # end of flake utils, which returns the value of outputs
}

