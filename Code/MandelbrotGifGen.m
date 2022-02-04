%imageless render of gif
%Laura Rintoul
%14.8.19

clc
clear all
PointDef = input("Define the point of focus: ");
ZoomSpec = 60;
MandelbrotLoopN = 50;
res = 256;

gifname = strcat("MandelbrotAnimated",string(PointDef),".gif");
%Generates one frame for every ZoomSpec
for zoom = 1:ZoomSpec
    %% range generation based on zoom value
    %Generates centre of focus as a function of ZoomSpec
    zoomcentre = zoompointexp(PointDef,ZoomSpec);
    %Generates range of values with distance from zoomcentre based on zoom
    realRange = linspace((real(zoomcentre)+2)*(1-1.25^(1-zoom))-2,(real(zoomcentre)-2)*(1-1.25^(1-zoom))+2,res);
    imRange = linspace((imag(zoomcentre)+2)*(1-1.25^(1-zoom))-2,(imag(zoomcentre)-2)*(1-1.25^(1-zoom))+2,res);
    %% takes range specified and generates a bitmap matrix of it
    MandData = zeros(256,256);
    realN = 1;
    for r = realRange
        imN = 1;
        for im = imRange
            if mandelbrotcheckn(r + im*i,MandelbrotLoopN) == true
                MandData(imN,realN) = 1;
            end
            imN = imN + 1;
        end
        realN = realN + 1;
    end
    %Add data of MandData to gif
    if zoom == 1
        imwrite(MandData*255,[0 0 0; 1 1 1],gifname,'LoopCount',Inf,'DelayTime',0.1);
    else
        imwrite(MandData*255,[0 0 0; 1 1 1],gifname,'WriteMode','append','DelayTime',0.1);
    end
end

%function for if a number is in the mandelbrot set
function [inset] = mandelbrotcheckn(z,n)

x = 0;
for i = 1:n
    if (real(x)^2+imag(x)^2)^(1/2) > 4
        inset = false;
        break
    end
    x = x^2 + z;
    inset = true;
end
end
%Function for generating exponentially decaying sequence
function [zpoint] = zoompointexp(z,ratio)

zpoint = z*(1-1.25^(1-ratio));
end