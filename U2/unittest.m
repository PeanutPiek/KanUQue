clear;
home;
close all;

filename = 'unittest.dict';

c_ = [8 5 3 0 1 7];
p_ = [0.1 0.1 0.2 0.3 0.1, 0.2];


[H0, H1, LM] = hufftr(c_, p_, filename);

dict = readtable(filename, 'Format', '%s%s', 'FileType', 'Text', 'delimiter', ';');