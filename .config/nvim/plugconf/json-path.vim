" Optionally copy path to a named register (* in this case) when calling :JsonPath
let g:jsonpath_register = '*'

" Define mappings for json buffers
au FileType json noremap <buffer> <silent> <space>zw :call jsonpath#echo()<CR>
au FileType json noremap <buffer> <silent> <space>Zg :call jsonpath#goto()<CR>
