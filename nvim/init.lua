-- Tecla líder

vim.g.mapleader = " "

-- Bootstrap 
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Aparência
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"

-- Indentação
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Usabilidade
vim.opt.mouse = "a"
vim.opt.clipboard = "unnamedplus"
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Busca
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- Cursor
vim.opt.cursorline = true

-- Atalhos
local map = vim.keymap.set

map("v", "<C-c>", '"+y', { desc = "Copiar" })
map("n", "<C-v>", '"+p', { desc = "Colar" })
map("i", "<C-v>", "<C-r>+", { desc = "Colar" })
map("c", "<C-v>", "<C-r>+", { desc = "Colar" })
map("v", "<C-v>", '"+p', { desc = "Colar" })
map("n", "<C-q>", "<C-v>", { desc = "Visual de bloco" })
map("v", "<C-x>", '"+d', { desc = "Recortar" })
map("v", "<BS>", '"_d', { desc = "Apagar seleção" })
map("v", "<Del>", '"_d', { desc = "Apagar seleção" })
map("n", "<Tab>", "i", { desc = "Entrar no modo insert" })

-- Plugins
require("lazy").setup({
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
        transparent_background = true,
      })
      vim.cmd.colorscheme("catppuccin")
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    opts = { options = { theme = "auto", globalstatus = true } },
  },

  {
    "goolord/alpha-nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")

      dashboard.section.header.val = {
        "",
        " ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗",
        " ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║",
        " ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║",
        " ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║",
        " ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║",
        " ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝",
        "",
      }

      -- cor roxa do logo
      vim.api.nvim_set_hl(0, "AlphaHeader", { fg = "#b48cff" })
      dashboard.section.header.opts.hl = "AlphaHeader"

      dashboard.section.buttons.val = {
        dashboard.button("n", "  Novo arquivo", "<cmd>ene<CR>"),
        dashboard.button("r", "  Arquivos recentes", "<cmd>oldfiles<CR>"),
        dashboard.button("c", "  Configuração", "<cmd>e ~/.config/nvim/init.lua<CR>"),
        dashboard.button("l", "  Plugins (Lazy)", "<cmd>Lazy<CR>"),
        dashboard.button("q", "  Sair", "<cmd>qa<CR>"),
      }

            dashboard.section.footer.val = "Bem-vindo, Ryan"

      alpha.setup(dashboard.opts)
    end,
  },
})
