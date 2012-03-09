function [ cm ] = CreateAndTestCBR( tnx, tny, ttx, tty)
%CreateAndTestCBR Creates a CBR system, trains it, runs tests on 
%it and returns a CM

    %Train a CBR system
    cbr = CBRinit(tnx, tny);
    
    %Generate CM for this fold
    cm = examples2CM(cbr, ttx, tty);

end

