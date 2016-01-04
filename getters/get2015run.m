function [shots,desc] = get2015run(sel)

[num, txt] = xlsread('shotlist.xlsx');

purposeInd = find(strcmp(txt(1,:),'purpose'));
dateInd    = find(strcmp(txt(1,:),'date'));
GFInd      = find(strcmp(txt(1,:),'GF'));
startInd   = find(strcmp(txt(1,:),'shot start'));
endInd     = find(strcmp(txt(1,:),'shot end'));
gasInd     = find(strcmp(txt(1,:),'gas pulse'));
numberInd  = find(strcmp(txt(1,:),'number'));

if nargin == 0
    disp([num2cell(num(:,numberInd)),num2cell(num(:,dateInd)),...
        num2cell(num(:,startInd)),num2cell(num(:,GFInd)),txt(2:end,purposeInd)])
    return
end

index      = find(num(:,numberInd)==sel);
shots      = num(index,startInd):num(index,endInd);
desc.date  = num(index,dateInd);
desc.GF    = num(index,GFInd);

