function W=adjacency(edges,weights,N)
%Function W=adjacency(edges,weights,N) computes the weighted 
%   adjacency matrix of a point and edge set.  For an unweighted 
%   matrix, set weights equal to ones(1,M) where M is the number 
%   of edges in the graph.  
%
%Inputs:    edges - A Mx2 list of M edges indexing into points
%           weights - The weights used to determine matrix values.  
%               If not specified, uses vector of all ones
%           N - Optional number of nodes in the graph.  Used if
%               N > max(edges) (i.e., isolated nodes are present)
%
%Outputs:   W - Adjacency matrix
%
%
%Note: Adjacency matrix is not of the Seidel type 
%   (i.e. all values are positive)
%If weights are not specified, use unity weighting
if nargin == 1
    weights=ones(size(edges,1),1);
end

%If N is not specified, use maximum values of edges
if nargin < 3
    N=max(max(edges));
end

%Build sparse adjacency matrix
W=sparse([edges(:,1);edges(:,2)],[edges(:,2);edges(:,1)], ...
    [weights;weights],N,N);
