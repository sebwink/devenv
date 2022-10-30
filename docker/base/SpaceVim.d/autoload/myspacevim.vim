function! myspacevim#before() abort
  " KITE
  let g:kite_supported_languages = ['python', 'cpp']
  set completeopt+=menuone
  set completeopt+=noinsert
  " ALE
  let g:ale_shell = 'bash'
  let g:ale_linters = {
    \'cpp': ['clangtidy', 'cpplint'],
    \'c': ['clangtidy'],
    \'cs': ['OmniSharp'],
    \'python': ['pylint'],
    \'dockerfile': ['dockerfile_lint']
  \}
  let g:ale_fixer = {
    \'cpp': ['clang-format'],
    \'*': ['remove_trailing_lines', 'trim_whitespace']
  \}
  let g:ale_cpp_clangtidy_executable = 'clang-tidy'
  let g:ale_cpp_clangtidy_checks = [
    \'bugprone-argument-comment'
  \]
  let g:ale_python_pylint_executable = 'pylint'
  " ULTISNIPS
  let g:UltiSnipsExpandTrigger="<c-s>"
  let g:UltiSnipsJumpForwardTrigger="<c-b>"
  let g:UltiSnipsJumpBackwardTrigger="<c-z>"
  " VIM-SLIME
  let g:slime_target = "tmux"
  " OmniSharp
  let g:OmniSharp_server_use_mono = 0
  " YCM command aliases
  command Yd YcmCompleter GoToDeclaration
  nnoremap <C-d> :Yd<CR>
  command Ydec YcmCompleter GoToDeclaration
  command Ydef YcmCompleter GoToDefinition
  command Yr YcmCompleter GoToReferences
  nnoremap <C-r> :Yr<CR>
  command Yg YcmCompleter GoTo
  nnoremap <C-g> :Yg<CR>
  command Yi YcmCompleter GoToInclude
  nnoremap <C-i> :Yi<CR>
endfunction

function! myspacevim#after() abort
endfunction
