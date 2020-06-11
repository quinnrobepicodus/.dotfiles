"  █░     ▄  ▄     ▄      ▄    ▄▄▄       ▄▄
"  ██▒   █▓  ██▓  ███▄ ▄███▓  ▐█▀███   ▄████▄
" ▓██░   █▒ ▓██▒ ▓██▒▀█▀ ██▒ ▓██ ▒ ██ ▒██▀  ▀
"  ▓██  ██░▒▒██▒ ▓██▒ ▐ ▓██░ ▓██ ░▄█▓ ▒██
"   ▒██▐█░░ ░██░ ▒██▒   ▒██  ▒██▓▀█▄▒ ▒▓█▒  ▄█▒
"    ▒▀█░   ░██░ ▒▐█▒ ░ ░▓█▒ ░██▓ ▒██▒░ ██▓█▀ ░
"    ░ ▐░   ░▓   ░▐▒░   ░ ▓░ ░▓▒░ ░▒▓░░ ░▒▓▒  ░
"    ░ ░░   ▒ ░░  ▐░      ░   ░▒   ▒░  ░▒ ▒
"      ░░   ▒ ░░  ░    ░      ░    ░ ░
"       ░   ░          ░             ░ ░
"      ░                            ░


" ==============================================================================
" Plugins (Vim-plug)
" ==============================================================================
call plug#begin('~/.vim/plugged')
Plug 'preservim/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'wikitopian/hardmode'
Plug 'vim-syntastic/syntastic'
Plug 'tomasiser/vim-code-dark'
Plug 'alvan/vim-closetag'
Plug 'octol/vim-cpp-enhanced-highlight', {
      \ 'for': 'cpp' }
Plug 'fatih/vim-go', {
      \ 'for': 'go',
      \ 'do': ':GoUpdateBinaries',
      \ 'branch': 'master'}
Plug 'exu/pgsql.vim', {
      \ 'for': 'sql' }
"Plug 'yuezk/vim-js', {
      "\ 'for': ['javascript', 'jsx']}
Plug 'pangloss/vim-javascript', {
      \ 'for': ['javascript', 'jsx']}
Plug 'maxmellon/vim-jsx-pretty', {
      \ 'for': ['javascript', 'jsx']}
"Plug 'dense-analysis/ale', {
      "\ 'for': ['javascript', 'jsx']}
call plug#end()


" ==============================================================================
" Color Settings
" ==============================================================================
if has('termguicolors')
  set termguicolors
endif

set background=dark
colorscheme codedark
set cursorline
set hlsearch

hi Comment cterm=italic gui=italic
hi Pmenu gui=NONE guibg=grey guifg=black
hi Pmenu cterm=NONE ctermbg=grey ctermfg=black
hi PmenuSel gui=NONE guibg=blue guifg=white
hi PmenuSel cterm=NONE ctermbg=blue ctermfg=white
hi StatusLine gui=NONE guibg=white guifg=black
hi StatusLine cterm=NONE ctermbg=white ctermfg=black
hi StatusLineTerm gui=NONE guibg=white guifg=black
hi StatusLineTerm cterm=NONE ctermbg=white ctermfg=black
hi StatusLineNC gui=NONE guibg=grey42 guifg=black
hi StatusLineNC cterm=NONE ctermbg=243 ctermfg=black
hi SpellBad guibg=red guifg=white
hi SpellBad ctermbg=red ctermfg=white
hi SpellCap guibg=red guifg=white
hi SpellCap ctermbg=red ctermfg=white
hi SpellRare guibg=magenta guifg=black
hi SpellRare ctermbg=magenta ctermfg=black
hi SpellLocal guibg=grey guifg=black
hi SpellLocal ctermbg=grey ctermfg=black
hi TabLineSel gui=NONE guibg=grey guifg=black
hi TabLineSel cterm=NONE ctermbg=grey ctermfg=black
hi Terminal guibg=black
hi Terminal ctermbg=black
hi WildMenu gui=NONE guibg=blue guifg=white
hi WildMenu cterm=NONE ctermbg=blue ctermfg=white

let g:go_highlight_build_constraints=1
let g:go_highlight_functions=1
let g:go_highlight_methods=1
let g:go_highlight_operators=1
let g:go_highlight_structs=1
let g:go_highlight_variable_assignments=1
let g:go_highlight_variable_declarations=1
let g:go_mod_fmt_autosave=1
let g:sql_type_default='pgsql'

" Fixes terminal colors when termguicolors is enabled for some colorschemes
if exists('g:terminal_ansi_colors')
  unlet g:terminal_ansi_colors
endif

