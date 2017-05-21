" vim: set sw=4 ts=4 sts=4 et tw=78 foldmarker={,} foldlevel=0 foldmethod=marker :
"
" .vimrc de E. Manuel Cerrón Ángeles
"
"    ___  __
"   |   ||  |
"    | | / /                    __
"    | |/ (_)_ _ _  _____ ___  / /____  ____
"    |   / /  ' \ |/ / -_) _ \/ __/ _ \/ __/
"    |__/_/_/_/_/___/\__/_//_/\__/\___/_/
"                                 BY XERRON©
"
" Puedes tener una versión mas actual en: http://github.com/xerron/vimventor

" Identificación de la Plataforma {
    let s:is_windows = has('win32') || has('win64')
    let s:is_cygwin = has('win32unix')
    let s:is_macvim = has('gui_macvim')
" }

"
" Configuraciones
"
" No compatibilidad con Vi {
    set nocompatible                 " Debe ser la primera línea
" }
" Neobundle {
    if s:is_windows
        set rtp+=$VIM/bundles/neobundle.vim
        set rtp+=$VIM/vimfiles
        set rtp+=$VIM
        call neobundle#begin(expand('$VIM/bundles/'))
    else
        set rtp+=~/.vim/bundles/neobundle.vim
        set rtp+=~/.vim/vimfiles
        call neobundle#begin(expand('~/.vim/bundles/'))
    endif
    NeoBundleFetch 'Shougo/neobundle.vim'
" }
" Pantalla de inicio {
    set shortmess+=I                 " Quitar el Start Screen
" }
" Consola Path {
    if s:is_windows && !s:is_cygwin
        set shell=c:\windows\system32\cmd.exe
    endif
" }
" Codificación {
    scriptencoding utf-8
    set encoding=utf-8           " Usado internamente por vim
    set fileencoding=utf-8       " Codificación de archivo
    set fileencodings=ucs-bom,utf-8,utf-16le,cp1252,iso-8859-15
    if s:is_windows
        set fileformats=dos,unix,mac
    else
        set fileformats=unix,dos,mac
    endif
" }
" Archivos de respaldo {
    set nobackup                 " No crear archivo de respaldo
    set nowritebackup            " No escrbir en el archivo de respaldo
    set noswapfile               " Buffer no guardado en memoria
