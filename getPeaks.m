file = load("data.txt");
t = 0:1:size(file, 1)-1;
data1 = abs(file);
data1_mean = ceil(mean(data1));
current_outlier = outlier(data1);
[out] = rmoutlier(data1);
current_outlier = outlier(out);
while (current_outlier > data1_mean)
  [out] = rmoutlier(out);
  current_outlier = outlier(out);
endwhile
[pks idx] = findpeaks(out);
t_out = 0:1:size(out, 1)-1;
[yh, lambda] = regdatasmooth (t_out, out, "d",4,"stdev",1e-1,"midpointrule");

dt = t_out(2)-t_out(1);
[pks2 idx2] = findpeaks(out, "MinPeakDistance", round(4/dt));
annotation('textbox',[0.5 0.01 0.1 0.1],'string','my text','fitboxtotext','on');

subplot(1, 1, 1)
plot(t_out,out,t_out(idx2),out(idx2),'or')
axis tight
legend("Location","NorthOutside","Orientation","horizontal")