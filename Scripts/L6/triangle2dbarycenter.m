function x = triangle2dbarycenter(points) 

[n d]=size(points);
if(n~=3 || d~=2)
    error('input should be 3 points in 2d, not %d points in %d dim\n',n,d);
end

x=mean(points);

