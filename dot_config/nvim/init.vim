set number " add line numbers
set relativenumber
set ttyfast " speed up scrolling
set tabstop=2 " tab size 2 spaces
set expandtab
set shiftwidth=2
set autoindent " auto indent newline just as much as previous line
" set nocompatible " disable compat with vi
set showmatch 
filetype plugin indent on " allows auto indenting depending on type of file
" set autochdir
set scrolloff=20

let mapleader="\<SPACE>"

call plug#begin()
  Plug 'numToStr/Comment.nvim'
  Plug 'ellisonleao/gruvbox.nvim'
  Plug 'preservim/nerdtree'
  Plug 'whatyouhide/vim-gotham'
  Plug 'arcticicestudio/nord-vim'
  Plug 'neovim/nvim-lspconfig'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
  Plug 'hashivim/vim-terraform'
  Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
  Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}
  Plug 'ms-jpq/coq.thirdparty', {'branch': '3p'}
  Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
  Plug 'ellisonleao/gruvbox.nvim'
  Plug 'sonph/onehalf', { 'rtp': 'vim' }

  Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'} " this is for auto complete, prettier and tslinting

  Plug 'jiangmiao/auto-pairs' "this will auto close ( [ {

  " these two plugins will add highlighting and indenting to JSX and TSX files.
  Plug 'yuezk/vim-js'
  Plug 'HerringtonDarkholme/yats.vim'
  Plug 'maxmellon/vim-jsx-pretty'
  Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
call plug#end()


let g:coc_global_extensions = ['coc-tslint-plugin', 'coc-tsserver', 'coc-css', 'coc-html', 'coc-json', 'coc-prettier']  " list of CoC extensions needed

let g:LanguageClient_serverCommands = {
    \ 'sh': ['bash-language-server', 'start']
    \ }

set termguicolors
colorscheme gruvbox

" NERDTree keybinds
nnoremap <F1> :NERDTreeToggle<CR>
nnoremap <leader>f :NERDTreeFind<cr>

" Telescope keybinds
nnoremap <leader>ff :Telescope git_files<cr>
" nnoremap <leader>fg :lua require('telescope.builtin').live_grep({search_dirs=cwd})<CR>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>

let g:coq_settings = { 'auto_start': 'shut-up' }

lua << EOF

-- require('telescope').setup{ defaults = { file_ignore_patterns = { "vendor" } } }
require('telescope').setup()
require('Comment').setup()

-- Comment.nvim mappings
local opt = { expr = true, remap = true }

-- Toggle using count
-- vim.keymap.set('n', '<C-/>', "v:count == 0 ? '<Plug>(comment_toggle_current_linewise)' : '<Plug>(comment_toggle_linewise_count)'", opt)
-- vim.keymap.set('n', '<C-', "v:count == 0 ? '<Plug>(comment_toggle_current_blockwise)' : '<Plug>(comment_toggle_blockwise_count)'", opt)

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end


--local configs = require 'lspconfig/configs'
--
--if not configs.golangcilsp then
-- 	configs.golangcilsp = {
--		default_config = {
--			cmd = {'golangci-lint-langserver'},
--			root_dir = lspconfig.util.root_pattern('.git', 'go.mod'),
--			init_options = {
--					command = { "golangci-lint", "run", "--enable-all", "--disable", "lll", "--out-format", "json" };
--			}
--		};
--	}
--end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'pyright', 'gopls' }
for _, lsp in pairs(servers) do
  require('lspconfig')[lsp].setup {
    on_attach = on_attach,
    flags = {
      -- This will be the default in neovim 0.7+
      debounce_text_changes = 150,
    }
  }
end

require'lspconfig'.golangci_lint_ls.setup{}


EOF
