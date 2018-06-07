# -*- coding: utf-8 -*-

import vim
import numpy as np
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
