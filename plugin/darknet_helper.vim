" zzdxfei
" Thu Jun  7 09:53:24 UTC 2018

function! s:DrawResult()
python << EOF
import vim
import numpy as np
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt

current_buffer = vim.current.buffer
lines = current_buffer[:]

if len(lines) != 0:
    losses = []
    avg_losses = []

    for line in lines:
        loss, avg_loss = line.split(',')
        losses.append(float(loss))
        avg_losses.append(float(avg_loss))

    losses = np.array(losses)
    avg_losses = np.array(avg_losses)
    iters = np.arange(losses.shape[0])
    plt.plot(iters, losses, color='red', linewidth=2.5,
             linestyle='-', label='loss')
    plt.plot(iters, avg_losses, color='green', linewidth=2.5,
             linestyle='-', label='avg loss')
    plt.legend(loc='upper right')
    plt.savefig('result.png')
EOF
endfunction

function! s:DarknetHelper()
    let word = 'avg'
    execute '/' . word
    global!++normal dd
    %normal 0dW2Wd$x
    call s:DrawResult()
    execute 'normal u'
    echo "result.png has saved."
endfunction

if exists("g:loaded_darknet_helper")
    finish
endif
let g:loaded_darknet_helper = 1

if !exists(":DarknetHelper")
    command -nargs=0 DarknetHelper :call s:DarknetHelper()
endif

if !hasmapto('<Plug>DarknetHelper')
    map <unique> <leader>vd <Plug>DarknetHelper
endif

noremap <unique> <script> <Plug>DarknetHelper <SID>DarknetHelper
noremap <SID>DarknetHelper :call <SID>DarknetHelper()<CR>
