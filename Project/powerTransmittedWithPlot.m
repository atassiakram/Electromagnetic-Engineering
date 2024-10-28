function powerTransmittedWithPlot(lambda_start,lambda_end)
    %initialize variables
    n0 = 1;
    n1 = 1.4;
    n2 = 2.62;
    n3 = 3.5;
    lambda_center = 650;

    %Reflection Coefficients
    RC01 = reflectionCoefficient(n0,n1);
    RC12 = reflectionCoefficient(n1,n2);
    RC23 = reflectionCoefficient(n2,n3);

    %Transmission Coefficients
    TC01 = transmissionCoefficient(n0,n1);
    TC12 = transmissionCoefficient(n1,n2);
    TC23 = transmissionCoefficient(n2,n3);

    %initialize data array
    lambda_freespace_initial = lambda_start;
    num_of_iterations = lambda_end-lambda_start+1;
    power_data = zeros(num_of_iterations);

    for x=1:num_of_iterations
        lambda_freespace = lambda_freespace_initial + x;
        %propogation matrices
        P1 = propogationMatrix(n1,lambda_center,lambda_freespace);
        P2 = propogationMatrix(n2,lambda_center,lambda_freespace);
        
        %dynamical matrices
        Q01 = dynamicalMatrix(n0,n1);
        Q12 = dynamicalMatrix(n1,n2);
        Q23 = dynamicalMatrix(n2,n3);
 
        T = Q01*P1*Q12*P2*Q23;

        reflectivity_current = (abs(T(2,1)/T(1,1)))^2; %get the reflectivity
        power_crnt = (1-reflectivity_current)*(6.16*10^15)/(lambda_freespace^5*(exp(2484/lambda_freespace)-1));
        power_data(x) = power_crnt;
        
        
    end
    lambda_freespace = lambda_start:lambda_end;
    plot(lambda_freespace,power_data);
    title('Reflectivity Spectrum as a Function of Wavelength in Free Space');
    xlabel('Wavelength in Free Space (nm)');
    ylabel('Power (W/m^2)');
    xlim([lambda_start lambda_end]);


