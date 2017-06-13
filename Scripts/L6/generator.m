function [A D E mymovie] = generator(Tmax,XY0,filename)

% GENERATOR.M 
% Author: Charalampos E. Tsourakakis 
% Copyright 2012  
% This function simulates a Random Apollonian Network in two dimensions.
% For more see "On Certain Properties of Random Apollonian Networks",
% Frieze, Tsourakakis WAW'12 

% INPUT 
% Tmax: number of steps 
% XY0 : a 3 by 2 matrix, containing the coordinates of the three initial
% points
% filename: a simple string. The movie is saved as filename.mat.
% OUTPUT
% A : adjacency matrix 
% D : set of triangles 
% E : embedding coordinates of the vertices 
% mymovie : matlab movie visualization of the simulation 

% Example
% Tmax=100; XY0=[10^7 0;0 0;10^7/2 10^7*sqrt(3)/2]; 
% [A D E mymovie] = generator(Tmax,XY0,'ran'); 

% If you want to convert mymovie to mpg or gif let's say, you can use code
% that exists on the Web, e.g.,
% http://www.mathworks.com/matlabcentral/fileexchange/309 
% http://www.mathworks.com/matlabcentral/fileexchange/17463

if nargin == 0 
    Tmax=100; 
    XY0=[10^7 0;0 0;10^7/2 10^7*sqrt(3)/2]; 
    filename = 'ran';
elseif nargin~=3 
    error('Usage:  [A D E mymovie] = generator(Tmax,XY0,filename)')
end
%% initialize
A = zeros(Tmax+3,Tmax+3);
A(1:3,1:3)=ones(3)-eye(3); 
E = zeros(Tmax+3,2); %<- embedding coordinates
E(1:3,:)=XY0;  %<- here go the first three vertices 
D = zeros(2*Tmax+1,3); %<- this matrix contains the triangles
D(1,:) = [1 2 3]; %<- this is our first initial triangle which will die with prob 1

%% run 

figure;
hold on
set(gca,'YTick',[])
set(gca,'YColor','w')
set(gca,'XTick',[])
plot(E(1:3,1),E(1:3,2));
line(E(1:2,1),E(1:2,2)); line(E(2:3,1),E(2:3,2)); line(E([1,3],1),E([1,3],2));

% axis tight
% set(gca,'nextplot','replacechildren','visible','off')
% winsize = getframe(fig1);
% numframes=1+Tmax;
% mymovie=moviein(numframes,fig1,winsize);
% set(fig1,'NextPlot','replacechildren')

for t=1:Tmax
    fprintf('round %d \n',t);
    % pick one of the existing triangles uniformly at random
    luckytriangle     = sample_onething(1:(2*(t-1)+1));
    point             = D(luckytriangle,:);    
    % add the coordinates of the new point in matrix E, by taking the
    % barycenter of the points of the triangle that picked it 
    newcoordinates    = triangle2dbarycenter(E(point,:)); 
    E(t+3,:)          = newcoordinates; 
    % destroy the luckytriangle
    D(luckytriangle,:)=[];
    D=[D; 0 0 0];
    % add the new three triangles
    D(2*t-1,:)=[point(1) point(2) t+3];     D(2*t,:)=[point(1) point(3) t+3];     D(2*t+1,:)=[point(2) point(3) t+3];
    % add the three new edges to our adjacency matrix 
    A(point(1),t+3)=1;    A(point(2),t+3)=1;   A(point(3),t+3)=1;
    A(t+3,point(1))=1;    A(t+3,point(2))=1;   A(t+3,point(3))=1;
    % draw them on the figure too!!! 
    line([E(point(1),1), newcoordinates(1)], [ E(point(1),2), newcoordinates(2)] ); 
    line([E(point(2),1), newcoordinates(1)], [ E(point(2),2), newcoordinates(2)] ); 
    line([E(point(3),1), newcoordinates(1)], [ E(point(3),2), newcoordinates(2)] );    
    mymovie(t)=getframe; 
end

save(filename,'mymovie')