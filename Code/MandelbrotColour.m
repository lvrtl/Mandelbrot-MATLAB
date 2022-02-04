%function for if a number is in the mandelbrot set
%generates RGB based on rate of escape
function [RGB] = MandelbrotColour(z,n)

x = 0;
for i = 1:n
    if (real(x)^2+imag(x)^2)^(1/2) > 4
        RGB = [hex2bin(];
        break
    end
    x = x^2 + z;
    inset = true;
end
end