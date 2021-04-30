function ppg_pulse_wave_diagram
% Creates the PPG pulse wave diagrams at:
% https://commons.wikimedia.org/wiki/File:Photoplethysmogram_(PPG)_pulse_wave.svg
%
% Author: Peter H Charlton, 30 April 2021

% setup
up = setup_up;

%% Make PPG pulse wave diagram
if up.settings.make_ppg_pulse_wave_fig_log
    make_ppg_pulse_wave_fig(up)
end

%% Make PPG pulse wave decomposition diagram
if up.settings.make_ppg_pulse_wave_decomposition_fig_log
    make_ppg_pulse_wave_decomposition_fig(up)
end
    
close all

end

function save_plot(plot_handle, filename, up)

save_path = [up.paths.folders.plot, filename];
print(plot_handle, save_path, '-depsc')
print(plot_handle, save_path, '-dpng')
print(plot_handle, '-dsvg', save_path)
fid = fopen([save_path, '.txt'], 'w');
fprintf(fid, ['Created using ' mfilename, ', ', date]);
fclose(fid);

end

function up = setup_up

close all

% - path to save plot
[filepath,~,~] = fileparts(mfilename('fullpath'));
up.paths.folders.plot = [filepath, filesep];
% - plot settings
up.settings.ftsize = 14;
% - choose figure to make
up.settings.make_ppg_pulse_wave_fig_log = 1;
up.settings.make_ppg_pulse_wave_decomposition_fig_log = 1;
% - specify pulse wave params
up.settings.offset1 = 16;
up.settings.offset2 = 15;

% - eliminating high freqs
up.filtering.elim_high_freqs.Fpass = 9;  % in HZ
up.filtering.elim_high_freqs.Fstop = 7;  % in HZ
up.filtering.elim_high_freqs.Dpass = 0.05;
up.filtering.elim_high_freqs.Dstop = 0.01;

end

function ppg_data = load_beat_data(beat_no, up)

ppg_data.fs = 100;

if beat_no == 1
    % - data are from the single pulse wave recording at: https://doi.org/10.5281/zenodo.3268500
    ppg_data.v = [-1488;-1450.8;-1339;-1138.4;-857.30;-523.60;-174.50;156.90;450.20;697.90;899.20;1053.6;1160;1219.6;1239.6;1232.8;1212.3;1186;1154.7;1116;1070;1021.8;978.90;945.80;921.10;899;874.20;846.50;820.60;801.60;789.40;777.80;757.30;722.30;674.70;623.90;581.40;555.40;547.80;555.60;574.40;601;633.90;672;713.70;756.10;796.10;830.90;858;876;884;882.50;873.20;858;838.40;815.10;788.40;759.50;730.60;704.20;681.70;662.90;646;628.60;609.30;587.40;563;536.40;507.70;477.10;445.30;413.20;382.20;353.40;327.30;304.10;282.80;262.20;241;218.70;196.70;177.10;161.70;150.10;139.10;124.30;102.90;76;48.600;26.900;14;7.9000;2.8000;-6.9000;-23.100;-42.500;-59.900;-71.600;-78.400;-84.700;-94.900;-110.40;-129.10;-147.50;-163.90;-180;-199.30;-223.90;-252.40;-279.80;-301.10;-315;-325.60;-339.50;-361.30;-389.80;-418.90;-441.70;-456.20;-465.80;-477.10;-494.20;-516.70;-541;-564.50;-586.50;-607.70;-627;-641.40;-649.10;-652.10;-656.80;-669.40;-691.10;-716.70;-738.50;-751.90;-758.80;-765.30;-777.80;-798.20;-824.50;-852.30;-877.70;-899.20;-916.90;-932.30;-947.50;-964.80;-985.50;-1009.3;-1034.4;-1057.7;-1076.8;-1090.8;-1101.2;-1111.6;-1126.7;-1150.2;-1181.5;-1215.1;-1242.7;-1258.5;-1264.4;-1269.8;-1284.5;-1308.2;-1324.1];
