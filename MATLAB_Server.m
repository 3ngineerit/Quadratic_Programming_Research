clc; clear all;

%t = tcpip('192.168.1.102', 9999, 'NetworkRole', 'client');
%fopen(t);
mat = [20.0000, 215.0, 6567.0156; 16123.03, 2313.0, 1.0000];
dim_mat = size(mat);
mat = mat2str(mat);
x = [1.025434, .013254];
dim_vec = size(x);
x = mat2str(x);

while 1 == 1
    disp('write')
    len = length(x);
    data_out = ['M:',num2str(dim_mat(1)),'x',num2str(dim_mat(2)),mat,'V:',num2str(dim_vec(2)),x];
    data_out = regexprep(data_out,'[','');
    data_out = regexprep(data_out,']','');
    fwrite(t,data_out, 'char');
    disp(['finish write ' num2str(x)]);
    disp('read');
    data_in_length = fread(t,1);
    data_in_length = char(data_in_length);
    data_in = fread(t,str2num(data_in_length));
    data_in = transpose(char(data_in));
    disp(['finish read ' data_in]);
    x = data_in;
end

fclose(t);