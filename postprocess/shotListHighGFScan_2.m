function [out,pos,fcshift]=shotListHighGFScan_2
% GF LP pos scan on 12/03/2015
% low fill pressure (2.5/0.6), GF -150
% FC shift in negative direction for first half

out=[
    168124:168141 ...
    168142:168157 ...
    168158:168168 ...
    168169:168176 ...
    168177:168184 ...
    168185:168192 ...
    168193:168199 ...
    168200:168206 ...
    168207:168213 ...
    168214:168220 ...
    ];

pos=[
    ones(1,18)*41.5 ...
    ones(1,16)*39.5 ...
    ones(1,11)*37.5 ...
    ones(1,8)*35.5 ...
    ones(1,8)*33.5 ...
    ones(1,8)*41.5 ...
    ones(1,7)*39.5 ...
    ones(1,7)*37.5 ...
    ones(1,7)*35.5 ...
    ones(1,7)*33.5 ...
    ];

fcshift=[
    ones(1,18)*-3 ...
    ones(1,16)*-3 ...
    ones(1,11)*-3 ...
    ones(1,8)*-3 ...
    ones(1,8)*-3 ...
    ones(1,8)*0 ...
    ones(1,7)*0 ...
    ones(1,7)*0 ...
    ones(1,7)*0 ...
    ones(1,7)*0 ...
    ];
    