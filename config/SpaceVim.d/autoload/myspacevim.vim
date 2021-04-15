function! myspacevim#before() abort
  let g:ale_shell = 'bash'
  let g:ale_linters = {
    \'cpp': ['clang', 'clangtidy', 'cpplint'],
    \'c': ['clang', 'clangtidy'],
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
  " KITE
  let g:kite_supported_languages = ['python', 'cpp']
  set completeopt+=menuone
  set completeopt+=noinsert
endfunction

function! myspacevim#after() abort
endfunction
