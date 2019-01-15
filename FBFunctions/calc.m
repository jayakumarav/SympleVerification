function c = calc(a)
a = uint32(a);
c = double(0);
i = -24;
while(i<0)
    c = c + double(bitand(a,1)) * double(2^i);
      a = bitsrl(a,1); 
      i = i+1;
end