" }
" General {
    " raton
    if has('mouse')
         set mouse=a                " Habilitar el uso del ratón automáticamente.
    endif
    set mousehide                   " Esconder el cursor mientras se escribe.
    " Restaurar  rar cursor a la posición anterior de la sesión
    function! ResCur()
        if line("'\"") <= line("$")
            normal! g`"
            return 1
        endif
    endfunction
    augroup resCur
        autocmd!
        autocmd BufWinEnter * call ResCur()
    augroup END
    set hidden                      " Poder cambiar de bufer sin guardar
    set history=1000                    " Aumenta la historia (por defecto es 20)
    " Para no usar "+ para copy-paste, usar directamente para pegar gP y para copiar y
    if has('clipboard')
        if has('unnamedplus')
            set clipboard=unnamedplus
        else
            set clipboard=unnamed
        endif
    endif
    set viewoptions=folds,options,cursor,unix,slash     " unix/windows compatibility
    set autoread                                        " auto reload if file saved externally
    set tags=tags;/                                     " directorio donde se encuentra los tags generados por ctags.
    set showfulltag
    set modeline                                        " activa el mode de introducir lineas del tipo vim: en la cabecera.
    set modelines=5                                     " numero de lineas procesadas
    " desactivar sonidos
    ""set noerrorbells
    ""set novisualbell
    ""set t_vb=
    "set autowrite                       " Graba automáticamente un archivo al salir de un buffer modificado
" }
" Vim UI {
    set background=dark
    " Colorsheme
    exec 'colorscheme '.g:settings.colorscheme
    " Resaltar linea actual solo en insert mode
    " set cursorline                    
    autocmd InsertEnter * set cul
    autocmd InsertLeave * set cul!
    " highlight clear SignColumn      " SignColumn con el mismo fondo
    " highlight clear LineNr          " Mismo color de fondo para la actual en relative mode
    " highlight clear CursorLineNr    " Quitar el resaltado de numero de linea.
    set number                      " Mostrar numero de linea.
    set showmatch                   " Mostrar coincidente brackets/parenthesis
    if has('syntax')
      syntax enable
    endif
    " set showmode                  " Muetra -INSERT- y similares en la parte de abajo no activo para airline
    set noshowmode                  " No mostrar --INSERT--
    " No mostrar back to original cuando se autocompleta
    try
        set shortmess+=c
    catch /^Vim\%((\a\+)\)\=:E539: Illegal character/
        autocmd MyAutoCmd VimEnter *
                    \ highlight ModeMsg guifg=bg guibg=bg |
                    \ highlight Question guifg=bg guibg=bg
    endtry
    set shiftround
    set ruler
    " set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " A ruler on steroids
    set showcmd
    set wildmenu                    " Mostrar lista en lugar de simplemente completar
    set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.idea/*,*/.DS_Store
    set wildignore+=*.o,*.out,*.obj,.git,*.rbc,*.rbo,*.class,.svn,*.gem
    set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz
    set wildignore+=*/vendor/gems/*,*/vendor/cache/*,*/.bundle/*,*/.sass-cache/*
    set wildignore+=*/tmp/librarian/*,*/.vagrant/*,*/.kitchen/*,*/vendor/cookbooks/*
    set wildignore+=*/tmp/cache/assets/*/sprockets/*,*/tmp/cache/assets/*/sass/*
    set wildignore+=*.swp,*~,._*
    set scrolljump=5                " Lines to scroll when cursor leaves screen
    set scrolloff=3                 " Minimum lines to keep above and below cursor
    ""set splitright                  " Puts new vsplit windows to the right of the current
    ""set splitbelow                  " Puts new split windows to the bottom of the current
    set laststatus=2
    "Resaltado de espacios en blanco problematicos
    " set list
    set listchars=trail:·,precedes:«,extends:»,eol:↲,tab:▸\
    " set listchars=""
    " set listchars=tab:\ \
    " set listchars+=trail:•
    " set listchars+=extends:>
    " set listchars+=precedes:<
    " visualizacion de la linea en insert mode
    if has('gui_running')
        if s:is_windows
            exec 'set guifont='.g:settings.guifont_win 
        elseif s:is_macvim
            exec 'set guifont='.g:settings.guifont_mac 
        else
            exec 'set guifont='.g:settings.guifont_linux 
        endif
    else
        set t_Co=256
        " sirve para indicar que se salio del insert mode
        if &term =~ "xterm\\|rxvt"
            " use an orange cursor in insert mode
            let &t_SI = "\<Esc>]12;orange\x7"
            " use a red cursor otherwise
            let &t_EI = "\<Esc>]12;grey\x7"
            " let &t_SR = "\<Esc>]12;red\x7"
            " silent !echo -ne "\033]12;red\007"
            " reset cursor when vim exits
            " autocmd VimLeave * silent !echo -ne "\033]112\007"
            " use \003]12;gray\007 for gnome-terminal
        endif
        " if &term == 'uxterm'
            " solid underscore
            " let &t_SI .= "\<Esc>[6 q"
            " solid block
            " let &t_EI .= "\<Esc>[2 q"
            " 1 or 0 -> blinking block
            " 3 -> blinking underscore
            " Recent versions of xterm (282 or above) also support
            " 5 -> blinking vertical bar
            " 6 -> solid vertical bar
        " endif
    endif
    " Toggle Menu and Toolbar
    if g:settings.gui_minimal == 'on'
        set guioptions-=m  "remove menu bar
        set guioptions-=T  "remove toolbar
        set guioptions-=r  "remove right-hand scroll bar
        set guioptions-=L  "remove left-hand scroll bar
    endif
" }
" Formating {
    set autoindent                  " identado Automático.
    " Autocompletado
    set pastetoggle=<F2>            " Cambia de modo de pegar, desactiva autoident
    ""set nowrap                    " Do not wrap long lines
    " set whichwrap=b,s,h,l,<,>,[,] " Envolver automaticamente al terminar la linea, pasar a otra linea cuando finaliza.
    "set tw=100                     " Maxima anchura de una linea
    set wm=0                        " No cortar la linea despues de los tw=100 caracteres
    set backspace=indent,eol,start  " permite retroceso en todo, modo inserción
    set complete-=i
    set nrformats-=octal
    set smarttab                    " Use shiftwidth to enter tabs
    set shiftwidth=4                " Use indents of 4 spaces
    set expandtab                   " Tabs are spaces, not tabs
    set tabstop=4                   " An indentation every four columns
    set softtabstop=4               " Let backspace delete indent
    set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J)
    " Tamaño prederteminado de ventana al iniciar
    if has("gui_running")
        " Esto es cuando incia Vim con un GUI
        "set lines=60 columns=60
    else
        " Esto para la consola de Vim.
        if exists("+lines")
            "set lines=50
        endif
        if exists("+columns")
            "set columns=100
        endif
    endif
" }
" Find {
    set incsearch                   " Buscar mientras se escribe la búsqueda
    set hlsearch                    " Resaltar los términos buscados
    set ignorecase                  " Busqueda case insensitive
    set smartcase                   " Busqueda case sensitive cuendo uc esta presente
    if executable('ack')
        set grepprg=ack\ --nogroup\ --column\ --smart-case\ --nocolor\ --follow\ $*
        set grepformat=%f:%l:%c:%m
    endif
    if executable('ag')
        set grepprg=ag\ --nogroup\ --column\ --smart-case\ --nocolor\ --follow
        set grepformat=%f:%l:%c:%m
    endif
" }
" Misc {
    " Fullscreen, es necesario la libreria. Ver la carpeta /vendors
    if has('gui_running') && has('gui_win32') && has('libcall')
        let g:MyVimLib = 'gvimfullscreen.dll'
        function! ToggleFullScreen()
            call libcall(g:MyVimLib, 'ToggleFullScreen', 0)
        endfunction

        map <a-F11> <esc>:call ToggleFullScreen()<cr>
    endif
" }
" Folding {
    set foldenable                  " Auto replegado de codigo (folding)
    set foldmethod=syntax
    set foldlevelstart=0
    set foldopen=block,hor,mark,percent,quickfix,tag " what movements open folds
    "let vimsyn_folding='af'
" }
" Mapping {
    let mapleader = ','        " Configuación Esencial
    "let maplocalleader = '\'        " Configuación Esencial
" }
"
" Configuración de Plugins
"
if count(g:settings.plugin_groups, 'core') "{{{
    " Mejora %
    NeoBundle 'matchit.zip'
    " Mejora la apariencia, statusbar
    NeoBundle 'bling/vim-airline'
    " Configuración de vim-airline {{{
        let g:airline#extensions#tabline#enabled = 1
        let g:airline#extensions#tabline#left_sep=' '
        let g:airline#extensions#tabline#left_alt_sep='¦'
        "let g:airline_symbols.space = "\ua0"
        let g:airline_powerline_fonts = 1
        "Declarado arriba -> set guifont=Inconsolata_for_Powerline:h10
        " Themes disponibles 'badwolf', 'bubblegum', 'base16', 'murmur', 'tomorrow',
        " 'sol', 'ubaryd', 'laederon', 'jellybeans', 'molokai', 'luna', 'solarized',
        " 'powerlineish', 'dark', 'simple', 'light',

        let g:airline_theme='base16'
    "}}}
    NeoBundle 'vim-airline/vim-airline-themes' 
    " Surround parentesis, llaves, comillas, xml tags, ...
    NeoBundle 'tpope/vim-surround'
    " Repetir comandos con .
    NeoBundle 'tpope/vim-repeat'
    " Asynchronous build and test dispatcher :Make :Copen
    NeoBundle 'tpope/vim-dispatch'
    " Helpers for UNIX | Note: ver comandos nativos
    "NeoBundle 'tpope/vim-eunuch'
    " Provee varios pares de mapas de soporte [q ]q
    NeoBundle 'tpope/vim-unimpaired'
    " Configuración de vim-unimpaired {{{
    "}}}
    " :help ayuda
    NeoBundle 'xerron/vim-doc-es'
    " /szw/vim-ctrlspace
    " Add a buffer close to vim that doesn't close the window
    " NeoBundle 'rgarver/Kwbd.vim'
    """ Configuración Kwbd {{{
        " nmap <C-W>! <Plug>Kwbd
    """}}}
    " Zoom in/out of windows (toggle between one window and multi-window)
   NeoBundle 'regedarek/ZoomWin'
    " Configuración ZoomWin {{{
        nmap <leader>zw :ZoomWin<CR>
    " }}}
    " vim interface to Web API
    NeoBundle 'mattn/webapi-vim'
endif "}}}
if count(g:settings.plugin_groups, 'markdown') "{{{
    NeoBundleLazy 'tpope/vim-markdown', {'autoload':{'filetypes':['markdown']}}
    au BufNewFile,BufRead *.markdown,*.mdown,*.mkd,*.mkdn,*.md  setf markdown

    NeoBundleLazy 'dzeban/vim-log-syntax', {'autoload':{'filetypes':['log']}}
endif "}}}
if count(g:settings.plugin_groups, 'restructuretex') "{{{
    NeoBundleLazy 'Rykka/riv.vim', {'autoload':{'filetypes':['rst']}}
    " Configuracion riv.vim {{{
        let proj1 = { 'path': '~/Dropbox/Notas',}
        let g:riv_projects = [proj1]
    " }}}
    "au BufNewFile,BufRead *.markdown,*.mdown,*.mkd,*.mkdn,*.md  setf markdown
endif "}}}
if count(g:settings.plugin_groups, 'csv') "{{{
    NeoBundleLazy 'chrisbra/csv.vim', {'autoload':{'filetypes':['csv']}}
    au BufNewFile,BufRead *.csv,*.xls setf csv
endif "}}}
if count(g:settings.plugin_groups, 'web') "{{{
    " vim syntax for LESS (dynamic CSS) 
    "NeoBundleLazy 'groenewege/vim-less', {'autoload':{'filetypes':['less']}}
    " Configuracion para vim-less {
        "nnoremap <Leader>setlocal iskeyword+=-m :w <BAR> !lessc % > %:t:r.css<CR><space>
    " }
    " Vim syntax file for scss (Sassy CSS) 
    NeoBundleLazy 'cakebaker/scss-syntax.vim', {'autoload':{'filetypes':['scss','sass']}}
    " autocmd FileType scss set iskeyword+=-
    " Add CSS3 syntax support to vim's built-in `syntax/css.vim`.
    NeoBundleLazy 'hail2u/vim-css3-syntax', {'autoload':{'filetypes':['css','scss','sass']}}
    " Vendors Prefixes 
    " :highlight VendorPrefix guifg=#00ffff gui=bold
    " :match VendorPrefix /-\(moz\|webkit\|o\|ms\)-[a-zA-Z-]\+/
    " Highlight colors in css files
    NeoBundleLazy 'ap/vim-css-color', {'autoload':{'filetypes':['css','scss','sass','less','styl']}}
    " HTML5 omnicomplete and syntax whit SVG inline
    NeoBundleLazy 'othree/html5.vim', {'autoload':{'filetypes':['html']}}
    " Configuracion de html5.vim {
        "let g:html5_event_handler_attributes_complete = 0
        "let g:html5_rdfa_attributes_complete = 0
        "let g:html5_microdata_attributes_complete = 0
        "let g:html5_aria_attributes_complete = 0
    " }
    " Syntax Highlighting for Stylus
    "NeoBundleLazy 'wavded/vim-stylus', {'autoload':{'filetypes':['styl']}}
    " Vim's MatchParen for HTML tags
    NeoBundleLazy 'gregsexton/MatchTag', {'autoload':{'filetypes':['html','xml']}}
    " emmet for vim
    NeoBundleLazy 'mattn/emmet-vim', {'autoload':{'filetypes':['html','xml','xsl','xslt','xsd','css','sass','scss','less','mustache']}} 
    " Configuracion e emmet-vim {
        function! s:zen_html()
            let line = getline('.')
            if match(line, '<.*>') < 0
                return "\<c-y>,"
            endif
                return "\<c-y>n"
        endfunction
        " redefinir
        " let g:user_emmet_leader_key='<C-Z>'
        " let g:use_emmet_complete_tag = 1
      autocmd FileType xml,xsl,xslt,xsd,css,sass,scss,less,mustache imap <buffer><c-j> <c-y>,
      autocmd FileType html imap <buffer><expr><c-j> <sid>zen_html()
    " }
    " Este plugin es interesante, pero no es necesario. Usa Firefox > Style Editor
    " Emmet LiveStyle for Vim http://mattn.kaoriya.net/
    " NeoBundleLazy 'mattn/livestyle-vim', {'autoload':{'commands':'LiveStyle'}}
    " }
    NeoBundleLazy 'mustache/vim-mustache-handlebars', {'autoload': {'filetypes':['html']}}
endif "}}}
if count(g:settings.plugin_groups, 'javascript') "{{{
    NeoBundleLazy 'marijnh/tern_for_vim', {
      \ 'autoload': { 'filetypes': ['javascript'] },
      \ 'build': {
        \ 'mac': 'npm install',
        \ 'unix': 'npm install',
        \ 'cygwin': 'npm install',
        \ 'windows': 'npm install'
      \ },
    \ }
    NeoBundleLazy 'pangloss/vim-javascript', {'autoload':{'filetypes':['javascript']}}
    NeoBundleLazy 'maksimr/vim-jsbeautify', {'autoload':{'filetypes':['javascript']}} "{{{
      nnoremap <leader>fjs :call JsBeautify()<cr>
"}}}
    NeoBundleLazy 'leafgarland/typescript-vim', {'autoload':{'filetypes':['typescript']}}
    " NeoBundleLazy 'kchmck/vim-coffee-script', {'autoload':{'filetypes':['coffee']}}
    " NeoBundleLazy 'mmalecki/vim-node.js', {'autoload':{'filetypes':['javascript']}}
    NeoBundleLazy 'leshill/vim-json', {'autoload':{'filetypes':['javascript','json']}}
    NeoBundleLazy 'othree/javascript-libraries-syntax.vim', {'autoload':{'filetypes':['javascript','coffee','ls','typescript']}}

endif "}}}
if count(g:settings.plugin_groups, 'ruby') "{{{
    " 
    NeoBundle 'tpope/vim-rails'
    "
    NeoBundle 'tpope/vim-bundler'
endif "}}}
if count(g:settings.plugin_groups, 'dev-tools') "{{{
    " Run commands quickly.
    " NeoBundle 'thinca/vim-quickrun'
    " Integrated reference viewer.  
    NeoBundle 'thinca/vim-ref'
    "       :Ref phpmanual echo
    " documentacion
    "NeoBundle 'powerman/vim-plugin-viewdoc'
    "http://vim.wikia.com/wiki/Online_documentation_for_word_under_cursor
    " Shell interactiva para vim
    "NeoBundleLazy 'Shougo/vimshell.vim', {'autoload':{'commands':[ 'VimShell', 'VimShellInteractive' ]}}
    "{{{
      " if s:is_macvim
      "   let g:vimshell_editor_command='mvim'
      " else
      "   let g:vimshell_editor_command='vim'
      " endif
      " let g:vimshell_right_prompt='getcwd()'
      " let g:vimshell_data_directory='~/.vim/.cache/vimshell'
      " let g:vimshell_vimshrc_path='~/.vim/vimshrc'
      "
      " nnoremap <leader>c :VimShell -split<cr>
      " nnoremap <leader>cc :VimShell -split<cr>
      " nnoremap <leader>cn :VimShellInteractive node<cr>
      " nnoremap <leader>cl :VimShellInteractive lua<cr>
      " nnoremap <leader>cr :VimShellInteractive irb<cr>
      " nnoremap <leader>cp :VimShellInteractive python<cr>
    "}}}
endif "}}}
if count(g:settings.plugin_groups, 'python') "{{{
    NeoBundleLazy 'klen/python-mode', {'autoload':{'filetypes':['python']}} "{{{
      let g:pymode_rope=0
"}}}
    NeoBundleLazy 'davidhalter/jedi-vim', {'autoload':{'filetypes':['python']}} "{{{
      let g:jedi#popup_on_dot=0
"}}}
    NeoBundle 'Glench/Vim-Jinja2-Syntax', {'autoload':{'filetypes':['jinja']}}
endif "}}}
if count(g:settings.plugin_groups, 'php') "{{{
    " Autocompleccion mejorada para php
    NeoBundle 'violetyk/neocomplete-php.vim'
    " :PhpMakeDict ja
    "
    NeoBundleLazy 'nelsyeung/twig.vim', {'autoload':{'filetypes':['twig']}} 

    NeoBundleLazy 'etaoins/vim-volt-syntax', {'autoload':{'filetypes':['volt']}}
endif "}}}
if count(g:settings.plugin_groups, 'latex') "{{{
    " A simple and lightweight vim-plugin for editing LaTeX files.
    NeoBundle 'lervag/vimtex'
    " Configuración vim-latex{{{
        " $pdflatex = 'pdflatex -synctex=1 %O %S';   > ~/.latexmkrc
        let g:tex_flavor = 'latex'

        if g:settings.latex_pdf_viewer == 'zathura'
            let g:vimtex_view_enabled = 1
            let g:vimtex_view_method = 'zathura'
            " let g:vimtex_view_zathura_options = 1
            "let g:vimtex_view_zathura_options = ''
            let g:vimtex_complete_close_braces = 1
            let g:vimtex_complete_recursive_bib = 1
            let g:vimtex_complete_img_use_tail = 1
            let g:vimtex_quickfix_autojump = 1
        elseif g:settings.latex_pdf_viewer == 'okular'
            let g:vimtex_view_method = 'general'
            let g:vimtex_view_general_viewer = 'okular'
            let g:vimtex_view_general_options = '--unique'
            function! SyncTexForward(focus)
                if a:focus == 1 
                    let cmd = 'okular --unique '.g:latex#data[b:latex.id].out()."\\#src:".line(".").expand("%\:p").' &'
                    execute 'Start! ' . cmd
                else
                    call latex#view#view('--unique '
                                \ . g:latex#data[b:latex.id].out()
                                \ . '\#src:' . line(".") . expand('%:p'))
                endif
            endfunction
            nmap gb :call SyncTexForward(0)<cr>
        elseif g:settings.latex_pdf_viewer == 'SumatraPDF'
            " Configuracion Sumatra:  gvim --remote-silent +%l "%f"
            let g:vimtex_view_method = 'general'
            let g:vimtex_view_general_viewer = 'SumatraPDF'
            let g:vimtex_view_general_options = '-reuse-instance -inverse-search '.
                \ '"gvim --servername '.v:servername.' --remote-send \"^<C-\^>^<C-n^>'.
                \ ':execute ''drop ''.fnameescape(''\%f'')^<CR^>:\%l^<CR^>:normal\! zzzv^<CR^>'.
                \ ':call remote_foreground('''.v:servername.''')^<CR^>\""'
            nnoremap <expr><silent> gt ':VimLatexView -forward-search '
                \ . shellescape(expand('%:p')) . ' '
                \ . line(".") . ' '
                \ . shellescape(g:latex#data[b:latex.id].out()) . '<CR>'
            nnoremap <expr><silent> gb ':Start! SumatraPDF -forward-search '
                \ . shellescape(expand('%:p')) . ' '
                \ . line(".") . ' '
                \ . shellescape(g:latex#data[b:latex.id].out()) . '<CR><CR>'
            " nnoremap <expr><silent> gt  ':wall<bar>VimLatexView '.'-forward-search "'.shellescape(expand('%:p')).'" '.line(".").' '.shellescape(g:latex#data[b:latex.id].out()).'<CR>'
        endif
    " }}} 
endif "}}}
if count(g:settings.plugin_groups, 'scala') "{{{
    NeoBundle 'derekwyatt/vim-scala'
    NeoBundle 'megaannum/vimside'
  endif "}}}
  if count(g:settings.plugin_groups, 'go') "{{{
    NeoBundleLazy 'jnwhiteh/vim-golang', {'autoload':{'filetypes':['go']}}
    NeoBundleLazy 'nsf/gocode', {'autoload': {'filetypes':['go']}, 'rtp': 'vim'}
  endif "}}}
if count(g:settings.plugin_groups, 'scm') "{{{
    " barra lateral muestra diferencias
    NeoBundle 'mhinz/vim-signify'
    " Configuración de vim-signify {{{
        let g:signify_update_on_bufenter=0
    "}}}
    if executable('hg')
        " Soporte para Mercurial
        " NeoBundle 'bitbucket:ludovicchabant/vim-lawrencium'
    endif
    " Soporte para Git
    NeoBundle 'tpope/vim-fugitive'
    " Configuración de vim-fugitive {{{
        nnoremap <silent> <leader>gb :Gblame<CR>
        nnoremap <silent> <leader>gs :Gstatus<CR>
        nnoremap <silent> <leader>gd :Gdiff<CR>
        nnoremap <silent> <leader>gl :Glog<CR>
        nnoremap <silent> <leader>gc :Gcommit<CR>
        nnoremap <silent> <leader>gp :Git push<CR>
        nnoremap <silent> <leader>gw :Gwrite<CR>
        nnoremap <silent> <leader>gr :Gremove<CR>
        autocmd FileType gitcommit nmap <buffer> U :Git checkout -- <C-r><C-g><CR>
        autocmd BufReadPost fugitive://* set bufhidden=delete
    "}}}
    " gitk clone para Vim
    NeoBundleLazy 'gregsexton/gitv', {'depends':['tpope/vim-fugitive'], 'autoload':{'commands':'Gitv'}}
    " Configuración de gitv {{{
        nnoremap <silent> <leader>gv :Gitv<CR>
        nnoremap <silent> <leader>gV :Gitv!<CR>
    "}}}
    " Soporte para otros SVC | Nota: Aun no lo he probado
    " NeoBundle 'git://repo.or.cz/vcscommand'
    " Plugin para crear Gist
     NeoBundleLazy 'mattn/gist-vim', { 'depends': 'mattn/webapi-vim', 'autoload': { 'commands': 'Gist' } }
     " Configuración gist-vim {{{
        let g:gist_post_private=1
        let g:gist_show_privates=1
    "}}}
endif "}}}
if count(g:settings.plugin_groups, 'syntax') "{{{
    " Syntax checking
    NeoBundle 'scrooloose/syntastic'
    " Configuración de syntastic {{{
        " let g:syntastic_enable_signs=1
        " let g:syntastic_quiet_warnings=0
        " let g:syntastic_auto_loc_list=2
        " Simbolos
        let g:syntastic_error_symbol = '✗'
        let g:syntastic_style_error_symbol = '✠'
        let g:syntastic_warning_symbol = '∆'
        let g:syntastic_style_warning_symbol = '≈'
    "}}}
endif "}}}
if count(g:settings.plugin_groups, 'autocomplete') "{{{
    " The ultimate snippet solution for Vim
    NeoBundle 'SirVer/ultisnips'
    " Configuración ultisnips {{{
        let g:UltiSnipsUsePythonVersion = 2
        " let g:UltiSnipsExpandTrigger="<c-b>"
        " let g:UltiSnipsJumpForwardTrigger="<c-b>"  "<c-b>
        " let g:UltiSnipsJumpBackwardTrigger="<s-tab>" "<c-z>
        " if s:is_windows
            " Es necesario añadir el rtp+='$VIM'
            " let g:UltiSnipsSnippetsDir=$VIM.'/ultisnips'
        " else
            " let g:UltiSnipsSnippetsDir='~/.vim/ultisnips'
        " endif
        " let g:UltiSnipsSnippetDirectories=["ultisnips", "UltiSnips"]
        " let g:UltiSnipsEditSplit="vertical"
    "}}}
    " Next generation completion framework after neocomplcache
    NeoBundleLazy 'Shougo/neocomplete.vim', {'autoload':{'insert':1}, 'vim_version':'7.3.885'}
    " Configuración de neocomplete {{{
        let g:acp_enableAtStartup = 0
        let g:neocomplete#enable_at_startup = 1
        let g:neocomplete#enable_smart_case = 1
        "let g:neocomplete#enable_auto_select = 0
        let g:neocomplete#sources#syntax#min_keyword_length = 4

        let g:UltiSnipsJumpForwardTrigger="<NOP>"
        let g:ulti_expand_or_jump_res = 0
        function! ExpandSnippetOrJumpForwardOrReturnTab()
            let snippet = UltiSnips#ExpandSnippetOrJump()
            if g:ulti_expand_or_jump_res > 0
                return snippet
            else
                return "\<TAB>"
            endif
        endfunction
        inoremap <expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ "<C-R>=ExpandSnippetOrJumpForwardOrReturnTab()<CR>"
        " snoremap <TAB> 
        " jump to next placeholder otherwise do nothing
        snoremap <buffer> <silent> <TAB>
            \ <ESC>:call UltiSnips#JumpForwards()<CR>

        " inoremap <S-TAB>
        " previous menu item, jump to previous placeholder or do nothing
        let g:UltiSnipsJumpBackwordTrigger = "<NOP>"
        inoremap <expr> <S-TAB>
            \ pumvisible() ? "\<C-p>" :
            \ "<C-R>=UltiSnips#JumpBackwards()<CR>"

        " snoremap <S-TAB>
        " jump to previous placeholder otherwise do nothing
        snoremap <buffer> <silent> <S-TAB>
            \ <ESC>:call UltiSnips#JumpBackwards()<CR>

        " inoremap <CR>
        " expand snippet, close menu or insert newline
        let g:UltiSnipsExpandTrigger = "<NOP>"
        let g:ulti_expand_or_jump_res = 0
        inoremap <silent> <CR> <C-r>=<SID>ExpandSnippetOrReturnEmptyString()<CR>
        function! s:ExpandSnippetOrReturnEmptyString()
            if pumvisible()
            let snippet = UltiSnips#ExpandSnippetOrJump()
            if g:ulti_expand_or_jump_res > 0
                return snippet
            else
                return "\<C-y>\<CR>"
            endif
            else
                return "\<CR>"
        endfunction

        " inoremap <C-h>
        inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"

        " inoremap <BS>
        inoremap <expr><BS>  neocomplete#smart_close_popup()."\<C-h>"

        if s:is_windows
            let g:neocomplete#data_directory=$VIM.'/.cache/neocomplete'
        else
            let g:neocomplete#data_directory='~/.vim/.cache/neocomplete'
        endif
        "let g:neocomplete#sources#dictionary#dictionaries = {
         "   \ 'default' : '',
          "  \ 'vimshell' : $HOME.'/.vimshell_hist',
           " \ 'scheme' : $HOME.'/.gosh_completions'
            "\ }
        " Define keyword.
        if !exists('g:neocomplete#keyword_patterns')
            let g:neocomplete#keyword_patterns = {}
        endif
        " completar palabras en español por default
        let g:neocomplete#keyword_patterns._ = '[A-Za-zá-úÁ-ÚüñÑ_][0-9A-Za-zá-úÁ-ÚüñÑ_]*'
        " tab
        " Plugin key-mappings.
        inoremap <expr><C-g> neocomplete#undo_completion()
        inoremap <expr><C-l> neocomplete#complete_common_string()
        inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
        inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
        " Enable omni completion.
        autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
        autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
        autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
        autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
        autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

        " Enable heavy omni completion.
        if !exists('g:neocomplete#sources#omni#input_patterns')
            let g:neocomplete#sources#omni#input_patterns = {}
        endif
        "let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
        "let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
        "let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

        " For perlomni.vim setting.
        " https://github.com/c9s/perlomni.vim
        " let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
    "}}}
    " snipMate & UltiSnip Snippets
    NeoBundle 'honza/vim-snippets'
    " rbonvall/snipmate-snippets-bib
    " The standard snippets repository for neosnippet
    " NeoBundle 'Shougo/neosnippet-snippets'
    " adds snippet support to Vim
    " NeoBundle 'Shougo/neosnippet.vim'
    "    imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
    " \ "\<Plug>(neosnippet_expand_or_jump)" : pumvisible ? "\<C-n>" : "\<TAB>"
endif "}}}
if count(g:settings.plugin_groups, 'editing') "{{{
    " EditorConfig plugin for Vim, modificar .editorconfig
    NeoBundleLazy 'editorconfig/editorconfig-vim', {'autoload':{'insert':1}}
    " Agrega end in ruby, endfunction/endif/more in vim script, etc
    NeoBundle 'tpope/vim-endwise'
    " use CTRL-A/CTRL-X to increment dates, times, and more
    NeoBundle 'tpope/vim-speeddating'
    " you can search your selection text in |Visual-mode|
    NeoBundle 'thinca/vim-visualstar'
    " An extensible & universal comment vim-plugin that also handles embedded filetypes
    NeoBundle 'tomtom/tcomment_vim'
    " Configuracion tcomment {{{
        vmap <C-/> gc
    " }}}
    " visually select increasingly
    NeoBundle 'terryma/vim-expand-region'
    " Configuración de vim-expand-region {{{
        " let g:expand_region_text_objects = {'iw':0,'iW':0,'i"':0,'i''':0,'i]':1,'ib':1,'iB':1,'il':0,'ip':0,'ie':0, }
        " call expand_region#custom_text_objects({"\/\\n\\n\<CR>": 1,'a]' :1,'ab' :1,'aB' :1,'ii' :0,'ai' :0, })
        " let g:expand_region_text_objects_vim = {'iw':0,'iW':0,'i"':0,'i''':0,'i]':1,'ib':1,'iB':1,'il':0,'ip':0,'ie':0, }
        " call expand_region#custom_text_objects('vim', {"\/\\n\\n\<CR>": 1,'a]' :1,'ab' :1,'aB' :1,'ii' :0,'ai' :0, })
        " let g:expand_region_text_objects_markdown = {'iw':0,'iW':0,'i"':0,'i''':0,'i]':1,'ib':1,'iB':1,'il':0,'ip':0,'ie':0, }
        " call expand_region#custom_text_objects('markdown', {"\/\\n\\n\<CR>": 1,'a]' :1,'ab' :1,'aB' :1,'ii' :0,'ai' :0, })
    " }}}
    " Nota: Es inestable y personamente no lo uso,
    " NeoBundle 'terryma/vim-multiple-cursors'
    " Edita una region seleccionada en otro buffer
    NeoBundle 'chrisbra/NrrwRgn'
    " Vim script for text filtering and alignment
    NeoBundleLazy 'godlygeek/tabular', {'autoload':{'commands':'Tabularize'}}
    " Configuración de tabular{{{
        nmap <Leader>a& :Tabularize /&<CR>
        vmap <Leader>a& :Tabularize /&<CR>
        nmap <Leader>a= :Tabularize /=<CR>
        vmap <Leader>a= :Tabularize /=<CR>
        nmap <Leader>a: :Tabularize /:<CR>
        vmap <Leader>a: :Tabularize /:<CR>
        nmap <Leader>a:: :Tabularize /:\zs<CR>
        vmap <Leader>a:: :Tabularize /:\zs<CR>
        nmap <Leader>a, :Tabularize /,<CR>
        vmap <Leader>a, :Tabularize /,<CR>
        nmap <Leader>a<Bar> :Tabularize /<Bar><CR>
        vmap <Leader>a<Bar> :Tabularize /<Bar><CR>

        " Tabular automaticamente con | pero no lo habilito porque voy a
        " medir el desempeño primero.
        " inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a
        "
        " function! s:align()
        " let p = '^\s*|\s.*\s|\s*$'
        " if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
        "     let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
        "     let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
        "     Tabularize/|/l1
        "     normal! 0
        "     call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
        " endif
        " endfunction
    "}}}
    " insert or delete brackets, parens, quotes in pair
    NeoBundle 'jiangmiao/auto-pairs'
    " Heuristically set buffer options 'shiftwidth' and 'expandtab'
    " NeoBundle 'tpope/vim-sleuth'
    " tpope/vim-abolish
    " tommcdo/vim-exchange
    " reedes/vim-wordy
    " reedes/vim-litecorrect
    " reedes/vim-lexical
endif "}}}
if count(g:settings.plugin_groups, 'audionote') "{{{
endif "}}}
if count(g:settings.plugin_groups, 'ctrlp') "{{{
    " Fuzzy file, buffer, mru, tag, etc finder.
    NeoBundle 'kien/ctrlp.vim', { 'depends': 'tacahiroy/ctrlp-funky' }
    " Configuración de ctrlp.vim {{{
        let g:ctrlp_clear_cache_on_exit=1
        let g:ctrlp_max_height=40
        let g:ctrlp_show_hidden=0
        let g:ctrlp_follow_symlinks=1
        let g:ctrlp_max_files=20000
        let g:ctrlp_cache_dir='~/.vim/.cache/ctrlp'
        let g:ctrlp_reuse_window='startify'
        let g:ctrlp_extensions=['funky']
        let g:ctrlp_custom_ignore = {
            \ 'dir': '\v[\/]\.(git|hg|svn|idea)$',
            \ 'file': '\v\.DS_Store$'
            \ }
        if executable('ag')
            let g:ctrlp_user_command='ag %s -l --nocolor -g ""'
        endif

        nmap \ [ctrlp]
        nnoremap [ctrlp] <nop>

        nnoremap [ctrlp]t :CtrlPBufTag<cr>
        nnoremap [ctrlp]T :CtrlPTag<cr>
        nnoremap [ctrlp]l :CtrlPLine<cr>
        nnoremap [ctrlp]o :CtrlPFunky<cr>
        nnoremap [ctrlp]b :CtrlPBuffer<cr>
    "}}}

endif "}}}
if count(g:settings.plugin_groups, 'navigation') "{{{
    " Soporte para ack perl module
    NeoBundle 'mileszs/ack.vim'
    " Configuarción de ack.vim {{{
        if executable('ag')
            let g:ackprg = "ag --nogroup --column --smart-case --follow"
        endif
        map <leader>f :Ack<space>
    "}}}
    " Muestra el historial de deshacer en un gráfico. | Note: Mas simple que Gundo
    NeoBundleLazy 'mbbill/undotree', {'autoload':{'commands':'UndotreeToggle'}}
    " Configración de undotree {{{
        let g:undotree_SplitLocation='botright'
        let g:undotree_SetFocusWhenToggle=1
        nnoremap <silent> <F5> :UndotreeToggle<CR>
    "}}}
    " Fast and Easy Find and Replace Across Multiple Files
    NeoBundleLazy 'EasyGrep', {'autoload':{'commands':'GrepOptions'}}
    " Configuración de EasyGrep {{{
        let g:EasyGrepRecursive=1
        let g:EasyGrepAllOptionsInExplorer=1
        let g:EasyGrepCommand=1
        nnoremap <leader>vo :GrepOptions<cr>
    "}}}
    " Nota: Personalmente uso vimfiler
    " Explorador en Arbol (tree)
    "NeoBundleLazy 'scrooloose/nerdtree', {'autoload':{'commands':['NERDTreeToggle','NERDTreeFind']}}
    " Configuracion de nerdtree {{{
      "let NERDTreeShowHidden=1
      "let NERDTreeQuitOnOpen=0
      "let NERDTreeShowLineNumbers=1
      "let NERDTreeChDirMode=0
      "let NERDTreeShowBookmarks=1
      "let NERDTreeIgnore=['\.git','\.hg']
      "let NERDTreeBookmarksFile='~/.vim/.cache/NERDTreeBookmarks'
      "nnoremap <F2> :NERDTreeToggle<CR>
      "nnoremap <F3> :NERDTreeFind<CR>
    "}}}
    " Muestra las etiquetas(tags) en una ventana, ordenada por ámbito(scope)
    NeoBundleLazy 'majutsushi/tagbar', {'autoload':{'commands':'TagbarToggle'}}
    " Configuracion de tagbar {{{
        let g:tagbar_autofocus=1
        let g:tagbar_autopreview = 1
        let g:tagbar_iconchars = ['▶', '▼'] 
        nnoremap <silent> <F9> :TagbarToggle<CR>
        map <leader>rt :TagbarToggle<CR>
    "}}}
    " Movimientos faciles | Nota: Personalmente no lo uso.
    " NeoBundle 'Lokaltog/vim-easymotion'
    " TODO: buscar un mapping paraa vim-sneak
    " jumps to any location specified by two characters
    " NeoBundle 'justinmk/vim-sneak'
    " Configuracion de vim-sneak {{{
      " let g:sneak#streak = 1
    "}}}
endif "}}}
if count(g:settings.plugin_groups, 'unite') "{{{
    " Unir y crear interfaces de usuario
    NeoBundle 'Shougo/unite.vim'
    " Configuracion de unite.vim {{{
        let bundle = neobundle#get('unite.vim')
        function! bundle.hooks.on_source(bundle)
            call unite#filters#matcher_default#use(['matcher_fuzzy'])
            call unite#filters#sorter_default#use(['sorter_rank'])
            call unite#set_profile('files', 'context.smartcase', 1)
            call unite#custom#source('line,outline','matchers','matcher_fuzzy')
        endfunction

        if s:is_windows
            let g:unite_data_directory=$VIM.'/.cache/unite'
        else
            let g:unite_data_directory='~/.vim/.cache/unite'
        endif
        let g:unite_enable_start_insert=1
        let g:unite_source_history_yank_enable=1
        let g:unite_source_rec_max_cache_files=5000
        let g:unite_prompt='» '

        if executable('ag')
            " let g:unite_source_rec_async_command='ag --nocolor --nogroup --skip-vcs-ignores --ignore ".cache" --ignore ".hg" --ignore ".svn" --ignore ".git" --ignore ".bzr" --hidden -g ""'
            let g:unite_source_rec_async_command= 'ag --nocolor --nogroup --hidden -g ""'
            let g:unite_source_grep_command='ag'
            let g:unite_source_grep_default_opts='--nogroup --skip-vcs-ignores --nocolor --column'
            let g:unite_source_grep_recursive_opt=''
        elseif executable('ack')
            let g:unite_source_grep_command='ack'
            let g:unite_source_grep_default_opts='--no-heading --no-color -C4'
            let g:unite_source_grep_recursive_opt=''
        endif

        function! s:unite_settings()
            nmap <buffer> Q <plug>(unite_exit)
            nmap <buffer> <esc> <plug>(unite_exit)
            imap <buffer> <esc> <plug>(unite_exit)
            imap <buffer> <C-j> <Plug>(unite_select_next_line)
            imap <buffer> <C-k> <Plug>(unite_select_previous_line)
            inoremap <silent><buffer><expr> <C-s> unite#do_action('split')
            inoremap <silent><buffer><expr> <C-v> unite#do_action('vsplit')
            inoremap <silent><buffer><expr> <C-t> unite#do_action('tabopen')
        endfunction
        autocmd FileType unite call s:unite_settings()

        nmap <space> [unite]
        nnoremap [unite] <nop>

        if s:is_windows
            nnoremap <silent> [unite]<space> :<C-u>Unite -toggle -auto-resize -buffer-name=mixed file_rec/async:! buffer file_mru bookmark<cr>
            nnoremap <silent> [unite]f :<C-u>Unite -toggle -auto-resize -buffer-name=files file_rec/async:!<cr>
        else
            nnoremap <silent> [unite]<space> :<C-u>Unite -toggle -auto-resize -buffer-name=mixed file_rec/async:! buffer file_mru bookmark<cr>
            nnoremap <silent> [unite]f :<C-u>Unite -toggle -auto-resize -buffer-name=files file_rec/async:!<cr>
        endif

        nnoremap <silent> [unite]e :<C-u>Unite -buffer-name=recent file_mru<cr>
        nnoremap <silent> [unite]y :<C-u>Unite -buffer-name=yanks history/yank<cr>
        nnoremap <silent> [unite]l :<C-u>Unite -auto-resize -buffer-name=line line<cr>
        "nnoremap <silent> [unite]b :<C-u>Unite -auto-resize -auto-preview -buffer-name=buffers buffer<cr>
        nnoremap <silent> [unite]b :<C-u>Unite -auto-resize -buffer-name=buffers buffer<cr>
        nnoremap <silent> [unite]/ :<C-u>Unite -no-quit -buffer-name=search grep:.<cr>
        nnoremap <silent> [unite]m :<C-u>Unite -auto-resize -buffer-name=mappings mapping<cr>
        nnoremap <silent> [unite]s :<C-u>Unite -quick-match buffer<cr>
        nnoremap <leader>nbu :Unite neobundle/update -vertical -no-start-insert<cr>
    "}}}
    " Busqueda en archivos recientes, como :browse old
    NeoBundleLazy 'Shougo/neomru.vim', {'autoload':{'unite_sources':'file_mru'}}
    " Cambiar de vim-airline theme.
    NeoBundleLazy 'osyo-manga/unite-airline_themes', {'autoload':{'unite_sources':'airline_themes'}}
    " Configuración de unite-airline_themes {{{
        nnoremap <silent> [unite]a :<C-u>Unite -winheight=10 -auto-preview -buffer-name=airline_themes airline_themes<cr>
    "}}}
    " Cambiar de ColorScheme
    NeoBundleLazy 'ujihisa/unite-colorscheme', {'autoload':{'unite_sources':'colorscheme'}}
    " Configuración de unite-colorcheme {{{
        nnoremap <silent> [unite]c :<C-u>Unite -winheight=10 -auto-preview -buffer-name=colorschemes colorscheme<cr>
    "}}}
    " tags source for unite.vim
    NeoBundleLazy 'tsukkee/unite-tag', {'autoload':{'unite_sources':['tag','tag/file']}}
    " Configuración de unite-tag {{{
        nnoremap <silent> [unite]t :<C-u>Unite -auto-resize -buffer-name=tag tag tag/file<cr>
    "}}}
    " outline source for unite.vim
    NeoBundleLazy 'Shougo/unite-outline', {'autoload':{'unite_sources':'outline'}}
    " Configuración de unite-outline {{{
        nnoremap <silent> [unite]o :<C-u>Unite -auto-resize -buffer-name=outline outline<cr>
    "}}}
    " Muestra etiquetas de Ayuda
    NeoBundleLazy 'Shougo/unite-help', {'autoload':{'unite_sources':'help'}}
    " Configuración de unite-help {{{
        nnoremap <silent> [unite]h :<C-u>Unite -auto-resize -buffer-name=help help<cr>
    "}}}
    " Create temporary file for memo, testing, ...
    NeoBundleLazy 'Shougo/junkfile.vim', {'autoload':{'commands':'JunkfileOpen','unite_sources':['junkfile','junkfile/new']}}
    " Configuración de junkfile.vim {{{
        if s:is_windows
            let g:junkfile#directory=expand("$VIM/.cache/junk")
        else
            let g:junkfile#directory=expand("~/Dropbox/Notas")
        endif
        nnoremap <silent> [unite]j :<C-u>Unite -auto-resize -buffer-name=junk junkfile junkfile/new<cr>
    "}}}
    " Powerful file explorer
    NeoBundle 'Shougo/vimfiler.vim'
    " Configuracion Vimfiler {{{
        let g:vimfiler_as_default_explorer = 1
        if s:is_windows
            let g:vimfiler_data_directory=$VIM.'/.cache/vimfiler'
        else
            let g:vimfiler_data_directory='~/.vim/.cache/vimfiler'
        endif
        if s:is_windows
            let g:vimfiler_quick_look_command = 'maComfort.exe -ql'
        elseif s:is_macvim
            let g:vimfiler_quick_look_command = 'qlmanage -p'
        else
            let g:vimfiler_quick_look_command = 'gloobus-preview'
        endif
        " Like Textmate icons.
        if s:is_windows
            let g:vimfiler_tee_leaf_icon = '|'
            let g:vimfiler_tree_opened_icon = '▼'
            let g:vimfiler_tree_closed_icon = '▷'
            let g:vimfiler_file_icon = ' '
            let g:vimfiler_marked_file_icon = '*'
            let g:vimfiler_readonly_file_icon = '✗'
        else
            let g:vimfiler_tree_leaf_icon = ' '
            let g:vimfiler_tree_opened_icon = '▾'
            let g:vimfiler_tree_closed_icon = '▸'
            let g:vimfiler_file_icon = '-'
            let g:vimfiler_marked_file_icon = '*'
        endif
        " let g:vimfiler_time_format = '%d-%m-%Y %H:%M:%S'
       if has('gui_running')
        " the following two lines do not work in vim, but work in Gvim
        nnoremap <A-1> :VimFilerExplorer -toggle<CR>
    else
        " these two work in vim
        " shrtcut with alt key: press Ctrl-v then Alt-k
        " ATTENTION: the following two lines should not be 
        " edited under other editors like gedit. ^[k and ^[j will be broken! 
        nnoremap 1  :VimFilerExplorer -toggle<CR>
    endif
        nnoremap <silent> [unite]p :VimFilerExplorer -buffer-name=proyecto -toggle -project<cr>
        " nnoremap <silent> [unite]p :VimFiler -buffer-name=proyecto -split -simple -winwidth=35 -toggle -project -quit<cr>
        autocmd FileType vimfiler
            \ nmap <buffer> w <Plug>(vimfiler_quick_look)
    " }}}
    " unite.vim session source
    NeoBundleLazy 'Shougo/unite-session', {'autoload':{'unite_sources': 'session'}}
    " Configuración de unite-session {
        let g:unite_source_session_default_session_name = 'xerron'
        nnoremap <silent> [unite]x :<C-u>Unite -auto-resize session<cr>
    " }
    NeoBundleLazy 'kopischke/unite-spell-suggest', {'autoload':{'unite_sources': 'spell_suggest'}}
    " Configuracion de unite-spell-suggest {
        nnoremap <silent> [unite]z :<C-u>Unite -auto-resize spell_suggest<cr>
    " }
    " unite quickfix
    " NeoBundle 'osyo-manga/unite-quickfix'
    " git unite
    " NeoBundle 'kmnk/vim-unite-giti'
    " audio notes
    "NeoBundleLazy 'xerron/audionote.vim', {'autoload':{'commands':'AudionoteOpen','unite_sources':['audionote','audionote/new']}}
    NeoBundle 'xerron/audionote.vim'
    " Configuración de audionote.vim {{{
        if s:is_windows
            let g:audionote#directory=expand("$VIM/.cache/junk")
        else
            let g:audionote#directory=expand("~/Dropbox/Audios")
        endif
        nnoremap <silent> [unite]v :<C-u>Unite -auto-resize -buffer-name=audio audionote audionote/new<cr>
    "}}}
endif "}}}
if count(g:settings.plugin_groups, 'indents') "{{{
    NeoBundle 'nathanaelkane/vim-indent-guides'
    " Configuración vim-indent-guides {{{
        let g:indent_guides_start_level=1
        let g:indent_guides_guide_size=1
        let g:indent_guides_enable_on_vim_startup=0
        let g:indent_guides_color_change_percent=3
        if !has('gui_running')
            let g:indent_guides_auto_colors=0
            function! s:indent_set_console_colors()
            hi IndentGuidesOdd ctermbg=235
            hi IndentGuidesEven ctermbg=236
            endfunction
            autocmd VimEnter,Colorscheme * call s:indent_set_console_colors()
        endif
    "}}}
endif "}}}
if count(g:settings.plugin_groups, 'textobj') "{{{
    " Create your own text objects
    NeoBundle 'kana/vim-textobj-user'
    " Configuracion vim-textobj-user {{{
        call textobj#user#plugin('datetime', {
        \   'date': {
        \     'pattern': '\<\d\d\d\d-\d\d-\d\d\>',
        \     'select': ['ad', 'id'],
        \   },
        \   'time': {
        \     'pattern': '\<\d\d:\d\d:\d\d\>',
        \     'select': ['at', 'it'],
        \   },
        \ })
    " }}}
    " Text objects for indented blocks of lines
    NeoBundle 'kana/vim-textobj-indent'
    " Configuración vim-textobj-indent {{{
    " michaeljsmith/vim-indent-object
    " }}}
    " Text objects for entire buffer
    NeoBundle 'kana/vim-textobj-entire'
    " Configuracion vim-textobj-entire {{{

    " }}}
    " Underscore text-object for Vim
    NeoBundle 'lucapette/vim-textobj-underscore'
    " Configuracion de vim-textobj-underscore {{{
    "
    " }}}
    " HAY UN MONTON DE TEXT OBJECTS en el github de kana
endif "}}}
if count(g:settings.plugin_groups, 'distraction-free-mode') "{{{
    " Hyperfocus-writing
    NeoBundle 'junegunn/limelight.vim'
    " Configuración de limelight.vim {{{
        " Nota: descomenta lo de abajo si limelight no funciona
        " Color name (:help cterm-colors) or ANSI code
            "let g:limelight_conceal_ctermfg = 'gray'
            "let g:limelight_conceal_ctermfg = 240
        " Color name (:help gui-colors) or RGB color
            "let g:limelight_conceal_guifg = 'DarkGray'
            "let g:limelight_conceal_guifg = '#777777'
        " Default: 0.5
        let g:limelight_default_coefficient = 0.7
    " }}}
    " Distraction free mode
    NeoBundle 'junegunn/goyo.vim'
    " Configuración de goyo.vim {{{
        " Markdown Goyo {
            function! s:markdown_room()
                " set background=light
                set linespace=5
                if has('gui_running')
                    if s:is_windows
                        exec 'set guifont='.g:settings.guifont_win_goyo 
                    elseif s:is_macvim
                        exec 'set guifont='.g:settings.guifont_mac_goyo 
                    else
                        exec 'set guifont='.g:settings.guifont_linux_goyo 
                    endif
                endif
                colorscheme hybrid-light
            endfunction
        " }
        function! s:goyo_enter()
            "set fullscreen
            set linespace=5
            set guioptions-=m  "remove menu bar
            set guioptions-=T  "remove toolbar
            set guioptions-=r  "remove right-hand scroll bar
            set guioptions-=L  "remove left-hand scroll bar
            Limelight
            " Markdown {
                if !has("gui_running")
                    return
                endif
                let is_mark_or_rst = &filetype == "markdown" || &filetype == "rst" || &filetype == "text" || &filetype == "mkd" || &filetype == "md"
                if is_mark_or_rst
                    call s:markdown_room()
                endif
            " }
            " Asegurar salir con :q {
                let b:quitting = 0
                autocmd QuitPre <buffer> let b:quitting = 1
            " }
        endfunction
        function! s:goyo_leave()
            Limelight!
            set background=dark
            exec 'colorscheme '.g:settings.colorscheme
            set linespace=0
            if g:settings.gui_minimal != 'on'
                set guioptions+=m  "add menu bar
                set guioptions+=T  "add toolbar
                set guioptions+=r  "add right-hand scroll bar
                set guioptions+=L  "add left-hand scroll bar
            endif
            if has('gui_running')
                if s:is_windows
                    exec 'set guifont='.g:settings.guifont_win 
                elseif s:is_macvim
                    exec 'set guifont='.g:settings.guifont_mac 
                else
                    exec 'set guifont='.g:settings.guifont_linux 
                endif
            endif
            if !has("gui_running")
                return
            endif
            " Asegura salir con :q
            if b:quitting && len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
                qa
            endif
        endfunction

        let g:goyo_width=90             "(default: 80)
        "let g:goyo_margin_top=4         "(default: 4)
        "let g:goyo_margin_bottom=4      "(default: 4)
        "let g:goyo_linenr=0             "(default: 0)
        autocmd! User GoyoEnter
        autocmd! User GoyoLeave
        autocmd  User GoyoEnter nested call <SID>goyo_enter()
        autocmd  User GoyoLeave nested call <SID>goyo_leave()
        "nnoremap <SPACE> <Nop>
        nnoremap <Leader><Space> :Goyo<CR>
        "nnoremap <Leader>G :Goyo<CR>
    "}}}
    " FullScreen, Maximize, Abrir directorio, url, mail para gvim
    NeoBundle 'xolox/vim-misc'
    NeoBundle 'xolox/vim-shell'
    " Configuración de vim-shell {{{
        let g:shell_fullscreen_items='mT'
        " m quita el menu
        " T quita el tollbar
        " e quita el tabline
        " r quita el scrollbar
        ""b:shell_fullscreen_items
    "}}}
endif "}}}
if count(g:settings.plugin_groups, 'grammar-checker') "{{{
    " Corrector Ortografico y gramatical - Grammar checker
    NeoBundle 'vim-scripts/LanguageTool'
    " Configuración LanguageTool {
        if s:is_windows 
            let g:languagetool_jar='/opt/languagetool/LanguageTool-2.8/languagetool-commandline.jar'
        else
            let g:languagetool_jar='/opt/languagetool/LanguageTool-2.8/languagetool-commandline.jar'
        endif
        let g:languagetool_win_height=14

    " }
    " Corrector ortografico, tiene un plugin para vim.
    " http://www.afterthedeadline.com/
    " vim integracion.
    " https://github.com/lpenz/atdtool
    " Online, falta hacer algun plugin
    " http://www.mystilus.com/Interactive_check
    " TODO: Buscar la forma de corregir mas rapido con el set spell z=
endif "}}}
if count(g:settings.plugin_groups, 'language-tools') "{{{
    " Sinonimos y Antonimos. Online - Thesauru online
    " NeoBundle 'idbrii/vim-online-thesaurus'
    " NeoBundle 'beloglazov/vim-online-thesaurus'
    " palabra por palabra ui-interface
    NeoBundle 'xerron/wordbyword.vim'
    " Acceso rapido a diccionarios stardict 2.4.2 por sdcv
    NeoBundle 'xerron/stardict.vim'
    " Google Translator
    NeoBundle 'maksimr/vim-translator'
    " :Translate Hello Word
    " Configuracion de vim-translator {
        let g:goog_user_conf = {'langpair': 'en|es','cmd': 'ruby','v_key': 'T'}
    " }
    " Diccionario de Rimas
    NeoBundle 'xerron/rimas.vim'
    " Connfiguración de rimas.vim {
        let g:rimas_merimas_path='/home/xerron/Documentos/Diccionarios/MERimas/' 
    " }
endif "}}}
if count(g:settings.plugin_groups, 'task-management') "{{{
    if !s:is_windows
        " Administrador de tareas
        NeoBundleLazy 'blindFS/vim-taskwarrior', {'autoload':{'commands':'TW'}}
        " Configuracion vim-taskwarrior {
            let g:task_default_prompt = ['project', 'description', 'tag']
            "let g:task_rc_override = 'defaultwidth=999'
            "let g:task_rc_override = 'rc.defaultheight=0'
        " }
        "NeoBundle 'powerman/vim-plugin-AnsiEsc'
        "NeoBundle 'tbabej/taskwiki'
    endif
    " Task manager
    " NeoBundle 'freitass/todo.txt-vim'
endif "}}}
if count(g:settings.plugin_groups, 'wiki') "{{{
    NeoBundle 'vimwiki/vimwiki', {'rev': 'dev'}
    " Configuracion vimwiki {
    let g:vimwiki_list = [{'path': '~/Dropbox/Wiki/Conocimientos'},
                \ {'path': '~/Dropbox/Wiki/Articulos', 'path_html': '~/Dropbox/Publicaciones/Articulos', 'nested_syntaxes': {'php': 'php', 'c++': 'cpp', 'java': 'java', 'vim': 'vim', 'html': 'html', 'css': 'css', 'twig': 'twig', 'js': 'js', 'scss': 'scss', 'python': 'python', 'swift': 'swift', 'go': 'go', 'yaml': 'yaml', 'sh': 'sh'}},
                \ {'path': '~/Dropbox/Wiki/Proyectos', 'path_html': '~/Dropbox/Publicaciones/Proyectos', 'nested_syntaxes': {'php': 'php', 'c++': 'cpp'}},
                \ {'path': '~/Dropbox/Wiki/Poesia', 'path_html': '~/Dropbox/Publicaciones/Poesia'}]
    " }
endif "}}}
if count(g:settings.plugin_groups, 'vim') "{{{
    " Testing framework for Vim script
    NeoBundle 'kana/vim-vspec'
    " A Vim plugin for Vim plugins
    NeoBundleLazy 'tpope/vim-scriptease', {'autoload':{'filetypes':['vim']}}
    " All 256 xterm colors with their RGB equivalents
    NeoBundleLazy 'guns/xterm-color-table.vim', {'autoload':{'commands':'XtermColorTable'}}
    " The Vim FAQ from http://vimdoc.sourceforge.net/ http://vimdoc.sourceforge.net/
    "NeoBundle 'chrisbra/vim_faq'
endif "}}}
if count(g:settings.plugin_groups, 'utilities') "{{{
    " Limpiar espacios en blanco finales
    " bronson/vim-trailing-whitespace
    "
endif "}}}
if count(g:settings.plugin_groups, 'tmux') "{{{
    if exists('$TMUX')
        " Seamless navigation between tmux panes and vim splits
        NeoBundle 'christoomey/vim-tmux-navigator'
        NeoBundle 'edkolev/tmuxline.vim'
    endif
endif "}}}
if count(g:settings.plugin_groups, 'ditaa') "{{{
    " Ditaa syntax
    NeoBundle 'vim-scripts/ditaa'
endif "}}}
if count(g:settings.plugin_groups, 'ledger') "{{{
    " Ditaa syntax
    NeoBundle 'ledger/vim-ledger'
endif "}}}
if count(g:settings.plugin_groups, 'plantuml') "{{{
    " plantuml syntax - init file with @staruml
    NeoBundleLazy 'aklt/plantuml-syntax', {'autoload':{'filetypes':['plantuml', 'uml', 'pu']}}
    au BufNewFile,BufRead *.plantuml,*.uml,*.pu setf plantuml
endif "}}}
if count(g:settings.plugin_groups, 'misc') "{{{
    " A fancy start screen for Vim.
    NeoBundle 'mhinz/vim-startify'
    "{{{
      let g:startify_session_dir = '~/.vim/.cache/sessions'
      let g:startify_change_to_vcs_root = 1
      let g:startify_show_sessions = 1
      nnoremap <F1> :Startify<cr>
    "}}}
    " Always have a nice view for vim split windows!
    NeoBundleLazy 'zhaocai/GoldenView.Vim', {'autoload':{'mappings':['<Plug>ToggleGoldenViewAutoResize']}} "{{{
      let g:goldenview__enable_default_mapping=0
      nmap <F4> <Plug>ToggleGoldenViewAutoResize
    "}}}
endif "}}}
if count(g:settings.plugin_groups, 'icons') "{{{
    " icons for vim-airline vimfiler 
    NeoBundle 'ryanoasis/vim-devicons'
endif "}}}
if count(g:settings.plugin_groups, 'windows') "{{{
    if s:is_windows
        NeoBundleLazy 'PProvost/vim-ps1', {'autoload':{'filetypes':['ps1']}}
        "{{{
        autocmd BufNewFile,BufRead *.ps1,*.psd1,*.psm1 setlocal ft=ps1
        "}}}
        NeoBundleLazy 'nosami/Omnisharp', {'autoload':{'filetypes':['cs']}}
    endif
endif "}}}
"
" Funciones 
"
function! Preserve(command) "{{{
    " preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " do the business:
    execute a:command
    " clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction "}}}
function! StripTrailingWhitespace() "{{{
    call Preserve("%s/\\s\\+$//e")
endfunction "}}}
function! EnsureExists(path) "{{{
    if !isdirectory(expand(a:path))
        call mkdir(expand(a:path))
    endif
endfunction "}}}
function! CloseWindowOrKillBuffer() "{{{
    let number_of_windows_to_this_buffer = len(filter(range(1, winnr('$')), "winbufnr(v:val) == bufnr('%')"))

    " never bdelete a nerd tree
    if matchstr(expand("%"), 'NERD') == 'NERD'
        wincmd c
        return
    endif

    if number_of_windows_to_this_buffer > 1
        wincmd c
    else
        bdelete
    endif
endfunction "}}}
function! ChangeCurrentDirectory() "{{{
    if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif
endfunction
" }}}
function! FixLastSpellingError() "{{{
    normal! mm[s1z=`m"
