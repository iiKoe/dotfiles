-- Options
vim.g.mapleader = " "

vim.opt.ignorecase = true -- Ignore case in search
vim.opt.smartcase = true -- Search case sensitive when using an uppercase
vim.opt.confirm = true -- Instead of failing if a buffer is unsaved, ask

vim.opt.mouse = 'a'

vim.opt.termguicolors = true -- Enable true colors

vim.opt.number = true -- Enable line numbers

-- TAB settings
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.smarttab = true -- not strictly needed

-- Theme
vim.cmd("colorscheme onehalfdark")

-- Highlight the current line
vim.opt.cursorline = true

-- Mappings
local function map(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end

local function nmap(shortcut, command)
  map('n', shortcut, command)
end

local function imap(shortcut, command)
  map('i', shortcut, command)
end

local function vmap(shortcut, command)
  map('v', shortcut, command)
end

-- Split movement
nmap("<c-j>", "<c-w>j")
nmap("<c-k>", "<c-w>k")
nmap("<c-l>", "<c-w>l")
nmap("<c-h>", "<c-w>h")

-- Misc bindings
nmap("<Leader>r", ":nohl<CR>") -- disable highlights

-- Tabs
nmap("H", ":tabn<CR>")
nmap("L", ":tabp<CR>")
nmap("<Leader>t", ":tabnew<CR>")
nmap("<Leader>q", ":tabclose<CR>")

-- Splits
nmap("<Leader>v", ":split<CR>")
nmap("<Leader>b", ":vsplit<CR>")

-- Big steps
nmap("J", "<c-d>")
nmap("K", "<c-u>")

-- NvimTree plugin
nmap("<Leader>N", ":NvimTreeToggle<CR>")

-- Hop (easymotion alternative) movement
nmap("<Leader>h", ":HopWordCurrentLineBC<CR>") -- Move left
nmap("<Leader>l", ":HopWordCurrentLineAC<CR>") -- Move right
nmap("<Leader>j", ":HopLineAC<CR>") -- Move down
nmap("<Leader>k", ":HopLineBC<CR>") -- Move up

-- Formatter
nmap("<Leader>fm", ":Neoformat<CR>")
vmap("<Leader>fm", ":Neoformat<CR>")

-- Git
nmap("<Leader>gg", ":LazyGit<CR>")

-- Toggle between paste mode
local system_clipboard_toggle = false
function SystemClipboardToggle()
    if system_clipboard_toggle then
        system_clipboard_toggle = false
        vim.cmd("set nopaste")
        vim.cmd("set clipboard-=unnamedplus")
        print("VIM clipbard")
    else
        system_clipboard_toggle = true
        vim.cmd("set paste")
        vim.cmd("set clipboard^=unnamedplus")
        print("System clipboard")
    end
end
nmap("<leader>p", ":lua SystemClipboardToggle()<CR>")

--https://www.notonlycode.org/neovim-lua-config/
--Config not finished, need to auto load stuff etc
require('user.plugins')

--- Plugin configurations
local _, _ = pcall(require, 'autocomplete.setup')

local _, _ = pcall(require, 'lspconfig')

local ok, nvim_tree = pcall(require, 'nvim-tree')
if ok then
  nvim_tree.setup {
    open_on_setup       = false,
    open_on_tab         = true,
    git = {
        ignore = false,
    },
  }
end

local ok, hop = pcall(require, 'hop')
if ok then
  hop.setup { keys='asdfghjkl;qwertyuiopzxcvbnm' }
end

