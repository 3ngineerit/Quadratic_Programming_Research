clc; clear all;

t = tcpip('192.168.1.102', 9999, 'NetworkRole', 'client');
fopen(t);
x = '20.0000';

while 1 == 1
    disp('write')
    len = length(x);
    data_out = [num2str(len), x];
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