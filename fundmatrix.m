% FUNDMATRIX - computes fundamental matrix from 8 or more points
%
% Function computes the fundamental matrix from 8 or more matching points in
% a stereo pair of images.  The normalised 8 point algorithm given by
% Hartley and Zisserman p265 is used.  To achieve accurate results it is
% recommended that 12 or more points are used
%
% Usage:   [F, e1, e2] = fundmatrix(x1, x2)
%          [F, e1, e2] = fundmatrix(x)
%
% Arguments:
%          x1, x2 - Two sets of corresponding 3xN set of homogeneous
%          points.
%         
%          x      - If a single argument is supplied it is assumed that it
%                   is in the form x = [x1; x2]
% Returns:
%          F      - The 3x3 fundamental matrix such that x2'*F*x1 = 0.
%          e1     - The epipole in image 1 such that F*e1 = 0
%          e2     - The epipole in image 2 such that F'*e2 = 0
%

% Copyright (c) 2002-2005 Peter Kovesi
% School of Computer Science & Software Engineering
% The University of Western Australia
% http://www.csse.uwa.edu.au/
% 
% Permission is hereby granted, free of charge, to any person obtaining a copy
% of this software and associated documentation files (the "Software"), to deal
% in the Software without restriction, subject to the following conditions:
% 
% The above copyright notice and this permission notice shall be included in 
% all copies or substantial portions of the Software.
%
% The Software is provided "as is", without warranty of any kind.

% Feb 2002  - Original version.
% May 2003  - Tidied up and numerically improved.
% Feb 2004  - Single argument allowed to enable use with RANSAC.
% Mar 2005  - Epipole calculation added, 'economy' SVD used.
% Aug 2005  - Octave compatibility

function [F,e1,e2] = fundmatrix(x1,x2)
    
%     [x1, x2, npts] = checkargs(varargin(:));
%     Octave = exist('OCTAVE_VERSION', 'builtin') == 5; % Are we running under Octave
    
    % Normalise each set of points so that the origin 
    % is at centroid and mean distance from origin is sqrt(2). 
    % normalise2dpts also ensures the scale parameter is 1.
%     [x1, T1] = normalise2dpts(x1);
%     [x2, T2] = normalise2dpts(x2);
    npts = size(x1,2)
    % Build the constraint matrix.  Note that the line continuations are
    % required so that we build a matrix with 9 columns (not 3)
    A = [x2(1,:)'.*x1(1,:)'   x2(1,:)'.*x1(2,:)'  x2(1,:)' ...
         x2(2,:)'.*x1(1,:)'   x2(2,:)'.*x1(2,:)'  x2(2,:)' ...
         x1(1,:)'             x1(2,:)'            ones(npts,1) ];       

 
	[U,D,V] = svd(A,0); % Under MATLAB use the economy decomposition

    % Extract fundamental matrix from the column of V corresponding to
    % smallest singular value.
    F = reshape(V(:,9),3,3)';
    
    % Enforce constraint that fundamental matrix has rank 2 by performing
    % a svd and then reconstructing with the two largest singular values.
    [U,D,V] = svd(F,0);
    F = U*diag([D(1,1) D(2,2) 0])*V';
    
    % Denormalise
%     F = T2'*F*T1;
    
    if nargout == 3  	% Solve for epipoles
	[U,D,V] = svd(F,0);
	e1 = hnormalise(V(:,3));
	e2 = hnormalise(U(:,3));
    end
    
%--------------------------------------------------------------------------
% Function to check argument values and set defaults

function [x1, x2, npts] = checkargs(arg);
    
    if length(arg) == 2
        x1 = arg{1};
        x2 = arg{2};
        if ~all(size(x1)==size(x2))
            error('x1 and x2 must have the same size');
        elseif size(x1,1) ~= 3
            error('x1 and x2 must be 3xN');
        end
        
    elseif length(arg) == 1
        if size(arg{1},1) ~= 6
            error('Single argument x must be 6xN');
        else
            x1 = arg{1}(1:3,:);
            x2 = arg{1}(4:6,:);
        end
    else
        error('Wrong number of arguments supplied');
    end
      
    npts = size(x1,2);
    if npts < 8
        error('At least 8 points are needed to compute the fundamental matrix');
    end
    
    
    
% function [newpts, T] = normalise2dpts(pts)
% 
%     if size(pts,1) ~= 3
%         error('pts must be 3xN');
%     end
%     
%     % Find the indices of the points that are not at infinity
%     finiteind = find(abs(pts(3,:)) > eps);
%     
%     if length(finiteind) ~= size(pts,2)
%         warning('Some points are at infinity');
%     end
%     
%     % For the finite points ensure homogeneous coords have scale of 1
%     pts(1,finiteind) = pts(1,finiteind)./pts(3,finiteind);
%     pts(2,finiteind) = pts(2,finiteind)./pts(3,finiteind);
%     pts(3,finiteind) = 1;
%     
%     c = mean(pts(1:2,finiteind)')';            % Centroid of finite points
%     newp(1,finiteind) = pts(1,finiteind)-c(1); % Shift origin to centroid.
%     newp(2,finiteind) = pts(2,finiteind)-c(2);
%     
%     dist = sqrt(newp(1,finiteind).^2 + newp(2,finiteind).^2);
%     meandist = mean(dist(:));  % Ensure dist is a column vector for Octave 3.0.1
%     
%     scale = sqrt(2)/meandist;
%     
%     T = [scale   0   -scale*c(1)
%          0     scale -scale*c(2)
%          0       0      1      ];
%     
%     newpts = T*pts;


function nx = hnormalise(x)
    
    [rows,npts] = size(x);
    nx = x;

    % Find the indices of the points that are not at infinity
    finiteind = find(abs(x(rows,:)) > eps);

%    if length(finiteind) ~= npts
%        warning('Some points are at infinity');
%    end

    % Normalise points not at infinity
    for r = 1:rows-1
	nx(r,finiteind) = x(r,finiteind)./x(rows,finiteind);
    end
    nx(rows,finiteind) = 1;