" Gets current value of a given highlight group
fun! GetHighlight(group)
  let highlight_value = execute('hi ' . a:group)
  let items = split(highlight_value,  'xxx ')
  return items[1]
endfun

" Changes the cursor line background to black when in insert mode.
augroup vimrc_insert_mode
  let g:current_cursorline_color = GetHighlight('CursorLine')
  au InsertEnter * hi CursorLine guibg=black ctermbg=black
  au InsertLeave * execute('hi CursorLine ' . g:current_cursorline_color)
augroup end

" Changes cursorline and statusbar when entering / leaving a window
augroup vimrc_window
  au BufEnter * setlocal cursorline
  au BufLeave * setlocal nocursorline
augroup end


" ==============================================================================
" Statusline
" ==============================================================================
set statusline=%f\ "
set statusline+=%r
set statusline+=%=
set statusline+=%l/%L\ \ "
set statusline+=%v\ \ "
set statusline+=0x%B
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*


" ==============================================================================
" Formatting
" ==============================================================================
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 1
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_eslint_exec = 'node_modules/.bin/eslint'
let g:syntastic_jsx_eslint_exec = 'node_modules/.bin/eslint'

" Minimizes the syntastic popup window
function! SyntasticCheckHook(errors)
    if !empty(a:errors)
        let g:syntastic_loc_list_height = min([len(a:errors), 10])
    endif
endfunction

fun! TrimWhitespace()
  let l:save=winsaveview()
  keeppatterns %s/\s\+$//e
  call winrestview(l:save)
endfun

fun! CPPFormatSettings()
  setlocal equalprg=clang-format\ -style=google
  setlocal makeprg=mingw32-make.exe
  let g:syntastic_cpp_compiler_options='-std=c++11'
endfun

fun! GoFormatSettings()
  setlocal equalprg=gofmt
endfun

fun! DefaultFormatSettings()
  setlocal formatoptions-=ro
endfun

fun! MarkdownFormatSettings()
  setlocal formatoptions+=tcro
endfun

fun! JavascriptFormatSettings()
  let g:syntastic_cpp_compiler_options='-std=c++11'
endfun

augroup vimrc_formatting
  autocmd FileType * call DefaultFormatSettings()
  autocmd BufWritePre * call TrimWhitespace()
  autocmd FileType c,cpp call CPPFormatSettings()
  autocmd FileType go call GoFormatSettings()
  autocmd FileType markdown call MarkdownFormatSettings()
augroup end


" =========================================
" Editing Behavior / Miscellaneous Settings
" =========================================
set autoread
set clipboard+=unnamed,unnamedplus
set completeopt=menu,preview
set hidden
set lazyredraw
set linebreak breakindent breakat=\ ^I!@*-+;:,./?(){}[]\\" showbreak=!>>>
set noincsearch ignorecase smartcase
set nomodeline modelines=0
set noshowmatch
set number relativenumber
set scrolloff=10
set spelllang=en_us
set splitright splitbelow
set undofile undodir=~/.vim/tmp/undo
set wildignore=*.o,*.obj,*.swp,node_modules,.git,*.exe
set wildmenu wildmode=longest,full:list
set sessionoptions=buffers
      \,curdir
      \,folds
      \,help
      \,localoptions
      \,tabpages

let NERDTreeRespectWildIgnore=1
let NERDTreeShowHidden=1

" Prevents NERDTree from opening twice in some cases
let g:NERDTreeHijackNetrw=0

" Prevents Netrw from being loaded during startup
let g:loaded_netrw=1

" Closetag plugin settings
let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.js,*.jsx'
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx'
let g:closetag_emptyTags_caseSensitive = 1
let g:closetag_regions = {
    \ 'typescript.tsx': 'jsxRegion,tsxRegion',
    \ 'javascript.jsx': 'jsxRegion',
    \ }
let g:closetag_shortcut = '>'


" ============================
" Helper functions / variables
" ============================
let g:vimrc_notes_file='~/.vim/notes.txt'
let g:vimrc='~/.vim/vimrc'
let g:vimrc_snippet_path='~/.vim/snippets/'
let g:vimrc_istoggled=0

" Close NERDTree if all other buffers have been closed
fun! NERDTreeAutoClose()
  if (winnr('$') == 1
        \ && exists('b:NERDTree'))
    q
  endif
endfun

" Opens / closes the notes file specified in g:vimrc_notes_file
fun! ToggleNotes()
  let win_number = bufwinnr(g:vimrc_notes_file)
  if win_number != -1
    execute(win_number . 'wincmd w')
    silent update
    q
  else
    execute('sp ' . g:vimrc_notes_file)
    wincmd J
    $
    if getline(".") != ""
      normal o
    endif
    setlocal keywordprg=:help
  endif
