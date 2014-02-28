syntax on
filetype on
if isdirectory($HOME . '/.vim') 
	  let $MY_VIMRUNTIME = $HOME.'/.vim'
endif
"-------------------------------------------------------------------------------
"" 基本設定
"----------------------------------------------------------------------------
set autoread                      "他で書き換えられた場合、自動で読みなおす
set noswapfile                    "swapをつくらない
set hidden                        "編集中でも他のファイルを開けるようにする
set backspace=indent,eol,start    "backspaceで消せるようにする
set vb t_vb=                      "ビープ音を鳴らさない
set clipboard=unnamed             "OSのクリップボードを使用する
set list                          "タブ文字、行末など不可視文字を表示する
set listchars=tab:>-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%
set ruler                         "カーソルが何行目の何列目に置かれているかを表示する
set number                        "行番号表示
"ステータスライン
set statusline=%{expand('%:p:t')}\ %<[%{expand('%:p:h')}]%=\ %m%r%y%w[%{&fenc!=''?&fenc:&enc}][%{&ff}][%3l,%3c,%3p]
"ステータス行を表示
set laststatus=2


hi Comment ctermfg=9
hi SpecialKey ctermfg=4

function! s:RestoreCursorPostion()
	if line("'\"") <= line("$")
		normal! g`"
		return 1
	endif
endfunction
" ファイルを開いた時に、以前のカーソル位置を復元する
augroup vimrc_restore_cursor_position
	autocmd!
	autocmd BufWinEnter * call s:RestoreCursorPostion()
augroup END
"-------------------------------------------------------------------------------
"" 検索系
"-------------------------------------------------------------------------------
set ignorecase						"小文字の検索でも大文字も見つかるようにする
set smartcase                      "ただし大文字も含めた検索の場合はその通りに検索する
set incsearch                      "インクリメンタルサーチを行う
"-------------------------------------------------------------------------------
"" タブ系
"-------------------------------------------------------------------------------
set smarttab
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=4
set smartindent                     "新しい行を開始したときに、新しい行のインデントを現在行と同じ量にする
set autoindent
"-------------------------------------------------------------------------------
"" その他設定
"-------------------------------------------------------------------------------
set hlsearch                       "highlight matches with last search pattern

"actionscript setting
autocmd BufNewFile,BufRead *.as set filetype=actionscript

"-------------------------------------------------------------------------------
""NeoBundle
"-------------------------------------------------------------------------------

if has('vim_starting')
 set runtimepath+=~/.vim/bundle/neobundle.vim
endif
call neobundle#rc(expand('~/.vim/bundle/'))

"なんかあったら勝手にインストールはじめます
if has('vim_starting')
    if len(neobundle#get_not_installed_bundle_names())
        :NeoBundleInstall
    endif
endif

NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/unite.vim.git'
NeoBundle 'Shougo/vimshell.git'
NeoBundle 'Shougo/vimproc'
NeoBundle 'Shougo/unite-outline'
NeoBundle 'ujihisa/unite-colorscheme.git'
NeoBundle 'JavaScript-syntax'
NeoBundle 'timcharper/textile.vim'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'tyru/open-browser.vim'
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'Lokaltog/vim-powerline'
NeoBundle 'tpope/vim-markdown'
NeoBundle 'Shougo/vimfiler'
NeoBundle 'kien/ctrlp.vim.git'
NeoBundle 'sudo.vim'
NeoBundle 'deris/vim-duzzle'
NeoBundle 'sudar/vim-arduino-syntax'
NeoBundle 'kmnk/vim-unite-giti'

"NeoBundle 'skammer/vim-css-color'


filetype plugin indent on	"required

"-------------------------------------------------------------------------------
""Unite
"-------------------------------------------------------------------------------
nnoremap <silent> <Space>g :Unite giti<CR>
let g:unite_split_rule = 'botright'

"-------------------------------------------------------------------------------
""Unite outline
"-------------------------------------------------------------------------------
nnoremap <Space>t :<C-u>Unite -buffer-name=outline -vertical -no-quit -winwidth=45 outline<CR>
"-------------------------------------------------------------------------------
""vimshell
"-------------------------------------------------------------------------------
let g:vimshell_popup_command = 'topleft sp | execute "resize " .g:my_vimshell_popup() | set winfixheight'
function! g:my_vimshell_popup()
    return winheight(0) * g:vimshell_popup_height / 90
endfunction

autocmd! Filetype vimfiler call g:my_vimfiler_settings()
function! g:my_vimfiler_settings()
    nnoremap <buffer>b :Unite bookmark -default-action=cd -buffer-name=bookmark<CR>
endfunction

nnoremap <silent> <Space>s :VimShell<CR>
"-------------------------------------------------------------------------------
""ctrlp
"-------------------------------------------------------------------------------
let g:ctrlp_use_migemo = 1
let g:ctrlp_clear_cache_on_exit = 0   " 終了時キャッシュをクリアしない
let g:ctrlp_mruf_max            = 5000 " MRUの最大記録数
let g:ctrlp_open_new_file       = 1   " 新規ファイル作成時にタブで開く
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files']
"-------------------------------------------------------------------------------
""Color
"-------------------------------------------------------------------------------
NeoBundle 'tomasr/molokai'
NeoBundle 'altercation/solarized'
NeoBundle 'vim-scripts/newspaper.vim'
NeoBundle 'nanotech/jellybeans.vim'

:try
    colorscheme jellybeans
:catch
:endtry
"-------------------------------------------------------------------------------
""vimfiler
"-------------------------------------------------------------------------------
command! Vf VimFiler -buffer-name=explorer -split -simple -winwidth=35 -toggle -no-quit
nnoremap <silent> <Space>f :Vf<CR>

let g:vimfiler_tree_leaf_icon = ' '
let g:vimfiler_file_icon = '-'
let g:vimfiler_marked_file_icon = '*'
let g:vimfiler_enable_auto_cd = 1

"-------------------------------------------------------------------------------
""SyntaxCheck
"-------------------------------------------------------------------------------
let g:syntastic_check_on_open=0 "ファイルを開いたときはチェックしない
let g:syntastic_check_on_save=1 "保存時にはチェック
let g:syntastic_auto_loc_list=1 "エラーがあったら自動でロケーションリストを開く
let g:syntastic_loc_list_height=6 "エラー表示ウィンドウの高さ
set statusline+=%#warningmsg# "エラーメッセージの書式
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
"let g:syntastic_javascript_checker = 'jshint' "jshintを使う
let g:syntastic_mode_map = {
      \ 'mode': 'active',
      \ 'active_filetypes': ['ruby', 'javascript'],
      \ 'passive_filetypes': []
      \ }
"エラー表示マークを変更
let g:syntastic_enable_signs=1
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'


"-------------------------------------------------------------------------------
""PHP
"-------------------------------------------------------------------------------
autocmd BufRead *.php\|*.ctp\|*.tpl :set dictionary=~/.vim/dict/php.dict filetype=php


let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_smart_case = 1
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_manual_completion_start_length = 0
let g:neocomplcache_caching_percent_in_statusline = 1
let g:neocomplcache_enable_skip_completion = 1
let g:neocomplcache_skip_input_time = '0.5'

"-------------------------------------------------------------------------------
""その他ショートカット
"-------------------------------------------------------------------------------
"ウィンドウ移動
"nnoremap <Space>j <c-w>j
"nnoremap <Space>k <c-w>k
"nnoremap <Space>h <c-w>h
"nnoremap <Space>l <c-w>l

"カーソル横移動
noremap <Space>h  ^
noremap <Space>l  $
