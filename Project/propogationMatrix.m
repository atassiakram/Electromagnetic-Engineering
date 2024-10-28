function matrix = propogationMatrix(n_medium,lambda_center,lambda_freespace)
    lambda_material = lambda_center/n_medium;
    d = lambda_material/4;
    delta = 2*pi*n_medium*d/lambda_freespace;

    matrix = [exp(j*delta), 0; 0,exp(-j*delta)];
end