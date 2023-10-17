function [X_res] = tdm(tk,t,b,k,s,w,L)
dt = t(2) - t(1) ;                      % declaring dt as sampling time Ts
Rx = zeros(1,length(t)) ;               % declaring array  
x_res = zeros(L,length(t)) ;                % matrix to store all values of x in every iteraion
g = zeros(length(tk)-1,length(t)) ;     % rectangular matrix which stores the sinc values at all values of t

% below loop is to find the sinc reconstruction for all values of t 
for i = 1:(length(tk)-1)
    sk = ( tk(i) + tk(i+1) )/2 ;
    g(i,:) = sin(w*(t-sk))./(pi*(t-sk)) ;
    % condition to check if any of the element get divided by 0 when
    % (t-sk)= 0 then at that index that value becomes w/pi
    if sum( t == sk ) >= 1
        g(i,t==sk) = w/pi ;
    end
end
% Loop to calculate the R(x) = x_{0}
for i = 1:(length(tk)-1)
    Rx = Rx + ( 2*k*s - b*(tk(i+1)-tk(i)) ).*g(i,:) ;
end
x_res(1,:) = Rx ;       % equating the first iteration result to Rx
% below loop calculates for L-1 iterations
for i = 2:L
    Rxl = zeros(1,length(t)) ;
    pos = 1 ;                                           % variable storing positions of t to integrate from
        for K = 1:(length(tk)-1)
            integ = 0 ;                                 % variable which stores the integration results  
            while pos <=length(t) && t(pos) <= tk(K+1)  % loop for calculating the integrals
                if t(pos) >= tk(K)
                    integ = integ + x_res(i-1,pos)*dt ;   % calculating the integral value from t_k to t_k+1 for all k
                end
                pos = pos+1;
            end
            Rxl = Rxl + integ.*g(K,:) ;              % summing up the values for Rxl as given in paper
        end
    x_res(i,:) = x_res(i-1,:)-Rxl+Rx;              % applying the recursive algorithm
end
X_res = x_res(L,:);                 % returns the vector calculated at the last iteration i.e., Lth column of x_res
end