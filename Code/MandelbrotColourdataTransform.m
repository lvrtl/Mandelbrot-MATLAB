%Program to Import data from Colour Set and expand to all 50
%Laura Rintoul
%16.9.19
ColourSetSpectral = (importdata('ColourSet2.txt'));
ColourSetProc = zeros(14,3);
%raw data is hex; 1 byte transparency + 3 bytes colour.
%want to isolate colour and convert to decimal
for i = 1:13
    %This is the only elegant way of splitting strings as matlab is the
    %worst (credit to https://stackoverflow.com/users/1336150/eitan-t)
    temp = regexp(string(ColourSetSpectral(i)), '\w{1,2}', 'match');
    ColourSetProc(i,:) = [hex2dec(temp(1:2)),hex2dec(temp(3:4)),hex2dec(temp(5:6))];
end

n=4;
%expand the colour set to fit 
for i = 1:13    
    DiffColour = ColourSetProc(i+1,:) - ColourSetProc(i,:);
    for col = 1:n
        if col == 1 && i == 1
            OutputColours = ColourSetProc(i,:);%initialises the expanded set
        else
            OutputColours = cat(1,OutputColours,ColourSetProc(i,:)+DiffColour/n*(col-1));
        end
    end
end
save('OutputColours2.txt','OutputColours','-ascii')