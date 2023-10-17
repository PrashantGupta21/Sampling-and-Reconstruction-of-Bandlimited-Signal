Ts = 0.001;
t = 0:Ts:5;
x = sinc(t-2.5);                            % function to be sampled
b = 5;                                      % input bias
k = 1;                                      % integrator constant
s = 0.1;                                    % threshold value
a = 0;

figure;
subplot(3,1,1)
plot(t,x);
title("original signal");
xlabel("t")
ylabel("x(t)");
[y,tk] = tem(x,Ts,b,k,s,a);
subplot(3,1,2)
plot(t,y);
title("integrator signal");
xlabel("t")
ylabel("y(t)");
subplot(3,1,3);
stem(tk,2*s*ones(size(tk)));
title("spike interval");
xlabel("tk")
ylabel("s");


[y,tk] = tem(x,Ts,b,k,s,a);
w = 2*pi;
T = tk(length(tk));
X = tdm(tk,t,b,k,s,w,1000);     % Here 1000 denotes the number of iterations
figure;
subplot(3,1,1);
plot(t,x,'-r');
title('Original Signal');
xlabel('t');
ylabel('f(t)');
subplot(3,1,2);
plot(t,X,'-b');
title('Reconstructed Signal');
xlabel('t');
ylabel('f(t)');
subplot(3,1,3);
plot(t,abs(X-x));
title('Magnitude of error');
xlabel('t');
ylabel('Err(t)');