elseif beat_no == 2
    % - data are from the 1-hour recording at: https://doi.org/10.5281/zenodo.3268500  (obtained from: data.ppg_ir(94924:95066))
    ppg_data.v = [-1458.4;-1427.6;-1340.4;-1175.1;-926.80;-613.60;-270.60;64;362.20;611.60;812.30;969.10;1086.4;1168;1219;1247.4;1261.5;1266.8;1264.6;1253.2;1231.6;1201.3;1166.1;1130.3;1097;1067.6;1041.9;1018.1;992.50;960.30;917.50;863.20;801.70;740.60;687.70;647.80;620.50;603.20;593.60;592.50;602.60;626.20;661.70;703.90;745.60;781.80;810.80;833.70;851.70;864.80;871.50;870.20;860.30;842.60;818.60;789.70;757.50;723.90;690.70;658.80;628;597.10;565.70;534.20;503.30;472.90;441.60;407.50;370.40;332.30;296.60;265.50;238.20;211.30;181.20;146.40;108.50;71;37.400;9.6000;-13.200;-33.500;-54.600;-78.800;-106;-133.50;-156.80;-173.20;-183.30;-191.30;-203;-221.60;-246.20;-273;-298.50;-322;-345.80;-372.20;-401.40;-430.60;-456.20;-476.40;-492.50;-507.70;-524.80;-544.90;-567.60;-591.80;-617.20;-643.40;-670;-696.50;-723.20;-751;-780.30;-810.20;-837.70;-859.90;-876.80;-892.20;-911.30;-937.10;-967.70;-997.50;-1021.9;-1040.7;-1058.5;-1080.5;-1108.2;-1138.2;-1165.2;-1186.4;-1204.2;-1224.3;-1251.3;-1284.9;-1319.5;-1347.9;-1366.5;-1378.1;-1390.3;-1408.2;-1426.5];
%     ppg_data.v = repmat(ppg_data.v, [3,1]);
%     % - filter pulse wave
%     filt_characteristics = up.filtering.elim_high_freqs;
%     s = elim_vhfs3(ppg_data, filt_characteristics);
%     ppg_data.v = s.v( (length(s.v)/3)+1 : (2*length(s.v)/3) );
end

ppg_data.v = movmean(ppg_data.v,9);
temp = linspace(ppg_data.v(1), ppg_data.v(end), length(ppg_data.v));
ppg_data.v = ppg_data.v - temp(:);
ppg_data.v = (ppg_data.v-min(ppg_data.v))/range(ppg_data.v);

% - add parts of pulse wave either side if necessary
if beat_no == 1
ppg_data.v = [ppg_data.v(end-up.settings.offset1:end); ppg_data.v; ppg_data.v(1:1+up.settings.offset2)];
end

% - calculate time vector
ppg_data.t = [0:length(ppg_data.v)-1]/ppg_data.fs;

end

function make_ppg_pulse_wave_fig(up)
% Load data for a single PPG beat
beat_no = 1;
ppg_data = load_beat_data(beat_no, up);

% Plot
paper_size = [5.00, 3.30]; n = 100;
figure('Position', [100, 100, paper_size(1)*n, paper_size(2)*n])
plot(ppg_data.t, ppg_data.v, 'LineWidth', 2, 'Color', [0,0,1]),
xlim([min(ppg_data.t), max(ppg_data.t)])
ylim([-0.4, 1.3])