endfunction
" }}}
"
" Asignaciones (Mappings)
"
" Edición {{
    " salir del modo insercion rapidamene
    inoremap jk <esc>
    inoremap <S-CR> <Esc>
    " Cut, Paste, Copy
    vmap <C-x> d
    vmap <C-v> p
    vmap <C-c> y
    " hacer Y consistente con C and D. See :help Y.
    nnoremap Y y$
    " Undo, Redo (broken)
    nnoremap <C-z> :undo<CR>
    inoremap <C-z> <Esc>:undo<CR>
    nnoremap <C-y> :redo<CR>
    inoremap <C-y> <Esc>:redo<CR>
    " Toggle paste mode
    nmap <silent> <F4> :set invpaste<CR>:set paste?<CR>
    imap <silent> <F4> <ESC>:set invpaste<CR>:set paste?<CR>
    " Guardar todos los archivos
    map <Esc><Esc> :w<CR>
    noremap <C-s> :update<CR>
    vnoremap <C-s> <C-c>:update<CR>
    inoremap <C-s> <Esc>:update<CR>
    " Buscar
    if mapcheck('<space>/') == ''
        nnoremap <space>/ :vimgrep //gj **/*<left><left><left><left><left><left><left><left>
    endif
    " mostrar/ocultar caracteres especiales
    "nmap <leader>l :set list! list?<cr>
    " reselect last paste
    nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'
    " Swap two words
    nmap <silent> gw :s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR>`'
    " Underline the current line with '='
    nmap <silent> <leader>ul :t.<CR>Vr=
    " set text wrapping toggles
    nmap <silent> <leader>tw :set invwrap<CR>:set wrap?<CR>
    " mover linea una posicion hacia arriba o abajo
    nmap <c-up> [e
    nmap <c-down> ]e
    nmap <C-k> [e
    nmap <C-j> ]e
    vmap <c-up> [egv
    vmap <c-down> ]egv
    vmap <C-k> [egv
    vmap <C-j> ]egv
    " formatear todo el documento
    nmap <leader>fef :call Preseve("normal gg=G")<CR>
    " nnoremap <leader>fef :normal! gg=G``<CR>
    " borrar espacios en blanco del final d la linea
    nmap <leader>f$ :call StripTrailingWhitespace()<CR>
    " borrar lineas en blanco.
    nmap <leader>fd :call Preserve(":g/^$/d")<CR>
    " ordenar lineas albaticamente/numeralmente
    vmap <leader>s :sort<cr>
    " upper/lower word
    " nmap <leader>u mQviwU`Q
    " nmap <leader>l mQviwu`Q
    " upper/lower first char of word
    " nmap <leader>U mQgewvU`Q
    " nmap <leader>L mQgewvu`Q
