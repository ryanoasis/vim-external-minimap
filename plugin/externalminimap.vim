"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Minimap: NOT A TRUE PLUGIN (YET) DO NOT USE
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


" test vim-external-minimap server bindings:

":nmap h h:let curwin=winnr()<CR>:keepjumps windo redraw<CR>:execute curwin . "wincmd w"<CR>
":nnoremap j j:let curwin=winnr()<CR>:keepjumps windo redraw<CR>j:execute curwin . "wincmd w"<CR>
":nmap k k:let curwin=winnr()<CR>:keepjumps windo redraw<CR>:execute curwin . "wincmd w"<CR>
":nmap l l:let curwin=winnr()<CR>:keepjumps windo redraw<CR>:execute curwin . "wincmd w"<CR>

"nmap <silent> j j | :execute ":silent !vim --servername VIM-EXTERNAL-MINIMAP --remote-send 'j'"<CR>
"nmap <silent> k k | :execute ":silent !vim --servername VIM-EXTERNAL-MINIMAP --remote-send 'k'"<CR>
"nmap <silent> <c-u> <c-u> | :execute ":silent !vim --servername VIM-EXTERNAL-MINIMAP --remote-send '<c-u>'"<CR>
"nmap <silent> <c-d> <c-d> | :execute ":silent !vim --servername VIM-EXTERNAL-MINIMAP --remote-send '<c-d>'"<CR>

" ^ these need to be mapped to a goto line on the server!

"function! externalMinimap#GotoLine(line)
function! GotoLine(line)
	"echom "gotoline called"
	"echom a:line
	execute "silent !vim --servername VIM-EXTERNAL-MINIMAP --remote-send ':" . a:line . "<CR>'"
endfunction

function! MinimapOpen()
	execute "silent !gvim -R % +" . shellescape(line(".")) . ' "+set nonumber" "+set foldcolumn=0" "+set tabline=" "+set norelativenumber" "+set noruler" "+set laststatus=0" "+set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Plus\ Nerd\ File\ Types\ 3" "+set lines=130" "+set columns=90" --servername VIM-EXTERNAL-MINIMAP'
endfunction

function! UpdateHighlight()
	let l:start = line("w0")
	let l:end = line("w$")
	let l:centerize = "zz"
	let l:file = expand('%:t')
	"let l:matchUpdate = "match externalminimap /".'\\%'."".l:start.'l\|'.'\\%'."".l:end."l/"
	" now lets match the range: /\%>10l\&\%<14l/
	" ^ matches line 10 to 14^
	let l:matchUpdate = "match externalminimap /".'\\%>'."".l:start.'l\&'.'\\%<'."".l:end."l/"
	let l:signStartUnplaceUpdate = "sign unplace 1 file=" . l:file
	let l:signEndUnplaceUpdate = "sign unplace 2 file=" . l:file
	let l:signStartUpdate = "sign place 1 line=" . l:start . " name=wholeline file=" . l:file
	let l:signEndUpdate = "sign place 2 line=" . l:end . " name=wholeline file=" . l:file
	execute "silent !vim --servername VIM-EXTERNAL-MINIMAP --remote-send ':" . l:matchUpdate . "<CR>'"
	execute "silent !vim --servername VIM-EXTERNAL-MINIMAP --remote-send ':" . l:signStartUnplaceUpdate . "<CR>'"
	execute "silent !vim --servername VIM-EXTERNAL-MINIMAP --remote-send ':" . l:signEndUnplaceUpdate . "<CR>'"
	execute "silent !vim --servername VIM-EXTERNAL-MINIMAP --remote-send ':" . l:signStartUpdate . "<CR>'"
	execute "silent !vim --servername VIM-EXTERNAL-MINIMAP --remote-send ':" . l:signEndUpdate . "<CR>'"
	execute "silent !vim --servername VIM-EXTERNAL-MINIMAP --remote-send '" . l:centerize . "<CR>'"
endfunction

" could try signs (to get it to appear the width of the window):
" :sign define wholeline linehl=ErrorMsg
" :sign place 1 line=3 name=wholeline file=aw.advancedfilters.js

function! GotoCurrentLine()
	call GotoLine(line('.'))
endfunction

function! ServerRunning()
	"execute "silent !vim --serverlist <CR>"
	let l:servers = split(system("vim --serverlist"), "\n")
	let l:running = 0
	"echom l:servers[0]
	for i in l:servers
		if i == "VIM-EXTERNAL-MINIMAP"
			"echom "running"
			let l:running = 1
		endif
	endfor
	
	if l:running == 1
		"echom "server is running, execute methods"
	else
		"echom "server is NOT running, NOT executing methods"
	endif

	return l:running
endfunction


function! MinimapUpdate()
	"echom "minimapupdate"
	if ServerRunning() == 1
		call GotoCurrentLine()
		call UpdateHighlight()
	endif
endfunction


"nmap <silent> j j | :execute ":silent !vim --servername VIM-EXTERNAL-MINIMAP --remote-send ':" . line('.') . "<CR>'"<CR>
"nmap <silent> k k | :execute ":silent !vim --servername VIM-EXTERNAL-MINIMAP --remote-send ':" . shellescape(line(".")) . "<CR>'"<CR>
"nmap <silent> <c-u> <c-u> | :execute ":silent !vim --servername VIM-EXTERNAL-MINIMAP --remote-send ':" . shellescape(line(".")) . "<CR>'"<CR>
"nmap <silent> <c-d> <c-d> | :execute ":silent !vim --servername VIM-EXTERNAL-MINIMAP --remote-send ':" . shellescape(line(".")) . "<CR>'"<CR>

" refactor:
" using map_bar (help map_bar)

"highlight externalminimap ctermbg=lightgray guibg=lightgray
highlight link externalminimap Visual
sign define wholeline linehl=Search


"nmap <silent> j j | :call MinimapExecute()<CR>
"nmap <silent> k k | :call MinimapExecute()<CR>
"nmap <silent> <c-u> <c-u> | :call MinimapExecute()<CR>
"nmap <silent> <c-d> <c-d> | :call MinimapExecute()<CR>
"nmap <silent> <LeftMouse> <LeftMouse> | :call MinimapExecute()<CR>
"nmap j :call GotoLine(2)<CR>

"nnoremap <silent> j j | :call MinimapExecute()<CR>
"nnoremap <silent> k k | :call MinimapExecute()<CR>
"nnoremap <silent> <c-u> <c-u> | :call MinimapExecute()<CR>
"nnoremap <silent> <c-d> <c-d> | :call MinimapExecute()<CR>

" patch/hack fix the screen flashing annoyance until proper solution?
set novisualbell

" see: help map_bar
"nnoremap <silent> j j|:call MinimapUpdate()<CR>
"nnoremap <silent> k k|:call MinimapUpdate()<CR>
"nnoremap <silent> <c-u> <c-u>|:call MinimapUpdate()<CR>
"nnoremap <silent> <c-d> <c-d>|:call MinimapUpdate()<CR>
"nnoremap <silent> <S-g> <S-g>|:call MinimapUpdate()<CR>
"nnoremap <silent> gg gg |:call MinimapUpdate()<CR>
"nnoremap <silent> <CR> <CR> |:call MinimapUpdate()<CR>

nnoremap <leader>mm :call MinimapOpen()<CR>
