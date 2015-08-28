% https://goo.gl/xsSfDp
function movePololuServo(port, channel, servo_setting) % all input
   
% Initialize
    ser1 = serial(port);
    set(ser1, 'InputBufferSize', 2048);
    set(ser1, 'BaudRate', 9600);
    set(ser1, 'DataBits', 8);
    set(ser1, 'Parity', 'none');
    set(ser1, 'StopBits', 1);
    fopen(ser1);
    
    % Format servo command
    lower = bin2dec(regexprep(mat2str(fliplr(bitget(6120, 1:7))), '[^\w'']', ''));
    upper = bin2dec(regexprep(mat2str(fliplr(bitget(servo_setting, 8:14))), '[^\w'']', ''));

% Simple Serial Protocol
    % 0x84 = 132 = move servo
    command = [132, channel, lower, upper];
    
% Send the command
    fwrite(ser1, command);
    
% Clean up
    fclose(ser1);
    delete(ser1);
end