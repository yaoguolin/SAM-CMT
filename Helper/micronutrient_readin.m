dir = 'C:\Users\gyao\Google Drive\SAM_CMT\'; %***
dir_s = '\';      

NUTRITION_FILE = 'Micronutrition.csv';
clear fname;
fname = [dir 'Inputs' dir_s NUTRITION_FILE];
fid = fopen(fname)

fmt = '%f	%s	%f	%f	%f	%f	%f	%f	%f	%f	%f	%f	%f	%f	%f	%f	%f	%f	%f	%f	%f	%f	%f';                                %***
hd_no = 23;                                                %***

Raw_header = textscan(fid, '%s', hd_no, 'delimiter', ',');
Raw_Data = textscan(fid, fmt,'delimiter',',');
fclose(fid);

crop_no = Raw_Data{1,1}.*10;
Carb = Raw_Data{1,4}.*10;
Fiber = Raw_Data{1,5}.*10;
Sugar = Raw_Data{1,6}.*10;
Ca = Raw_Data{1,7}.*10;
Fe = Raw_Data{1,8}.*10;
Mg = Raw_Data{1,9}.*10;
Ph = Raw_Data{1,10}.*10;
K = Raw_Data{1,11}.*10;
Na = Raw_Data{1,12}.*10;
Zn = Raw_Data{1,13}.*10;
VC = Raw_Data{1,14}.*10;
Thia = Raw_Data{1,15}.*10;
Ribo = Raw_Data{1,16}.*10;
Niac = Raw_Data{1,17}.*10;
VB6 = Raw_Data{1,18}.*10;
Fol = Raw_Data{1,19}.*10;
VB12 = Raw_Data{1,20}.*10;
VA = Raw_Data{1,21}.*10;
VE = Raw_Data{1,22}.*10;
VD = Raw_Data{1,23}.*10;

save('micronutrition.mat','Carb','Fiber','Sugar','Ca','Fe','Mg','Ph','K','Na','Zn','VC',...
    'Thia','Ribo','Niac','VB6','Fol','VB12','VA','VE','VD');
