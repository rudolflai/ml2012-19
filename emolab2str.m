function a = emolab2str(b)
switch b
    case 1
          a = 'anger';
    case 2
        a = 'disgust';
    case 3
        a = 'fear';
    case 4
        a = 'happyness';
    case 5
        a = 'sadness';
    case 6
        a = 'surprise';
    case 7 
        a = 'neutral';
    otherwise
        error('Unknown emotion label: %d',b);
end