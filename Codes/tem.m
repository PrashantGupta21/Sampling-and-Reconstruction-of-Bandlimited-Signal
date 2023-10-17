function [y,tk] = tem(x,Ts,b,k,s,a)
% time encoding machine

% x = original signal
% Ts = sampling interval
% b = bias constant
% k = integrator constant
% a = integrator shift
% s = threshold constant

% y = integrator signal
% tk = spike interval

x = (x+b)/k;
tk = [];
sum = a-s;
y = [];

for n = 1:length(x)
    y = [y,sum];
    sum = sum + Ts*x(n);
    if(sum >= s)
        tk = [tk,Ts*n];
        diff = sum - s;
        sum = diff - s;
    end 
end
end

