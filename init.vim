" 基本設定
syntax enable
filetype plugin indent on
colorscheme iceberg

set fenc=utf-8
set ignorecase
set smartcase
set wrapscan
set incsearch
set inccommand=split
set clipboard+=unnamed
set hlsearch
set autoread
set hidden
set showcmd

set number
set cursorline
" set cursorcolumn
set virtualedit=onemore
set smartindent
set visualbell
set laststatus=2
set showmatch

nnoremap j gj
vnoremap j gj
nnoremap k gk
vnoremap k gk
inoremap <C-c> <ESC>

" VimPlug
call plug#begin('~/.vim/plugged')

Plug 'vim-jp/vimdoc-ja'
Plug 'sheerun/vim-polyglot'
" lsp
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'rust-lang/rust.vim'

Plug 'natebosch/vim-lsc'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

autocmd FileType vue syntax sync fromstart

call plug#end()

let g:lsp_async_completion = 1

" デバッグ用設定
let g:lsp_log_verbose = 1  " デバッグ用ログを出力
let g:lsp_log_file = expand('~/.cache/tmp/vim-lsp.log')  " ログ出力のPATHを設定

" 言語用Serverの設定
augroup MyLsp
  autocmd!
  " pip install python-language-server
  if executable('pyls')
    " Python用の設定を記載
    " workspace_configで以下の設定を記載
    " - pycodestyleの設定はALEと重複するので無効にする
    " - jediの定義ジャンプで一部無効になっている設定を有効化
    autocmd User lsp_setup call lsp#register_server({
        \ 'name': 'pyls',
        \ 'cmd': { server_info -> ['pyls'] },
        \ 'whitelist': ['python'],
        \ 'workspace_config': {'pyls': {'plugins': {
        \   'pycodestyle': {'enabled': v:false},
        \   'jedi_definition': {'follow_imports': v:true, 'follow_builtin_imports': v:true},}}}
        \})
    autocmd FileType python call s:configure_lsp()
  endif
  if executable('vls')
	  let g:LanguageClient_serverCommands = {
				  \ 'vue': ['vls']
				  \ }
	  autocmd FileType vue call s:configure_lsp()
  endif
  if executable('typescript-language-server')
	  autocmd User lsp_setup call lsp#register_server({
				  \ 'name': 'typescript-language-server',
				  \ 'cmd': { server_info->[&shell, &shellcmdflag, 'typescript-language-server --stdio']},
				  \ 'whitelist': ['typescript', 'javascript', 'javascript.jsx']
				  \ })
	  autocmd FileType typescript call s:configure_lsp()
  endif
  if executable('golsp')
	  augroup LspGo
		  au!
		  autocmd User lsp_setup call lsp#register_server({
					  \ 'name': 'go-lang',
					  \ 'cmd': {server_info->['golsp', '-mode', 'stdio']},
					  \ 'whitelist': ['go'],
					  \ })
		  autocmd FileType go setlocal omnifunc=lsp#complete
	  augroup END
  endif
  augroup END
" 言語ごとにServerが実行されたらする設定を関数化
function! s:configure_lsp() abort
  setlocal omnifunc=lsp#complete   " オムニ補完を有効化
  " LSP用にマッピング
  nnoremap <buffer> <C-]> :<C-u>LspDefinition<CR>
  nnoremap <buffer> gd :<C-u>LspDefinition<CR>
  nnoremap <buffer> gD :<C-u>LspReferences<CR>
  nnoremap <buffer> gs :<C-u>LspDocumentSymbol<CR>
  nnoremap <buffer> gS :<C-u>LspWorkspaceSymbol<CR>
  nnoremap <buffer> gQ :<C-u>LspDocumentFormat<CR>
  vnoremap <buffer> gQ :LspDocumentRangeFormat<CR>
  nnoremap <buffer> K :<C-u>LspHover<CR>
  nnoremap <buffer> <F1> :<C-u>LspImplementation<CR>
  nnoremap <buffer> <F2> :<C-u>LspRename<CR>
endfunction
let g:lsp_diagnostics_enabled = 0  " 警告やエラーの表示はALEに任せるのでOFFにする

