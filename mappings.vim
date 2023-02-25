" Key Mappings

inoremap jj <Esc>

let mapleader = " "
let maplocalleader = ","

nnoremap <silent> <leader>      :<c-u>WhichKey '<Space>'<CR>
nnoremap <silent> <localleader> :<c-u>WhichKey  ','<CR>

" System clipboard
inoremap <c-v> <c-r>+
vnoremap <c-c> "+y

cnoremap <c-a> <home>
cnoremap <c-e> <end>

" Map completion to Ctrl-Space
"inoremap <c-space> <c-x><c-o>
"inoremap <silent><expr> <c-space> coc#refresh()
inoremap <silent><expr> <C-Space> compe#complete()
"inoremap <silent><expr> <CR>      compe#confirm('<CR>')
"inoremap <silent><expr> <C-e>     compe#close('<C-e>')
"inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
"inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })

" Clear highlight with \ (opposite of /)
nnoremap <silent> \ :noh<cr>

" Mappings to quickly move through the results
"
" Move quickly between windows
nnoremap <C-h> <c-w>h
nnoremap <C-j> <c-w>j
nnoremap <C-k> <c-w>k
nnoremap <C-l> <c-w>l

" Use shift + hjkl to resize windows
nnoremap <silent> <s-down>  :resize -2<CR>
nnoremap <silent> <s-up>    :resize +2<CR>
nnoremap <silent> <s-left>  :vertical resize -2<CR>
nnoremap <silent> <s-right> :vertical resize +2<CR>

" Escape insert mode in the terminal
tnoremap <esc> <c-\><c-n>

" Format tables using pipe separators
vnoremap \| :Tab /\|<cr>

" Hide the floating terminal
tnoremap <c-x> <c-\><c-n>:FloatermHide<cr>

" Show the given buffer along the top of the tab
:command! -nargs=? Top :top :new | :b <args>

"============================================================
" Neovim Native LSP Client Config
"============================================================

" These are customized for Clojure
" :h lsp-config to find other mappings
" Oh, now they do it in a more Lua-ish way
" Nvm, works for now!
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
inoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gA    <cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap <silent> gR    <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent> ge    <cmd>lua vim.diagnostic.open_float()<CR>
nnoremap <silent> gi    <cmd>lua vim.lsp.buf.incoming_calls()<CR>
nnoremap <silent> go    <cmd>lua vim.lsp.buf.outgoing_calls()<CR>
nnoremap <silent> gn    <cmd>lua vim.diagnostic.goto_next()<CR>
nnoremap <silent> gp    <cmd>lua vim.diagnostic.goto_prev()<CR>



"============================================================
" Spacemacs/Spacevim inspired mappings
"
" Let this be the way forward!
"============================================================

"------------------------------------------------------------
" Quickfix commands SPC c...
"------------------------------------------------------------
"
nnoremap <silent> <leader>cn :cn<cr>
nnoremap <silent> <leader>cp :cp<cr>

"------------------------------------------------------------
" Buffer commands SPC b...
"------------------------------------------------------------

nnoremap <leader>bz :Clap buffers<cr>

"------------------------------------------------------------
" File commands SPC f...
"------------------------------------------------------------

nnoremap <leader>ft :NERDTreeToggle<cr>
nnoremap <leader>ff :NERDTreeFind<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fz <cmd>Telescope find_files<cr>

"------------------------------------------------------------
" Notes commands SPC n...
"------------------------------------------------------------

nnoremap <leader>nd :Diary<cr>
nnoremap <leader>ni :NewNote<cr>
nnoremap <leader>nn :Notes<cr>