% annotate
pos = [0.14,0.71,0.07,0];
const_dist = 0.015;
pos2 = pos; pos2(2) = pos2(2)-const_dist;
annotation('textbox','Position', pos2, 'String', {'Systolic', 'upslope'}, 'HorizontalAlignment', 'center', 'LineStyle', 'none', 'FontSize', up.settings.ftsize-3)
pos3 = [0.36,0.85,0.07,0];
annotation('textbox','Position', pos3, 'String', 'Diastolic peak', 'HorizontalAlignment', 'center', 'LineStyle', 'none', 'FontSize', up.settings.ftsize)
pos4 = [0.22,0.92,0.07,0];
annotation('textbox','Position', pos4, 'String', 'Systolic peak', 'HorizontalAlignment', 'center', 'LineStyle', 'none', 'FontSize', up.settings.ftsize)
pos5 = [0.31,0.64,0.07,0];
annotation('textbox','Position', pos5, 'String', 'Dicrotic notch', 'HorizontalAlignment', 'center', 'LineStyle', 'none', 'FontSize', up.settings.ftsize)
pos6 = [0.60,0.61,0.22,0];
annotation('textbox','Position', pos6, 'String', {'Diastolic', 'decay'}, 'HorizontalAlignment', 'center', 'LineStyle', 'none', 'FontSize', up.settings.ftsize)
pos8 = [0.20,0.27,0.06,0];
pos9 = pos8; pos9(2) = pos9(2)-const_dist;
annotation('doublearrow','Position', pos8, 'LineStyle', '--')
annotation('textbox','Position', pos9, 'String', {'Anacrotic', 'Phase'}, 'HorizontalAlignment', 'center', 'LineStyle', 'none', 'FontSize', up.settings.ftsize)
pos10 = [0.26,0.27,0.59,0];
pos11 = pos10; pos11(1) = pos11(1)+0.01; pos11(2) = pos11(2)-const_dist;
annotation('doublearrow','Position', pos10, 'LineStyle', '--')
annotation('textbox','Position', pos11, 'String', {'Catacrotic', 'Phase'}, 'HorizontalAlignment', 'center', 'LineStyle', 'none', 'FontSize', up.settings.ftsize)
pos12 = [0.215,0.45,0.46,0];
pos13 = pos12; pos13(2) = pos13(2)-const_dist;
annotation('doublearrow','Position', pos12, 'LineStyle', '--')
annotation('textbox','Position', pos13, 'String', 'Width', 'HorizontalAlignment', 'center', 'LineStyle', 'none', 'FontSize', up.settings.ftsize)

% extras
set(gca, 'YTick', [], 'FontSize', up.settings.ftsize)
ylab = ylabel('PPG (unitless)', 'FontSize', up.settings.ftsize);
xlabel('Time (s)')
%set(ylab, 'Units', 'Normalized', 'Position', [-0.09, 0.5, 0]);
box off

% save picture
set(gcf,'color','w');
filename = 'ppg_pulse_wave';
save_plot(gcf, filename, up)

end

function make_ppg_pulse_wave_decomposition_fig(up)

% Load data for a single PPG beat
beat_no = 2;
s = load_beat_data(beat_no, up);

% Perform decomposition
[pulse1,rem] = decompose_pw(s, up);
[pulse2,rem] = decompose_pw(rem, up);
[pulse3,rem] = decompose_pw(rem, up);

% Adjust pulse3 to make a diagram with only two pulses
% - adjust timing
[~, max_sig_el] = max(s.v-pulse1.v);
[~, max_pulse_el] = max(pulse3.v);
offset = max_pulse_el - max_sig_el;
if offset > 0
    pulse3.v = [pulse3.v(offset+1:end); zeros(offset,1)];
end

for pulse_no = [1,3]
    eval(['curr_data = pulse' num2str(pulse_no) ';']);
    
    % - adjust amplitude
    curr_data.v(curr_data.v>s.v) = s.v(curr_data.v>s.v);

    % - remove negative portions
    [~, max_el] = max(curr_data.v);
    start_el = find(curr_data.v(1:max_el) < 0, 1, 'last');
    end_el = max_el-1 + find(curr_data.v(max_el:end) < 0, 1);
    curr_data.v(1:start_el) = 0;
    curr_data.v(end_el:end) = 0;
    
    % - add time
    curr_data.t = s.t;
    
    % - add peak
    [~, curr_data.pk] = max(curr_data.v);
    
    % - store
    eval(['pulse' num2str(pulse_no) ' = curr_data;']);
    
end

% Plot
paper_size = [5.00, 3.30]; n = 100;
figure('Position', [100, 100, paper_size(1)*n, paper_size(2)*n])

