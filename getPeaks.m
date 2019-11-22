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
[pks idx] = findpeaks(out_smooth, "MinPeakDistance", round(2));

NNI = []
k = 2;
l = 1;
interval = 0.0;
pulse_time_interval = 60 / (length(out_smooth));
for i = 1:length(idx)
  if k == (length(idx) + 1)
    break;
  end
  interval = idx(k) - idx(i);
  NNI(l) = interval * pulse_time_interval;
  ++l;
  ++k;
end

AVNN = mean(NNI);

SDNN = sum(arrayfun(@(k) (NNI(k) - AVNN)^2, 1:length(NNI) ));
SDNN = SDNN / (length(NNI) - 1);
SDNN = sqrt(SDNN);

subplot(1, 1, 1)
plot(t_out,out_smooth,t_out(idx),out_smooth(idx),'xr;NN Interval;')
xlabel(['SDNN = ', num2str(SDNN), ' seconds', '                         AVNN = ', num2str(AVNN), ' seconds'])
title("                                                                                         PPG Data") 
axis tight
legend("Location","NorthOutside","Orientation","horizontal")