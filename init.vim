call plug#begin('~/.config/nvim/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.8' }
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

Plug 'mfussenegger/nvim-dap'
Plug 'nvim-neotest/nvim-nio'
Plug 'rcarriga/nvim-dap-ui'


call plug#end()

set number
set guicursor=   " Делает курсор классическим, как в Vim
set relativenumber
set cursorline
set hlsearch
set backspace=indent,eol,start
set mouse=a
set ignorecase
set belloff=all
set hidden 
set expandtab
set smarttab
set tabstop=8
set shiftwidth=8
set laststatus=2
set nobackup
set nowritebackup
set updatetime=300

syntax on

set background=dark

colorscheme tango 
inoremap {<CR> {<CR>}<Esc>ko

highlight CursorLine cterm=underline ctermbg=None 
highlight CursorLine gui=underline  

let g:coc_global_extensions = [
  \ 'coc-pairs',
  \ 'coc-clangd',
  \ 'coc-kotlin'
  \ ]

inoremap <silent><expr> <c-space> coc#refresh()

inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

inoremap <silent><expr> <Tab> coc#pum#visible() ? coc#pum#confirm() : "\<Tab>"
autocmd BufWritePost *.cpp,*.h silent! !clang-format -i %


" Бинды для Telescope
nnoremap <C-f> <cmd>Telescope find_files<cr>
nnoremap <C-g> <cmd>Telescope live_grep<cr>

" Telescope fzf plugin
lua << EOF
require('telescope').load_extension('fzf')
EOF

lua require('my_modules.cowboy').cowboy()

lua << EOF
local dap = require("dap")

-- Настройка адаптера GDB
dap.adapters.gdb = {
  type = "executable",
  command = "gdb",  -- Убедитесь, что gdb установлен и доступен в PATH
  args = { "--interpreter=dap" }
}

-- Настройка конфигураций для C++
dap.configurations.cpp = {
  {
    name = "Launch",
    type = "gdb",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = "${workspaceFolder}",
    stopAtEntry = false,
  },
  {
    name = "Attach",
    type = "gdb",
    request = "attach",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    pid = function()
      return require("dap.utils").pick_process()
    end,
    cwd = "${workspaceFolder}",
  },
}
EOF









