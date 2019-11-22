% Load PPG data into variable 'raw_data'.
raw_data = abs(load("data.txt"));

% Start to remove outlier data, and create output array 'out' for 'raw_data' without outliers.
current_outlier = outlier(raw_data);
[out] = rmoutlier(raw_data);
current_outlier = outlier(out);

% While loop of above removal.
raw_data_mean = ceil(mean(raw_data));
while (current_outlier > raw_data_mean)
  [out] = rmoutlier(out);
  current_outlier = outlier(out);
endwhile

% Find 'out' size, and smooth 'out' data.
t_out = 0:1:size(out, 1)-1;
out_smooth = sgolayfilt(sgolayfilt(out));
[pks idx] = findpeaks(out_smooth, "MinPeakDistance", round(2));

% Start to make variables for NN interval transfer.
NNI = []
i_plus_one = 2;
i = 1;
interval = 0.0;
pulse_time_interval = 60 / (length(out_smooth));

% For loop to index through 'idx'.
for index_for_idx = 1:length(idx)
  if i_plus_one == (length(idx) + 1)
    break;
  end
  interval = idx(i_plus_one) - idx(index_for_idx);
  NNI(i) = interval * pulse_time_interval;
  ++i;
  ++i_plus_one;
end

% Find AVNN (Average of NN).
AVNN = mean(NNI);

% Find the SDNN (Standard Deviation of NN).
SDNN = sum(arrayfun(@(k) (NNI(k) - AVNN)^2, 1:length(NNI) ));
SDNN = SDNN / (length(NNI) - 1);
SDNN = sqrt(SDNN);

% Plot both 'out_smooth' and 'idx', along with showing results for AVNN and SDNN.
subplot(1, 1, 1)
plot(t_out,out_smooth,t_out(idx),out_smooth(idx),'xr;NN Interval;')
xlabel(['SDNN = ', num2str(SDNN), ' seconds', '                         AVNN = ', num2str(AVNN), ' seconds'])
title("                                                                                         PPG Data") 
axis tight
legend("Location","NorthOutside","Orientation","horizontal")