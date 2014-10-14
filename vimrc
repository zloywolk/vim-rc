" All system-wide defaults are set in $VIMRUNTIME/debian.vim (usually just
" /usr/share/vim/vimcurrent/debian.vim) and sourced by the call to :runtime
" you can find below.  If you wish to change any of those settings, you should
" do it in this file (/etc/vim/vimrc), since debian.vim will be overwritten
" everytime an upgrade of the vim packages is performed.  It is recommended to
" make changes after sourcing debian.vim since it alters the value of the
" 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim

" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
"set compatible

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
syntax on
set number
set background=dark
set tabstop=4
set wildmenu


" statusline
set laststatus=2
set statusline=\ \ %f\ %1*%m%*\ %R%=\'%F\'\ %4l(%p%%):%c\ 0x%2B\ %y,%{&encoding}

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
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

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

function Bind_F5_C()
	if filereadable("Makefile")
		set makeprg=make
		map <F5> :w<CR>:make<CR>:cw<CR>
		imap <F5> <ESC>:w<CR>:make<CR>:cw<CR>
	else
		map <F5> :w<CR>:make %:r<CR>:cw<CR>
		imap <F5> <ESC>:w<CR>:make %:r<CR>:cw<CR>
	endif
endfunction

au FileType c,cc,cpp,h,hpp,s call Bind_F5_C()

function Bind_F9_C()
	if filereadable("Makefile")
		set makeprg=make
		map <F6> :w<CR>:make<CR>:cw<CR>:!./%<<CR>
		imap <F6> <ESC>:w<CR>:make<CR>:cw<CR>:!./%<<CR>
	else
		map <F6> :w<CR>:make %:r<CR>:cw<CR>:!./%<<CR>
	imap <F6> <ESC>:w<CR>:make %:r<CR>:cw<CR>:!./%<<CR>
	endif
endfunction

au FileType c,cc,cpp,h,hpp,s call Bind_F9_C()

autocmd FileType c set omnifunc=ccomplete#Complete
