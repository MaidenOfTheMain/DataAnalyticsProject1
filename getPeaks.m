data1 = abs(load("data.txt"));
data1_mean = ceil(mean(data1));
current_outlier = outlier(data1);
[out] = rmoutlier(data1);
current_outlier = outlier(out);
while (current_outlier > data1_mean)
  [out] = rmoutlier(out);
  current_outlier = outlier(out);
endwhile
t_out = 0:1:size(out, 1)-1;
out_smooth = sgolayfilt(sgolayfilt(out));
[pks idx] = findpeaks(out_smooth, "MinPeakDistance", round(4));



subplot(1, 1, 1)
plot(t_out,out_smooth,t_out(idx),out_smooth(idx),'xr')
title("PPG Data")
axis tight
legend("Location","NorthOutside","Orientation","horizontal")