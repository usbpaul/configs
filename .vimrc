" have syntax highlighting in terminals which can display colours:
if has('syntax') && (&t_Co > 2)
  syntax on
endif

augroup folds
  " Read and write folds
  au!
  autocmd BufReadPost,FileReadPost      *.* loadview
  autocmd BufWritePost,FileWritePost    *.* mkview
augroup END

function InsertTabWrapper()
      let col = col('.') - 1
      if !col || getline('.')[col - 1] !~ '\k'
          return "\<tab>"
      else
          return "\<c-p>"
      endif
endfunction

" Create folds
map <C-l> :syn region myFold start="{" end="}" transparent fold^M :syn sync fromstart^M :set foldnestmax=2^M :set foldmethod=syntax^M
:highlight Folded ctermbg=gray ctermfg=Blue

"Display a status-line
set ruler

set ts=3
set sw=3
map q :q
map v :w
"map t :%!tidy -raw -xml -i -q -w 80
"map t :%!tidy -raw -xml -i -q -w 0
"map t :.s/\(.*\)/\/\/\1\/\//
"map t :.,$s/[[include \(...\)]]/[[span class="pagenumber"]][[[\1|\1]]][[\/span]]<CR>[[include \1]]/gc
map t :.,$s/\[\[include \(....\?\)\]\]/[[span class="pagenumber"]][[[\1\|\1]]][[\/span]]\r[[include \1]]/gc<CR>

inoremap <tab> <c-r>=InsertTabWrapper()<cr>

au BufNewFile,BufRead *.xhtml setfiletype html

set encoding=utf-8
set guifont=Monaco:h12
" Hoe krijg ik het voor elkaar dat de volgende regel alleen wordt uitgevoerd als gvim start (vanuit Firefox bijvoorbeeld)?
"set columns=144
