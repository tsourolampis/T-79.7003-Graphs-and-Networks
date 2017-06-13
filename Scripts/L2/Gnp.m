function A = Gnp(n,p) 

% Generates a random binomial graph on vertex set [n], edge probability p 

A = double(rand(n) <= p); 
A = triu(A,1);
A = A + A'; 
 

