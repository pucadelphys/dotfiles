" <C-v> to inspect key
" coc in .local/share/nvim/plugged/coc.nvim

syntax on

call plug#begin()
Plug 'http://github.com/tpope/vim-surround'
Plug 'https://github.com/jiangmiao/auto-pairs'
Plug 'https://github.com/vim-airline/vim-airline'
Plug 'https://github.com/preservim/nerdtree.git'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'https://github.com/preservim/tagbar'
Plug 'https://github.com/vimwiki/vimwiki.git'
Plug 'lervag/vimtex'
Plug 'https://github.com/lilydjwg/colorizer.git'
Plug 'https://github.com/junegunn/goyo.vim.git'
Plug 'https://github.com/junegunn/fzf.vim'
Plug 'https://github.com/junegunn/fzf'
Plug 'https://github.com/mbbill/undotree'
Plug 'https://github.com/tpope/vim-repeat'
Plug 'https://github.com/tommcdo/vim-lion'
Plug 'https://github.com/pangloss/vim-javascript'
Plug 'https://github.com/jalvesaq/Nvim-R'
Plug 'snakemake/snakemake', {'rtp': 'misc/vim'}
" Colors
Plug 'dylanaraps/wal.vim'
Plug 'flazz/vim-colorschemes'
Plug 'https://github.com/stillwwater/vim-nebula'
Plug 'https://github.com/jcherven/jummidark.vim'
Plug 'https://github.com/wadackel/vim-dogrun'
Plug 'https://github.com/pgavlin/pulumi.vim'
Plug 'https://github.com/arzg/vim-colors-xcode'
Plug 'https://github.com/Mizux/vim-colorschemes'
call plug#end()

autocmd FileChangedRO * echohl WarningMsg | echo "File changed RO." | echohl None
autocmd FileChangedShell * echohl WarningMsg | echo "File changed shell." | echohl None

autocmd FileType * setlocal formatoptions-=o
au BufNewFile,BufRead *.ejs set filetype=html


set autoindent
set breakindent
set clipboard=unnamedplus
set confirm
set display=truncate
set encoding=utf-8
set fillchars+=eob:\ 
set expandtab
" set formatoptions=jcrql
set hidden
set ignorecase
set linebreak
set list
set listchars=tab:▸\ ,trail:·,leadmultispace:│\ \ \ 
set mouse=a
set number
set relativenumber
set scrolloff=5
set shiftwidth=4
set signcolumn=number
set smartcase
set softtabstop=4
set splitright
set tabstop=4
set t_Co=256
set title
" set colorcolumn=80
set noswapfile
set nobackup
set undodir=~/.config/nvim/undodir
set undofile
"set termguicolors!
"setlocal spell! spelllang=en_us
set spelllang=es
"set nowrap
"set sidescrolloff=5
"set something? to inspect it

let mapleader = " "
" let g:AutoPairsFlyMode = 1
" let NERDTreeQuitOnOpen=1

vnoremap p "_dP
nnoremap <leader>f za
nnoremap <leader>t :NERDTreeToggle<CR>
nmap <C-c> <Plug>Colorizer
nmap<F1> <nop>
imap ^@ <CR>
nnoremap <leader>c :call ToggleComment()<cr>
vnoremap <leader>c :call ToggleComment()<cr>
map <leader>h :set hlsearch!<CR>
map <leader>n :set relativenumber!<CR>
map <leader>b :TagbarToggle<CR>
map <leader>s :set spell!<CR>
noremap <leader>a :call AutoPairsToggle()<CR>
map <Up> gk
map <Down> gj
" noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
" noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')
nnoremap <C-h> :wincmd h<CR>
nnoremap <C-j> :wincmd j<CR>
nnoremap <C-k> :wincmd k<CR>
nnoremap <C-l> :wincmd l<CR>
nnoremap <C-S-R> :wincmd R<CR>
nnoremap <C-S-H> :wincmd H<CR>
nnoremap <C-S-J> :wincmd J<CR>
nnoremap <C-S-K> :wincmd K<CR>
nnoremap <C-S-L> :wincmd L<CR>

