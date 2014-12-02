function idx = findClosestCentroids(X, centroids)
%FINDCLOSESTCENTROIDS computes the centroid memberships for every example
%   idx = FINDCLOSESTCENTROIDS (X, centroids) returns the closest centroids
%   in idx for a dataset X where each row is a single example. idx = m x 1
%   vector of centroid assignments (i.e. each entry in range [1..K])
%

% Set K
K = size(centroids, 1);

% You need to return the following variables correctly.
idx = zeros(size(X,1), 1);

% ====================== YOUR CODE HERE ======================
% Instructions: Go over every example, find its closest centroid, and store
%               the index inside idx at the appropriate location.
%               Concretely, idx(i) should contain the index of the centroid
%               closest to example i. Hence, it should be a value in the
%               range 1..K
%
% Note: You can use a for-loop over the examples to compute this.
%
m = size(X, 1);
for x_iter = 1:m
    x_cur = X(x_iter, :);

    idx_cur = 1;
    dist = sum((x_cur - centroids(1,:)) .* (x_cur - centroids(1,:)));

    for c_iter = 2:K
        dist_more = sum((x_cur - centroids(c_iter,:)) .* (x_cur - centroids(c_iter,:)));
        if dist_more < dist
            idx_cur = c_iter;
            dist = dist_more;
        end
    end

    idx(x_iter) = idx_cur;

end







% =============================================================

end

