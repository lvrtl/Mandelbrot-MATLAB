%Modified ColourTesting for observing range of iteration values for better
%understanding of range used
%Laura Rintoul
%18.8.19
clc
clear all
PointDef = input("Define the point of focus: ");
ZoomSpec = 60;
MandelbrotLoopN = 48;
res = 256;
colourset = importdata('OutputColours.txt');

gifname = strcat("MandelbrotAnimated",string(PointDef),".gif");
%Generates one frame for every ZoomSpec
for zoom = 30
    %% range generation based on zoom value
    %Generates centre of focus as a function of ZoomSpec
    zoomcentre = zoompointexp(PointDef,ZoomSpec);
    %Generates range of values with distance from zoomcentre based on zoom
    realRange = linspace((real(zoomcentre)+2)*(1-1.25^(1-zoom))-2,(real(zoomcentre)-2)*(1-1.25^(1-zoom))+2,res);
    imRange = linspace((imag(zoomcentre)+2)*(1-1.25^(1-zoom))-2,(imag(zoomcentre)-2)*(1-1.25^(1-zoom))+2,res);
    %% takes range specified and generates a bitmap matrix of it
    %MandData = zeros(256,256);
    realN = 1;
    for r = realRange
        imN = 1;
        for im = imRange
            MandData(imN,realN) = MandelbrotColour(r+im*1i,MandelbrotLoopN,colourset);
            imN = imN + 1;
        end
        realN = realN + 1;
    end
end

%Function for generating exponentially decaying sequence
function [zpoint] = zoompointexp(z,ratio)

zpoint = z*(1-1.25^(1-ratio));
end

%function for if a number is in the mandelbrot set
%generates RGB based on rate of escape
function [loopc] = MandelbrotColour(z,n,colourset)

    x = 0;
    for int = 1:n
        if (real(x)^2+imag(x)^2)^(1/2) > 4
            loopc = int;
            break
        end
        x = x^2 + z;
        loopc = 0;
    end
end