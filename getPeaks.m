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
[pks idx] = findpeaks(data1);

dt = t(2)-t(1);
[pks2 idx2] = findpeaks(data1, "MinPeakDistance", round(4/dt));
annotation('textbox',[0.5 0.01 0.1 0.1],'string','my text','fitboxtotext','on');

subplot(1, 1, 1)
plot(t,data1,t(idx2),data1(idx2),'or')
axis tight
legend("Location","NorthOutside","Orientation","horizontal")