" }}
" Busqueda {
    " Limpiar el resultado de busqueda
    nmap <silent> ,/ :nohlsearch<CR>
    " sane regex
    nnoremap / /\v
    vnoremap / /\v
    nnoremap ? ?\v
    vnoremap ? ?\v
    " mostrar/ocultar resaltado de busqueda
    nnoremap <BS> :set hlsearch! hlsearch?<cr>
    " find current word in quickfix
    nnoremap <leader>fw :execute "vimgrep ".expand("<cword>")." %"<cr>:copen<cr>
    " find last search in quickfix
    nnoremap <leader>ff :execute 'vimgrep /'.@/.'/g %'<cr>:copen<cr>
" }
" Corrector Ortográfico {
    nnoremap <leader>sp :call FixLastSpellingError()<cr>
" }
" Identación {
    " reselect visual block after indent
    vnoremap < <gv
    vnoremap > >gv
    " identar con command-[]
    vmap <A-]> >gv
    vmap <A-[> <gv
    nmap <A-]> >>
    nmap <A-[> <<
    omap <A-]> >>
    omap <A-[> <<
    imap <A-]> <Esc>>>i
    imap <A-[> <Esc><<i
" }
" Navegación {
    " buffers
    nnoremap <M-right> :bnext<CR>
    imap <M-right> <Esc>:bnext<CR>
    nnoremap <M-left> :bprevious<CR>
    imap <M-left> <Esc>:bprevious<CR>
    " cerrar buffer
    nnoremap <silent> Q :call CloseWindowOrKillBuffer()<cr>
    " tabs
    nnoremap <M-up> :tabnext<CR>
    imap <M-up> <Esc>:tabnext<CR>
    nnoremap <M-down> :tabprev<CR>
    imap <M-down> <Esc>:tabprev<CR>
    " cambiar la posicion del cursor en insert-mode
    " inoremap <C-h> <left>
    " inoremap <C-l> <right>
    " Divisiones
    " <c-w> s               dividir horizontal
    " <c-w> v               dividir vertical
    " Tabs
    " gt                    Mover al tab siguiente
    " gT                    Mover al tab previo
    " #gt                   Moverse al tab #
    " Navegación por Tabs
    ""map <C-S-]> gt
    ""map <C-S-[> gT
    ""map <C-1> 1gt
    ""map <C-2> 2gt
    ""map <C-3> 3gt
    ""map <C-4> 4gt
    ""map <C-5> 5gt
    ""map <C-6> 6gt
    ""map <C-7> 7gt
    ""map <C-8> 8gt
    ""map <C-9> 9gt
    ""map <C-0> :tablast<CR>
    " Listas de Cambio y saltos
    " g;                    Moverse atras a travez de la lista de cambios
    " g,                    Moverse delante a travez de la lista de cambios
    " :changes              Lista de cambios
    " <c-O>                 Saltar hacia atraz a travez de la lista de saltos
    " <c-I>                 Saltar hacia delante a travez de la lista de saltos
    " :jumps                Lista de Saltos
    " <c-]>                 Seguir el enlace bajo el cursor
    " Abrir archivo
    ""cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<cr>
    ""map <leader>ew :e %%
    ""map <leader>es :sp %%
    ""map <leader>ev :vsp %%
    ""map <leader>et :tabe %%
    " Movovimiento no fisicos entre lineas
    nnoremap <silent> j gj
    nnoremap <silent> k gk
    " noremap  <buffer> <silent> 0 g0
    " noremap  <buffer> <silent> $ g$
    " auto center
    " nnoremap <silent> n nzz
    " nnoremap <silent> N Nzz
    " nnoremap <silent> * *zz
    " nnoremap <silent> # #zz
    " nnoremap <silent> g* g*zz
    " nnoremap <silent> g# g#zz
    " nnoremap <silent> <C-o> <C-o>zz
    " nnoremap <silent> <C-i> <C-i>zz
    " movimiento entre ventanas
    nnoremap <leader>v <C-w>v<C-w>l
    nnoremap <leader>s <C-w>s
    nnoremap <C-h> <C-w>h
    nnoremap <C-j> <C-w>j
    nnoremap <C-k> <C-w>k
    nnoremap <C-l> <C-w>l
    " Abrir rapidamente un buffer
    " nnoremap gb :ls<cr>:e #
    " Some helpers to edit mode
    " http://vimcasts.org/e/14
    nmap <leader>ew :e <C-R>=expand('%:h').'/'<cr>
    nmap <leader>es :sp <C-R>=expand('%:h').'/'<cr>
    nmap <leader>ev :vsp <C-R>=expand('%:h').'/'<cr>
    nmap <leader>et :tabe <C-R>=expand('%:h').'/'<cr>
"}
" command-line window {
    nnoremap q: q:i
    nnoremap q/ q/i
    nnoremap q? q?i
    " After whitespace, insert the current directory into a command-line path
    cnoremap <expr> <C-P> getcmdline()[getcmdpos()-2] ==# ' ' ? expand('%:p:h') : "\<C-P>"
" }
" Replegado {
    nnoremap zr zr:echo &foldlevel<cr>
    nnoremap zm zm:echo &foldlevel<cr>
    nnoremap zR zR:echo &foldlevel<cr>
    nnoremap zM zM:echo &foldlevel<cr>
" }
" Misc {
    " TODO: Investigar como se usa.
    if neobundle#is_sourced('vim-dispatch')
        nnoremap <leader>tag :Dispatch ctags -R<cr>
    endif
    " Mostrar informacion sobre la palabra actual
    map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
        \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
        \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
    " cd to the directory containing the file in the buffer
    nmap <silent> <leader>cd :lcd %:h<CR>
    " Create the directory containing the file in the buffer
    nmap <silent> <leader>md :!mkdir -p %:p:h<CR>
    " Adjust viewports to the same size
    nmap <Leader>= <C-w>=
    " Togle hide tool and menu
    nmap <silent> <C-F11> :if &guioptions =~# 'T' <Bar>
                \set guioptions-=T <Bar>
                \set guioptions-=m <bar>
                \else <Bar>
                \set guioptions+=T <Bar>
                \set guioptions+=m <Bar>
                \endif<CR>
    "vim over ssh
    vmap "+y :!xclip -f -sel clip
    map "+p :r!xclip -o -sel clip
" }
"
"
" Autocomandos
"
" HelpFile {
  au FileType helpfile set nonumber
" }
" Misc {
" go back to previous position of cursor if any
  au FileType make setlocal noexpandtab
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \ exe 'normal! g`"zvzz' |
    \ endif
  "
  au BufNewFile,BufRead *.json set ft=javascript
  autocmd FileType js,scss,css autocmd BufWritePre <buffer> call StripTrailingWhitespace()
  autocmd FileType css,scss setlocal foldmethod=marker foldmarker={,}
  autocmd FileType css,scss nnoremap <silent> <leader>S vi{:sort<CR>
  autocmd FileType python setlocal foldmethod=indent tabstop=4 shiftwidth=4
  autocmd FileType vim setlocal foldmethod=indent tabstop=2 shiftwidth=2 keywordprg=:help
  autocmd FileType markdown setlocal nolist

  " Syntax of these languages is fussy over tabs Vs spaces
  " autocmd FileType make setlocal ts=8 sts=8 sw=8 noexpandtab
  " autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

  " Customisations based on house-style (arbitrary)
  autocmd FileType html setlocal ts=2 sts=2 sw=2 expandtab
  " autocmd FileType css setlocal ts=2 sts=2 sw=2 expandtab
  " autocmd FileType javascript setlocal ts=4 sts=4 sw=4 noexpandtab

  " Treat .rss files as XML
  " autocmd BufNewFile,BufRead *.rss setfiletype xml
" }}

" Terminar de cargar, desabilitar plugins {
  if exists('g:settings.disabled_plugins')
    for plugin in g:settings.disabled_plugins
      exec 'NeoBundleDisable '.plugin
    endfor
  endif

call neobundle#end()

  filetype plugin indent on
  syntax enable
  NeoBundleCheck
"}
