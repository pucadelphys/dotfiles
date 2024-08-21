let s:run_map = {"julia": '!julia', "c": '!shstart -sn vimRunC', "html": '!brave --incognito --profile-directory="Profile 1"', "lua": '!lua', "python": '!python3', "rust": '!cargo run', "sh": '!bash', "conf": '!source', "profile": '!source', "bashrc": '!source', "bash_profile": '!source', "vim": 'source' }


function! RunDoc()
    if has_key(s:run_map, &filetype)
        let executor = s:run_map[&ft]
        let file_type = shellescape(@%, 1)
        if ( &ft=='vim' )
            let file_type = @%
        end
        write
        exec executor file_type
    else
        echo "No way to run file"
    end
endfunction

nmap <F9> :call RunDoc()<CR>
imap <F9> <esc>:call RunDoc()<CR>

autocmd FileType c nnoremap <buffer> <F9> :call RunDoc()<CR><CR>
autocmd FileType c inoremap <buffer> <F9> <esc>:call RunDoc()<CR><CR>
autocmd FileType c map <buffer> <F10> :exec '!shstart -snr ./' .. shellescape(expand("%:r"), 1) .. '.out'<CR><CR>

" autocmd FileType c map <buffer> <F10> :w<CR>:exec '!./' .. shellescape(expand("%:r"), 1) .. '.out'<CR>

