clear;
home;
close all;

A_ = [0 0 0; 1 1 1; 0 0 0; 1 1 1];
R = runlength(A_);
assert(R==[3 3 3 3]);

A_ = [0 0 1 1; 1 1 1 0; 0 0 1 1];
R = runlength(A_);
assert(R==[2 5 3 2]);

A_ = [1 0; 0 1; 1 1; 0 1; 0 0];
R = runlength(A_);
assert(R==[1 2 3 1 1 2]);