vnoremap il :<C-U>normal ^vg_<CR>
omap il :normal vil<CR>
nnoremap <leader>u :UndotreeToggle<CR>

" coc remaps
nnoremap <C-_> :BLines<CR>
inoremap <silent><expr> <C-space> coc#pum#visible() ? coc#pum#confirm() : "\<C-space>"
inoremap <silent><expr> <C-j> coc#pum#visible() ? coc#pum#next(1) : "\<C-j>"
inoremap <silent><expr> <C-k> coc#pum#visible() ? coc#pum#prev(1) : "\<C-k>"
let g:coc_snippet_next = '<C-l>'
let g:coc_snippet_prev = '<C-h>'

command! -nargs=0 Prettier :CocCommand prettier.forceFormatDocument

" Toggle comment function
let s:comment_map = {"c": '\/\/', "cpp": '\/\/', "go": '\/\/', "java": '\/\/', "javascript": '\/\/', "lua": '--', "scala": '\/\/', "php": '\/\/', "python": '#', "ruby": '#', "rust": '\/\/', "sh": '#', "desktop": '#', "fstab": '#', "conf": '#', "profile": '#', "bashrc": '#', "bash_profile": '#', "mail": '>', "eml": '>', "bat": 'REM', "ahk": ';', "vim": '"', "tex": '%', "yaml": '#', "julia": '#' }

let s:comment_mult = {"html":['<!--', '-->'], "css": ['\/*', '*\/']}

 function! ToggleComment() range
    if has_key(s:comment_map, &filetype)
        let comment_leader = s:comment_map[&filetype]
        if getline('.') =~ "^\\s*" . comment_leader . " "
            " Uncomment the line
            execute "silent" . a:firstline . "," a:lastline . "s/^\\(\\s*\\)" . comment_leader . " /\\1/"
        else
            if getline('.') =~ "^\\s*" . comment_leader
                " Uncomment the line
                execute "silent" . a:firstline . "," a:lastline . "s/^\\(\\s*\\)" . comment_leader . "/\\1/"
            else
                " Comment the line
                execute "silent" . a:firstline . "," a:lastline . "s/^\\(\\s*\\)/\\1" . comment_leader . " /"
            end
        end

    elseif has_key(s:comment_mult, &filetype)
        let [l:start, l:end] = s:comment_mult[&filetype]
        if getline(a:firstline) =~ "^" . substitute(l:start, '*',  '\\*', '') . " " && getline(a:lastline) =~ " " . substitute(l:end, '*',  '\\*', '') . "$"
            execute (a:firstline) 's/^' . substitute(l:start, '*',  '\\*', '') . ' //'
            execute (a:lastline) 's/ ' . substitute(l:end, '*',  '\\*', '') . '$//'
        else
            execute (a:firstline) 's/^/' . l:start . ' /'
            execute (a:lastline) 's/$/ ' . l:end . '/'
        end
    else
        echo "No comment leader found for filetype"
    end
endfunction

let g:autosave = 1
autocmd FileChangedRO * let g:autosave = 0
autocmd InsertLeave * call AutoSave()
autocmd TextChanged * call AutoSave()

function AutoSave()
    if g:autosave == 1
        silent! update
    else
        return
    endif
endfunction

function! SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(synIDtrans(v:val), "name")')
endfunc
nnoremap <leader>y :call SynStack()<CR>

let g:pastevar = 1
function! CustomRegister()
    if g:pastevar
        vnoremap d "_d
        nnoremap d "_d
        let g:pastevar = 0
        echo "Defaults to ""_ register"
    else
        unmap p
        unmap d
        let g:pastevar = 1
        echo "Standard register settings"
    endif
endfunc

nnoremap <leader>p :call CustomRegister()<CR>
let g:vimtex_view_method = 'zathura'
let g:vimtex_quickfix_mode = 0

hi VimwikiHeader1 guifg=1
hi VimwikiHeader2 guifg=2
hi VimwikiHeader3 guifg=3
hi VimwikiHeader4 guifg=4
hi VimwikiHeader5 guifg=5
hi VimwikiHeader6 guifg=6

set notermguicolors
colorscheme wal
echo "(>^.^<)"

