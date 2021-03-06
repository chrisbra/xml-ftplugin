source ../setup.vim

func Test_Syntax()
  new
  vsp
  let lines =<< trim END
    set nocp noshowcmd noruler
    syn off
    set rtp^=$VIM_XML_RT
    " Need to distinguish between Function and Identifier
    " for xmlTag and xmlEndTag
    hi Function ctermfg=8
    hi Identifier ctermfg=6
    e input.xml
    syn on
  END
  call writefile(lines, g:SourceFilename)
  let buf = RunVimInTerminal('--clean -S ' .. g:SourceFilename, #{rows: 5, cols: 40})
  call term_sendkeys(buf, ":redraw!\<cr>")
  call term_wait(buf, 100)
  call term_dumpwrite(buf, g:dumpname)
  " clean up
  call StopVimInTerminal(buf)
  call delete(g:SourceFilename)
endfunc

" just in case
call CleanUpFiles([g:SourceFilename, g:dumpname, g:skipped])

call Test_Syntax()
qa!
