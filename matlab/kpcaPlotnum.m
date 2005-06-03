function kpcaPlotnum(X, Y, fontSize, fontName);

% KPCAPLOTNUM A function to plot points as numbers rather than symbols.

% KPCA

if nargin < 4
    fontName='helvetica';
    if nargin < 3
       fontSize = 12;
    end
end

plot(X, Y);
xlim=get(gca, 'xlim');
ylim=get(gca, 'ylim');
clf
for i=1:size(X, 1)
  handle = text(X(i), Y(i), num2str(i));
  set(handle, 'fontsize', fontSize);
  set(handle, 'fontname', fontName);
end
set(gca, 'xlim', xlim, 'ylim', ylim);
box on;
