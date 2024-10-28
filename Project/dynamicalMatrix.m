function matrixOutput = dynamicalMatrix(n_before,n_after)
    reflectionC = reflectionCoefficient(n_before,n_after);
    transmissionC = transmissionCoefficient(n_before,n_after);
    matrixOutput = 1/transmissionC*[1,reflectionC;reflectionC,1];
end