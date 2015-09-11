% A value of 0 corresponds to no acceleration limit , 
% range 0-255
% At the minimum acceleration setting of 1, the servo output takes about 3 seconds to move smoothly from a target of 1 ms to a target of 2 ms.

function setAcc(port, channel, servo_setting) % all input
   
% Initialize
    ser1 = serial(port);
    set(ser1, 'InputBufferSize', 2048);
    set(ser1, 'BaudRate', 9600);
    set(ser1, 'DataBits', 8);
    set(ser1, 'Parity', 'none');
    set(ser1, 'StopBits', 1);
    fopen(ser1);
    
    % Format servo command
    lower = bin2dec(regexprep(mat2str(fliplr(bitget(servo_setting, 1:7))), '[^\w'']', ''));
    
    upper = bin2dec(regexprep(mat2str(fliplr(bitget(servo_setting, 8:14))), '[^\w'']', ''));

% Simple Serial Protocol
    % 0x89 = 137 = set speed
    command = [137, channel, lower, upper];
    
% Send the command
    fwrite(ser1, command);
    
% Clean up
    fclose(ser1);
    delete(ser1);
end
