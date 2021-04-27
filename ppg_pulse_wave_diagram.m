function ppg_pulse_wave_diagram
% Creates the PPG pulse wave diagram at:
% https://commons.wikimedia.org/wiki/File:Photoplethysmogram_(PPG)_pulse_wave.svg
%
% Author: Peter H Charlton, 27 April 2021

%% PPG pulse wave diagram

% setup
% - path to save plot
[filepath,~,~] = fileparts(mfilename('fullpath'));
up.paths.folders.plot = [filepath, filesep];
% - plot settings
ftsize = 14;

% Load data for a single PPG beat
% - data are from the single pulse wave recording at: https://doi.org/10.5281/zenodo.3268500
ppg_data.v = [-1488;-1450.8;-1339;-1138.4;-857.30;-523.60;-174.50;156.90;450.20;697.90;899.20;1053.6;1160;1219.6;1239.6;1232.8;1212.3;1186;1154.7;1116;1070;1021.8;978.90;945.80;921.10;899;874.20;846.50;820.60;801.60;789.40;777.80;757.30;722.30;674.70;623.90;581.40;555.40;547.80;555.60;574.40;601;633.90;672;713.70;756.10;796.10;830.90;858;876;884;882.50;873.20;858;838.40;815.10;788.40;759.50;730.60;704.20;681.70;662.90;646;628.60;609.30;587.40;563;536.40;507.70;477.10;445.30;413.20;382.20;353.40;327.30;304.10;282.80;262.20;241;218.70;196.70;177.10;161.70;150.10;139.10;124.30;102.90;76;48.600;26.900;14;7.9000;2.8000;-6.9000;-23.100;-42.500;-59.900;-71.600;-78.400;-84.700;-94.900;-110.40;-129.10;-147.50;-163.90;-180;-199.30;-223.90;-252.40;-279.80;-301.10;-315;-325.60;-339.50;-361.30;-389.80;-418.90;-441.70;-456.20;-465.80;-477.10;-494.20;-516.70;-541;-564.50;-586.50;-607.70;-627;-641.40;-649.10;-652.10;-656.80;-669.40;-691.10;-716.70;-738.50;-751.90;-758.80;-765.30;-777.80;-798.20;-824.50;-852.30;-877.70;-899.20;-916.90;-932.30;-947.50;-964.80;-985.50;-1009.3;-1034.4;-1057.7;-1076.8;-1090.8;-1101.2;-1111.6;-1126.7;-1150.2;-1181.5;-1215.1;-1242.7;-1258.5;-1264.4;-1269.8;-1284.5;-1308.2;-1324.1];
ppg_data.v = movmean(ppg_data.v,9);
temp = linspace(ppg_data.v(1), ppg_data.v(end), length(ppg_data.v));
ppg_data.v = ppg_data.v - temp(:);
ppg_data.v = (ppg_data.v-min(ppg_data.v))/range(ppg_data.v);
ppg_data.fs = 100;
offset1 = 16; offset2 = 15;
ppg_data.v = [ppg_data.v(end-offset1:end); ppg_data.v; ppg_data.v(1:1+offset2)];
ppg_data.t = [0:length(ppg_data.v)-1]/ppg_data.fs;

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
annotation('textbox','Position', pos2, 'String', {'Systolic', 'upslope'}, 'HorizontalAlignment', 'center', 'LineStyle', 'none', 'FontSize', ftsize-3)
pos3 = [0.36,0.85,0.07,0];
annotation('textbox','Position', pos3, 'String', 'Diastolic peak', 'HorizontalAlignment', 'center', 'LineStyle', 'none', 'FontSize', ftsize)
pos4 = [0.22,0.92,0.07,0];
annotation('textbox','Position', pos4, 'String', 'Systolic peak', 'HorizontalAlignment', 'center', 'LineStyle', 'none', 'FontSize', ftsize)
pos5 = [0.31,0.64,0.07,0];
annotation('textbox','Position', pos5, 'String', 'Dicrotic notch', 'HorizontalAlignment', 'center', 'LineStyle', 'none', 'FontSize', ftsize)
pos6 = [0.60,0.61,0.22,0];
annotation('textbox','Position', pos6, 'String', {'Diastolic', 'decay'}, 'HorizontalAlignment', 'center', 'LineStyle', 'none', 'FontSize', ftsize)
pos8 = [0.20,0.27,0.06,0];
pos9 = pos8; pos9(2) = pos9(2)-const_dist;
annotation('doublearrow','Position', pos8, 'LineStyle', '--')
annotation('textbox','Position', pos9, 'String', {'Anacrotic', 'Phase'}, 'HorizontalAlignment', 'center', 'LineStyle', 'none', 'FontSize', ftsize)
pos10 = [0.26,0.27,0.59,0];
pos11 = pos10; pos11(1) = pos11(1)+0.01; pos11(2) = pos11(2)-const_dist;
annotation('doublearrow','Position', pos10, 'LineStyle', '--')
annotation('textbox','Position', pos11, 'String', {'Catacrotic', 'Phase'}, 'HorizontalAlignment', 'center', 'LineStyle', 'none', 'FontSize', ftsize)
pos12 = [0.215,0.45,0.46,0];
pos13 = pos12; pos13(2) = pos13(2)-const_dist;
annotation('doublearrow','Position', pos12, 'LineStyle', '--')
annotation('textbox','Position', pos13, 'String', 'Width', 'HorizontalAlignment', 'center', 'LineStyle', 'none', 'FontSize', ftsize)

% extras
set(gca, 'YTick', [], 'FontSize', ftsize)
ylab = ylabel('PPG (unitless)', 'FontSize', ftsize);
xlabel('Time (s)')
%set(ylab, 'Units', 'Normalized', 'Position', [-0.09, 0.5, 0]);
box off

% save picture
set(gcf,'color','w');
filename = 'ppg_pulse_wave';
save_plot(gcf, filename, up)

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