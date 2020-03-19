%%SVDCompress
%Reconstruct compressed matrices to colour image

% The SVD is truncated by taking Nretain singular values and outimage is 
% calculated by multiplying the retained components of the SVD: 
% outimage(:,:,colour_ind) = Uret*Sret*Vret'. Here Uret, etc are the retained 
% components of the original U, etc.

function outimage = SVDcompress(filename, Nretain)
    % The image is loaded in as an integer format. Convert to floating point
    % so SVD can be taken.
    pic = filename;
    pic = double(pic);
    % The loaded data is in the range from 0-255. Convert to the range 0-1.
    pic = pic / 255;

    %% Converting each colour channel to individual matrix
    % The loaded data is a 3-dimensional "matrix". The red, green and blue
    % components of the image are accessed with the last dimension.
    red = pic(:,:,1);
    green = pic(:,:,2);
    blue = pic(:,:,3);
    
    %Perform SVD on each colour channel
    [U,S,V] = svd(red);
    [Ub,Sb,Vb] = svd(blue);
    [Ug,Sg,Vg] = svd(green);

    %Red Channel
    U2 = U(:,1:Nretain);
    V2 = V(:,1:Nretain);
    S2 = S(1:Nretain,1:Nretain);
    red = U2*S2*V2';

    %Blue Channel
    Ub2 = Ub(:,1:Nretain);
    Vb2 = Vb(:,1:Nretain);
    Sb2 = Sb(1:Nretain,1:Nretain);
    blue = Ub2*Sb2*Vb2';
    
    %Green Channel
    Ug2 = Ug(:,1:Nretain);
    Vg2 = Vg(:,1:Nretain);
    Sg2 = Sg(1:Nretain,1:Nretain);
    green = Ug2*Sg2*Vg2';
    
    %Reconstruct compressed channels to image
    outimage = cat(3, red, green, blue);
    %Display image
    imshow(outimage);
    %Create filename as 'Nretain'.jpg e.g. 50.jpg
    fname = Nretain + ".jpg";
    %Write to image file
    imwrite(outimage,fname);
end