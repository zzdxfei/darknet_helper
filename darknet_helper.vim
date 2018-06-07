function! s:IsHandled()
    let first_line = getline(1)
    return first_line!~':'
endfunction

let flag = s:IsHandled()
if flag == 0
    let word = 'avg'
    execute '/' . word
    global!++normal dd
    %normal 0dW2Wd$x
endif

pyfile darknet_helper.py
if flag == 0
    execute 'normal u'
endif
