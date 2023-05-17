local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
  -- Grammar
  'nvim-treesitter/nvim-treesitter',
  'wellle/targets.vim',
  -- 'sheerun/vim-polyglot',

  -- Colors
  'mhartington/oceanic-next',
  {
    'dracula/vim',
    lazy = false,
  },
  'bluz71/vim-nightfly-colors',
  'nvim-tree/nvim-web-devicons',
  'NvChad/nvim-colorizer.lua',
  {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons'
  },
  'folke/twilight.nvim',

  -- navigation
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.0',
    dependencies = { { 'nvim-lua/plenary.nvim' } }
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
    lazy = false,
  },
  {
    'dinhhuy258/sfm.nvim',
    dependencies = {
      "dinhhuy258/sfm-fs.nvim",
      "dinhhuy258/sfm-git.nvim"
    },
  },
  'theprimeagen/harpoon',

  -- lsp
  'tpope/vim-rails',
  "jose-elias-alvarez/null-ls.nvim",
  {
    "jay-babu/mason-null-ls.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "jose-elias-alvarez/null-ls.nvim",
    }
  },
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    dependencies = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' }, -- Required
      {
        -- Optional
        'williamboman/mason.nvim',
        build = function()
          ---@diagnostic disable-next-line: param-type-mismatch
          pcall(vim.cmd, 'MasonUpdate')
        end,
      },
      { 'williamboman/mason-lspconfig.nvim' }, -- Optional

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },     -- Required
      { 'hrsh7th/cmp-nvim-lsp' }, -- Required
      { 'hrsh7th/cmp-path' },
      { 'hrsh7th/cmp-buffer' },
      { "github/copilot.vim" },

      -- Snippets
      { 'L3MON4D3/LuaSnip' }, -- Required
      "rafamadriz/friendly-snippets",
      'saadparwaiz1/cmp_luasnip',
      -- 'Sirver/ultisnips',

      -- Formatters
      -- "lukas-reineke/lsp-format.nvim",
      -- 'mhartington/formatter.nvim',
      'MunifTanjim/prettier.nvim',
      "jose-elias-alvarez/null-ls.nvim",
    }
  },
  {
    "glepnir/lspsaga.nvim",
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
      --Please make sure you install markdown and markdown_inline parser
      { "nvim-treesitter/nvim-treesitter" }
    },
  },

  -- git
  'tpope/vim-fugitive',
  'lewis6991/gitsigns.nvim',

  -- not setup yet
  'vim-test/vim-test',
  'preservim/vimux',
  'christoomey/vim-tmux-navigator',

  -- debugging
  'mfussenegger/nvim-dap',
  'rcarriga/nvim-dap-ui',
  'simrat39/rust-tools.nvim',

  -- Linters
  'mfussenegger/nvim-lint',

  -- Ui (Optional)
  'j-hui/fidget.nvim',
  'arkav/lualine-lsp-progress',


  -- misc
  'nvim-lualine/lualine.nvim',
  'mbbill/undotree',
  'jiangmiao/auto-pairs',
  'tpope/vim-surround',
  'tpope/vim-repeat',
  'tpope/vim-commentary',
  'lukas-reineke/indent-blankline.nvim',
  'tpope/vim-abolish',
  'tpope/vim-dispatch',
  'tpope/vim-bundler',
  'vim-scripts/BufOnly.vim',
  'airblade/vim-rooter',
  "folke/which-key.nvim"
}

local opts = {}

require("lazy").setup(plugins, opts)
