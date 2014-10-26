function [J, grad] = costFunction(theta, X, y)
%COSTFUNCTION Compute cost and gradient for logistic regression
%   J = COSTFUNCTION(theta, X, y) computes the cost of using theta as the
%   parameter for logistic regression and the gradient of the cost
%   w.r.t. to the parameters.

% Initialize some useful values
m = length(y); % number of training examples

% You need to return the following variables correctly
J = 0;
grad = zeros(size(theta));

% ====================== YOUR CODE HERE ======================
% Instructions: Compute the cost of a particular choice of theta.
%               You should set J to the cost.
%               Compute the partial derivatives and set grad to the partial
%               derivatives of the cost w.r.t. each parameter in theta
%
% Note: grad should have the same dimensions as theta
%

n_theta = length(theta);

% calculate J

n_cases = size(X, 1);
J = 0;
for iter_case = 1:n_cases
    J = J - y(iter_case) * log(sigmoid(X(iter_case,:) * theta)) - (1 - y(iter_case)) * log(1 - sigmoid(X(iter_case,:) * theta));
end
J = J / n_cases;


% calculate grad
temp = zeros(n_theta, 1);

for iter_feature = 1:n_theta
    temp(iter_feature) = (sigmoid(X * theta) - y)' * X(:, iter_feature) / m;
end

grad = temp;







% =============================================================

end
