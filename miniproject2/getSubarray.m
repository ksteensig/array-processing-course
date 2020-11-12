function [idx_array] = getSubarray(N_row, N_column, L1, L2, spacing)
%getSubarray gives you the index of the subarray of size L1 and L2 with
%respect to N_row and N_column. 

if nargin<5
  spacing = 1;
  idx_column = 1:spacing:N_row;
  idx_row = 1:spacing:N_column;
else
  idx_column = 1:spacing:N_row;
  idx_row = 1:spacing:N_column;
end

if(length(idx_column)<L1) || (length(idx_row)<L2)
  error('Problem in finding the subarray');
else
  idx_column = idx_column(1:L1);
  idx_row = idx_row(1:L2);
end


idx_array = zeros(L1*L2,1);

idx_array = [];
for il2 = 1:L2
  idx_array(1+(il2-1)*L1:il2*L1) = idx_column + N_row*(il2-1)*spacing;
end

end

