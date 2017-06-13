% if you want to run this demo script download matlab bgl 
% from this url http://www.mathworks.com/matlabcentral/fileexchange/10922-matlabbgl
% and add it to your path 
addpath('C:\Users\tsourolampis\blah\matlab_bgl');
addpath(genpath('C:\Users\tsourolampis\blah\matlab_bgl'));

n = 1000; 
for p = 0 : 0.001 : 1 %<- crude search for p* 
    A = Gnp(n,p); 
    A = sparse(A);
    if( max(components(A))== 1) %<- this checks when we have only one connected component
        pstar = p;
        break %<- no need to continue our search for p*
    end
end

% let's see what happens for small values of p than the pstar we found
A = Gnp(1000, 0.005); 
A = sparse(A);
[ci sizes] = components(A);
sizes 
 

A = Gnp(1000, 0.0065); 
A = sparse(A);
[ci sizes] = components(A);
sizes 

A = Gnp(1000, 0.0068);
A = sparse(A);
[ci sizes] = components(A);
sizes

A = Gnp(1000, 0.00684);
A = sparse(A);
[ci sizes] = components(A);
sizes


A = Gnp(1000, 0.007);
A = sparse(A);
[ci sizes] = components(A);
sizes