% - plot pulses
for pulse_no = [1,3]
    eval(['curr_data = pulse' num2str(pulse_no) ';']);
    rel_els = find(curr_data.v>0);
    rel_els = [rel_els(1)-1; rel_els; rel_els(end)+1];
    %plot(curr_data.t(rel_els), curr_data.v(rel_els), 'k', 'LineWidth', 2);
    fill(curr_data.t(rel_els), curr_data.v(rel_els), ((pulse_no+3)/8)*ones(1,3), 'LineStyle', 'none')
    hold on
end
% - plot pulse wave
plot(s.t, s.v, 'b', 'LineWidth', 2), hold on

for pulse_no = [1,3]
    eval(['curr_data = pulse' num2str(pulse_no) ';']);
    
    % - Plot centre lines
    plot(curr_data.t(curr_data.pk)*ones(2,1), [0,curr_data.v(curr_data.pk)], '--k', 'LineWidth', 1)
    
    % - Plot peaks
    plot(curr_data.t(curr_data.pk), curr_data.v(curr_data.pk), 'or', 'LineWidth', 2, 'MarkerFaceColor', 'r', 'MarkerEdgeColor', 'none', 'MarkerSize', 8)
    
end

xlabel('Time (s)', 'FontSize', up.settings.ftsize+2)
ylab = ylabel('PPG', 'FontSize', up.settings.ftsize+2, 'Rotation', 0);
set(ylab,'Units','normalized', 'position',get(ylab,'position') - [0.01 0 0]);
set(gca, 'FontSize', up.settings.ftsize-2, 'YTick', [])
set(gca, 'Layer', 'top')
box off
xlim([min(s.t), max(s.t)])
ylim([0, 1.3])

% annotate
% - crest time
pos = [0.13,0.86,0.1,0];
annotation('doublearrow','Position', pos, 'LineStyle', '-')
const_dist = 0.06;
pos(2) = pos(2)+const_dist;
pos(3) = pos(3)+0.04;
annotation('textbox','Position', pos, 'String', 'Rise time', 'HorizontalAlignment', 'left', 'LineStyle', 'none', 'FontSize', up.settings.ftsize-3)
% - time delay
pos = [0.24,0.86,0.16,0];
annotation('doublearrow','Position', pos, 'LineStyle', '-')
const_dist = 0.06;
pos(2) = pos(2)+const_dist;
pos(3) = pos(3)+0.04;
annotation('textbox','Position', pos, 'String', '   Time delay', 'HorizontalAlignment', 'left', 'LineStyle', 'none', 'FontSize', up.settings.ftsize-3)
% - reflected wave magnitude
pos = [0.42,0.12,0,0.52];
annotation('doublearrow','Position', pos, 'LineStyle', '-')
pos(4) = pos(4)*2/3;
pos(1) = pos(1);
annotation('textbox','Position', pos, 'String', {'Reflected', 'wave', 'magnitude'}, 'HorizontalAlignment', 'left', 'LineStyle', 'none', 'FontSize', up.settings.ftsize-3)
% - incident wave
pos = [0.18,0.17,0.09,0.1];
annotation('textbox','Position', pos, 'String', {'Incident', 'wave'}, 'HorizontalAlignment', 'center', 'FontSize', up.settings.ftsize-3, 'BackgroundColor', 'w', 'EdgeColor', 'w')
% - reflected wave
pos = [0.36,0.17,0.095,0.1];
annotation('textbox','Position', pos, 'String', {'Reflected', 'wave'}, 'HorizontalAlignment', 'center', 'FontSize', up.settings.ftsize-3, 'BackgroundColor', 'w', 'EdgeColor', 'w')
% - systolic peak
pos = [0.19,0.75,0.09,0.1];
annotation('textbox','Position', pos, 'String', 'Systolic peak', 'HorizontalAlignment', 'center', 'LineStyle', 'none', 'FontSize', up.settings.ftsize-3)
% - diastolic peak
pos = [0.36,0.66,0.09,0.1];
annotation('textbox','Position', pos, 'String', 'Diastolic peak', 'HorizontalAlignment', 'center', 'LineStyle', 'none', 'FontSize', up.settings.ftsize-3)
% - diastolic decay
pos6 = [0.60,0.44,0.22,0];
annotation('textbox','Position', pos6, 'String', {'Diastolic', 'decay'}, 'HorizontalAlignment', 'center', 'LineStyle', 'none', 'FontSize', up.settings.ftsize-3)

