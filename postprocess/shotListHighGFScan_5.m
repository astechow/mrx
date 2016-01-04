function [out,pos,fcshift]=shotListHighGFScan_5
% GF LP pos scan on 12/08/2015
% high fill pressure (2.5/0.9, 3.6 mTorr?), GF 0
% FC shift in positive direction for second half

out=168000+[
    574:581 ...
    582:589 ...
    590:597 ...
    598:607 ...
    608:616 ...
    620:627 ...
    629:637 ...
    638:647 ...
    648:657 ...
    658:665 ...
    ];

pos=[
    ones(1,8)*41.5 ...
    ones(1,8)*39.5 ...
    ones(1,8)*37.5 ...
    ones(1,10)*35.5 ...
    ones(1,9)*33.5 ...
    ones(1,8)*41.5 ...
    ones(1,9)*39.5 ...
    ones(1,10)*37.5 ...
    ones(1,10)*35.5 ...
    ones(1,8)*33.5 ...
    ];

fcshift=[
    ones(1,8)*0 ...
    ones(1,8)*0 ...
    ones(1,8)*0 ...
    ones(1,10)*0 ...
    ones(1,9)*0 ...
    ones(1,8)*+3 ...
    ones(1,9)*+3 ...
    ones(1,10)*+3 ...
    ones(1,10)*+3 ...
    ones(1,8)*+3 ...
    ];
    