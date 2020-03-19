% 1.Using the theory above, rank all 1400 MPEG7 shape images using VisualRank.
%     a.Load the ‘sim.mat’ data file into MATLAB. This file contains the 
%     similarity matrix S for the entire image dataset, as well as a cell
%     array of corresponding filenames. (0.5 marks)
%     
%     b.From S, we can form the adjacency matrix A. Start by setting A=S, 
%     then remove elements from A to leave visual hyperlinks between only 
%     those images that are positively correlated. (1 mark)
%    
%     c.Finally, remove the elements from A that correspond to loop edges in 
%     the visual similarity graph. (1 mark)
%     
%     d.Use A to create the hyperlink matrix H. (0.5 marks)e.Form the random
%     jump matrix J. (0.5 marks)
%     
%     f.Given a damping factor of ? = 0.85, create the modified visual 
%     hyperlink matrix Htilde. (0.5 marks)
%     
%     g.Find the VisualRank vector r using an initial vector. (3 marks)
%     
%     h.Given this VisualRank vector, 
%     which image is ranked highest? Display this image. (1 mark)

% START %
%a.Load the ‘sim.mat’ data file into MATLAB.
load sim.mat

%b.From S, we can form the adjacency matrix A. Start by setting A=S, 
%     then remove elements from A to leave visual hyperlinks between only 
%     those images that are positively correlated. (1 mark)

%Visualise original similarity matrix
figure(1);
im1 = imagesc(S)      % create heatmap of similarity
title('S - Original')
colorbar        % add color bar to visualisation


A = S;
A(A < 0) = 0;   % replace negative values with zero

%     c.Finally, remove the elements from A that correspond to loop edges in 
%     the visual similarity graph. (1 mark)

[rows, columns] = size(A);  %count rows and columns in matrix

for i = 1:1:rows        %Count through matrix setting diagonals to zero
    A(i,i) = 0;
    %i = i + 1;  %increment counter
end

% Visualise result
figure(2);
im2 = imagesc(A)
title('A - Remove negative elements and diagonals')
colorbar        % add color bar to visualisation


%     d.Use A to create the hyperlink matrix H. (0.5 marks)
H = normalize(A,2,'norm',1);

%     e.Form the random jump matrix J. (0.5 marks)
%           J = hyperlink matrix corresponding to a jump on a random page1/n
J(1:rows,1:columns) = 1/rows;

%   f.Given a damping factor of ? = 0.85, create the modified visual 
%     hyperlink matrix Htilde. (0.5 marks)

d = 0.85;
Htilde = d*H + (1-d)*J;

% Visualise result
figure(3);
im3 = imagesc(Htilde)
title('Htilde')
colorbar        % add color bar to visualisation

%     g.Find the VisualRank vector r using an initial vector. (3 marks)
% Vn+1 = Vn * Htilde
%Create seed vector
%Htilde4 = Htilde(1:4,1:4)
V0 = zeros(1,columns)
V0(1) = 1
V = V0 * Htilde     %V(1:rows)

for n = 1:1:49  % produce a matrix 50x1400        
    n
    V(n+1,:) = V(n,:) * Htilde;
    %i = i + 1;  %increment counter
end

% Visualise result
figure(4);
im3 = imagesc(V)
title('V')
colorbar        % add color bar to visualisation

r = V(50,:);

%     h.Given this VisualRank vector, 
%     which image is ranked highest? Display this image. (1 mark)
[M,I] = max(r)  % highest rank [Value, Index]
[N,J] = min(r)  % lowest rank [Value, Index]
filenames(I)    % highest ranked filename
filenames(J)    % lowest ranked filename
rankhigh = "" + fullfile('MPEG7',filenames(I))



% 2.Rank the 20 heart-shaped images (indices 81 through 100) using VisualRank.
%   a.Make a smaller 20x20 adjacency matrix by indexing the necessary rows 
%   andcolumns of the full adjacency matrix from above. (1 mark)
A20 = A(81:100,81:100)

  lowest =  imshow(rankhigh);
    
    print("Lowest ranked image" & rankhigh)


%   c.Given this ranking, which heart-shaped image is most representative of 
%   thegroup of heart-shaped images? Display this image. (1 mark)


%   d.Similarly, which heart-shaped image is the least heart-shaped 
%   (according to VisualRank)? Also display this image. (1 mark)

