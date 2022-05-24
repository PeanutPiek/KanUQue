clear;
home;
close all;

filename = 'huff_s2201.dict';

dict = readtable(filename, 'Format', '%s%s', 'FileType', 'Text', 'delimiter', ';');

array = table2array(dict);
codes = array(:,2);
symbols = array(:,1);

[sorted, sortIdx] = sort(cellfun(@length,codes),'descend');
symbols_sorted = symbols(sortIdx);



