syntax clear jsonCommentError
syntax match jsonComment "//.*"
syntax match jsonComment "\(/\*\)\|\(\*/\)"
hi def link jsonComment Comment
hi clear jsonCommentError
hi! link jsonCommentError NONE
let g:vim_json_warnings = 0