endfun

" If a directory is opened, start NERDTree and set path / workspace. If a
" session file exists, resume the session.
fun! OpenDirectory()
  if (argc() == 1
        \ && isdirectory(argv()[0])
        \ && !exists('s:std_in'))
    execute('NERDTree ' . argv()[0])
    wincmd p
    execute('cd ' . argv()[0])
    let &path=getcwd()
    wincmd p
    if (findfile('Session.vim') == 'Session.vim')
      source ./Session.vim
      execute('NERDTreeToggle')
      wincmd =
    endif
  endif
endfun

" If a directory is opened and a session exists, save it before closing
fun! SaveSession()
  execute('NERDTreeClose')
  if (argc() == 1 && isdirectory(argv()[0])
        \ && winnr("$") >= 1
        \ && findfile('Session.vim') == 'Session.vim')
    mksession!
  endif
endfun

" Creates a snippet by reading from a file. The file path is stored in
" g:vimrc_snippet_path. Pass the file name of the snippet and
" a prompt for user input as arguments. For no user input, use an empty string.
fun! CreateSnippet(snippet, prompt)
  if (a:prompt != '')
    let old_line_count = line('$')
    silent call inputsave()
    let name = input(a:prompt)
    silent call inputrestore()
    execute('0read ' . g:vimrc_snippet_path . a:snippet)
    let snippet_line_count = line('$') - old_line_count
    execute('silent .,+' . snippet_line_count . 's/' . a:snippet . '/' . name)
  else
    execute('0read ~/.vim/snippets/' . a:snippet)
  endif
  return ''
endfun

" Checks if the cursor is between two html tags and auto indents when enter is
" pressed. Handy when used in combo with the Closetags plugin.
fun! IndentTags()
  if (matchstr('<', getline('.')[col('.') - 1]) != ''
        \ && matchstr('>', getline('.')[col('.') - 2]) != '')
    return "\<CR>\<Esc>O\<Tab>"
  else
    return "\<CR>"
  endif
endfun

augroup vimrc_editing
  autocmd BufEnter * call NERDTreeAutoClose()
  autocmd VimEnter * call OpenDirectory()
  autocmd VimLeavePre * call SaveSession()
augroup end


" ==============================================================================
" Keymaps / Commands / Abbreviations:
" ==============================================================================
let mapleader=" "
let NERDTreeMapOpenVSplit='v'
let NERDTreeMapOpenSplit='s'

"Normal mode
nnoremap <Space> <nop>
nnoremap <leader><CR> o<Esc>
nnoremap <silent> <leader><Tab> :NERDTreeToggle<CR><C-W>=
nnoremap <silent> <leader>` :call ToggleNotes()<CR>
nnoremap <leader>= gg=G2<C-O>
nnoremap <silent> <leader>t :wincmd b \| bel term<CR>git status<CR>
nnoremap <leader>] :bn<CR>
nnoremap <leader>[ :bp<CR>
nnoremap <leader>1 :b1<CR>
nnoremap <leader>2 :b2<CR>
nnoremap <leader>3 :b3<CR>
nnoremap <leader>4 :b4<CR>
nnoremap <leader>5 :b5<CR>
nnoremap <leader>6 :b6<CR>
nnoremap <leader>7 :b7<CR>
nnoremap <leader>8 :b8<CR>
nnoremap <leader>9 :b9<CR>
nnoremap <C-h> <C-W>h
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-l> <C-W>l
nmap ++ <plug>NERDCommenterToggle

" Command mode
command W w
command Q q
command WQ wq
command Wq wq
command Vimrc tabnew ~/.vim/vimrc
command ReactComponent call CreateSnippet('ReactComponent', 'Name: ')
      \| call execute('normal {{i<Tab><Tab><Tab>')
      \| startinsert!

" Visual mode
vnoremap < <gv
vnoremap > >gv
vmap ++ <plug>NERDCommenterToggle

" Insert mode
inoremap {<CR> {<CR>}<Esc>O
inoremap [<CR> [<CR>]<Esc>O
inoremap (<CR> (<CR>)<Esc>O
inoremap <expr> <CR> IndentTags()
inoreabbrev DATETIME <C-R>=strftime("%c")<CR>
inoreabbrev LOREMIPSUM Lorem ipsum dolor sit amet, consectetur adipiscing
      \ elit, sed do eiusmod tempor incididunt ut labore et dolore magna
      \ aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco
      \ laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor
      \ in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla
      \ pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa
      \ qui officia deserunt mollit anim id est laborum."