% save picture
set(gcf,'color','w');
filename = 'ppg_pulse_wave_composition';
save_plot(gcf, filename, up)

end

function [pulse,rem_lpf] = decompose_pw(s, up)

% - filter pulse wave
filt_characteristics = up.filtering.elim_high_freqs;
s = elim_vhfs3(s, filt_characteristics);
% - Identify first peak
pk = find(s.v(1:end-1)>s.v(2:end) & s.v(1:end-1)>0.5*max(s.v),1);
% - Create first symmetric pulse
pulse.v = [s.v(1:pk); flipud(s.v(1:pk))];
pulse.v = [pulse.v; zeros(length(s.v)-length(pulse.v),1)];
pulse.fs = s.fs;
% - Calculate remainder
rem.v = s.v - pulse.v;
rem.fs = s.fs;
% - filter remainder
rem_lpf = elim_vhfs3(rem, filt_characteristics);
% - set initial portion of remainder to zero
[~, temp] = max(rem_lpf.v);
start_el = 1+find(rem_lpf.v(1:temp)<=0, 1, 'last');
rem_lpf.v(1:start_el-1) = 0;
rem_lpf.fs = s.fs;

end

function s_filt = elim_vhfs3(s, filt_characteristics)
%% Filter signal to remove VHFs
% Adapted from RRest

s_filt.fs = s.fs;

%% Eliminate nans
s.v(isnan(s.v)) = mean(s.v(~isnan(s.v)));

%% Check to see if sampling freq is at least twice the freq of interest
if (filt_characteristics.Fpass/(s.fs/2)) >= 1
    % then the fs is too low to perform this filtering
    s_filt.v = s.v;
    return
end

%% Create filter
% parameters for the low-pass filter to be used
AMfilter = create_lpf(filt_characteristics, s);

%% Re-make filter if it requires too many samples for this signal
% check to see if it requires too many samples
req_sig_length = 3*(length(AMfilter.numerator)-1);
no_attempts = 0;
while no_attempts<4 && length(s.v)<=req_sig_length
    % change Fpass (i.e. the high frequency end of the filter band)
    filt_characteristics.Fpass = filt_characteristics.Fpass+0.75*(filt_characteristics.Fpass-filt_characteristics.Fstop);
    % re-make filter
    AMfilter = create_lpf(filt_characteristics, s);
    % update criterion
    req_sig_length = 3*(length(AMfilter.numerator)-1);
    % increment number of attempts
    no_attempts = no_attempts+1;
end
if length(s.v)<=req_sig_length
    fprintf('\n - Couldn''t perform high frequency filtering')
end

%% Check frequency response
% Gives a -3 dB cutoff at cutoff_freq Hz, using:
% freqz(AMfilter.Numerator)
% norm_cutoff_freq = INSERT_HERE;    % insert freq here from plot
% cutoff_freq = norm_cutoff_freq*(s.fs/2);

%% Remove VHFs
if length(s.v)>req_sig_length
    s_filt.v = filtfilt(AMfilter.numerator, 1, s.v);
else
    s_filt.v = s.v;
end

end

function AMfilter = create_lpf(filt_characteristics, s)

[N,Wn,BETA,TYPE] = kaiserord([filt_characteristics.Fstop filt_characteristics.Fpass]/(s.fs/2), [1 0], [filt_characteristics.Dstop filt_characteristics.Dpass]);
b  = fir1(N, Wn, TYPE, kaiser(N+1, BETA), 'scale');
AMfilter = dfilt.dffir(b);

end
