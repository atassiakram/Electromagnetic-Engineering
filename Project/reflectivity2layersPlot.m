function  reflectivity2layersPlot()
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
    lambda_freespace_initial = 400;
    reflectivity_data = zeros(1001);

    for x=1:1001
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
        reflectivity_data(x) = reflectivity_current*100; %convert to percentage
    end
    lambda_freespace = 400:1400;
    plot(lambda_freespace,reflectivity_data);
    title('Reflectivity Spectrum as a Function of Wavelength in Free Space');
    xlabel('Wavelength in Free Space (nm)');
    ylabel('Reflectivity (%)');


