function handles = initImages(handles) %#ok<INUSL>
% initialize 2D plots

% get magnetic probe data
d    = getappdata(handles.figure1,'magData');

% initialize with zero data
data = zeros(size(d(1).Bx(:,:,1)));
data(end) = 1;

for i=1:4
    w = warning('off','MATLAB:contourf:NonFiniteData');
    h = handles.(['imagePlot' num2str(i)]);
    contourplot(h,d(1).z*1000,d(1).x*1000,data,handles)
    warning(w)
end

end

function contourplot(h,x,y,data,handles)

% modified version of contourfi
hold(h,'off')
[h,x,y,c,~,m,levels,argin] = contsurfi(h,x,y,data,0,max(abs(data(:)')));
cval=linspace(-m, m, 2*levels+1);
if get(handles.lqGfxButton,'Value')
    imagesc(x,y,c,'Parent',h);
    axis(h,'xy')
else
    contourf(h,x,y,c,cval,argin{:},'edgecolor','none');
end
hold(h,'on')
xlabel(h,'z [mm]')
ylabel(h,'x [mm]')
xlim(h,[min(x(:)),max(x(:))])
ylim(h,[min(y(:)),max(y(:))])
zoom(h,'reset')
axis(h,'image')
colormap bluered
colorbar
caxis([-m m])
hline(375)
vline(0)

end