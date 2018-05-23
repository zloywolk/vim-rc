syntax on
set number
set tabstop=4

set wildmenu

" statusline
set laststatus=2
set statusline=\ \ %f\ %1*%m%*\ %R%=\'%F\'\ %4l(%p%%):%c\ 0x%2B\ %y,%{&encoding}

set t_Co=256

let lapis256_colors_file=$HOME."/.vim/colors/lapis256.vim"

if filereadable(lapis256_colors_file)
	colorscheme lapis256
else
	colorscheme default
endif

"
" If using a dark background within the editing area and syntax highlighting
" turn on this option as well

" Uncomment the following to have Vim jump to the last position when
" reopening a file
"if has("autocmd")
"  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
"    \| exe "normal g'\"" | endif
"endif

" Uncomment the following to have Vim load indentation rules according to the
" detected filetype. Per default Debian Vim only load filetype specific
" plugins.
"if has("autocmd")
"  filetype indent on
"endif

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
"set showcmd		" Show (partial) command in status line.
"set showmatch		" Show matching brackets.
"set ignorecase		" Do case insensitive matching
"set smartcase		" Do smart case matching
"set incsearch		" Incremental search
"set autowrite		" Automatically save before commands like :next and :make
"set hidden             " Hide buffers when they are abandoned
"set mouse=a		" Enable mouse usage (all modes) in terminals

" Source a global configuration file if available
" XXX Deprecated, please move your changes here in /etc/vim/vimrc
"if filereadable("/etc/vim/vimrc.local")
"  source /etc/vim/vimrc.local
"endif

" THIS IS A TAB SETTINGS


function MyTabLine()
	let tabline = ''
	for i in range(tabpagenr('$'))
		if i + 1 == tabpagenr()
			let tabline .= '%#TabLineSel#'
		else
			let tabline .= '%#TabLine#'
		endif
		let tabline .= '%' . (i + 1) . 'T'
		let tabline .= '| %{MyTabLabel(' . (i + 1) . ')} |'
	endfor
	let tabline .= '%#TabLineFill#%T'
	if tabpagenr('$') > 1
		let tabline .= '%=%#TabLine#%999XX'
	endif
	return tabline
endfunction

function MyTabLabel(n)
	let label = ''
	let buflist = tabpagebuflist(a:n)
	let label = substitute(bufname(buflist[tabpagewinnr(a:n) - 1]), '.*/', '', '')
	if label == ''
		let label = ' {noname} '
	endif
	let label .= ' [' . a:n . ']'
	for i in range(len(buflist))
		if getbufvar(buflist[i], "&modified")
			let label = '[+] ' . label
			break
		endif
	endfor
	return label
endfunction

function MyGuiTabLabel()
	return '%{MyTabLabel[' . tabpagenr() . ']}'
endfunction

set tabline=%!MyTabLine()
set guitablabel=%!MyGuiTabLabel()


nmap < :tabprevious<CR>
nmap > :tabnext<CR>
nmap t :tabnew<CR>
nmap z :tabclose<CR>
