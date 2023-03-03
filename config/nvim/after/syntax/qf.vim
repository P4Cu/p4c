highlight TestRun    ctermfg=green
highlight TestOk     ctermfg=green
highlight TestPassed ctermfg=green
highlight TestError  ctermfg=red

syn match TestRun    "\[ RUN      \]"
syn match TestOk     "\[       OK \]"
syn match TestError  "\[  FAILED  \]"
syn match testPassed "\[  PASSED  \]"
