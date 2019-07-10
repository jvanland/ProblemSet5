pro interr
xnumE = [-128, 7.8175669581, 1.4494507953, 0.8185580244, 0.7013416422]
xnumRK = [0.6491651279, 0.6508692165, 0.6502966258, 0.6502879154, 0.650287841100]
xnumLF = [0.0, 0.6130261383, 0.6463301610, 0.6499334912, 0.6502484860]
xex = double(sin(15))
errE = abs(xnumE-xex)
errRK = abs(xnumRK-xex)
errLF = abs(xnumLF-xex)
step = [1, 0.3, 0.1, 0.03, 0.01]
set_plot, 'PS'
device, filename = '~/Documents/ASTR_615/ps5vanland/Error.ps'
xrange = [0.001, 10]
yrange = [0.00000000001, 200]
xtitle = 'Stepsize'
ytitle = 'Error'
title = 'Integration Error'
plot, step, errRK, /xlog, /ylog, psym = 2, xrange=xrange, yrange=yrange, xtitle=xtitle, ytitle=ytitle, title=title
oplot, step, errE, psym = 5
oplot, step, errLF, psym =4
legend, ['Euler', 'LF', 'RK4'], psym = [5,4,2]
device, /close
set_plot, 'X'
print, errRK[4]
print, sin(15)
end