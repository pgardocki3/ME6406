function [ im,D ] = ACC( sample,c1,c2,c3)
Gs =fspecial('gaussian',45,10);
DoG=fspecial('gaussian',45,1)-fspecial('gaussian',45,10);
R=(sample(:,:,1));
G=(sample(:,:,2));
B=(sample(:,:,3));
im=(sample);

for z=1:3
    if z==1
        i=c1;
    elseif z==2
        i=c2;
    elseif z==3
        i=c3;
    end
    if i==1
        R1=imfilter(R,DoG,'replicate')+imfilter(G,Gs,'replicate');
    end    
    if i==2      
        G1=imfilter(G,DoG,'replicate')+imfilter(2*G-R,Gs,'replicate');
    end
    if i==3    
        B1=imfilter(B,DoG,'replicate')+imfilter(B-(R-G),Gs,'replicate');
    end    
    if i=='a'   
        R1=imfilter(R,DoG,'replicate')+imfilter(B-G,Gs,'replicate');
    end    
    if i=='b'
        G1=imfilter(G,DoG,'replicate')+imfilter(B-R,Gs,'replicate');
    end    
    if i=='c'
        B1=imfilter(B,DoG,'replicate')+imfilter(2*B-(R+G),Gs,'replicate');
    end   
end  
  
D=round(sqrt((R1(1,1)-R1(1,size(R1,2)))^2+(G1(1,1)-G1(1,size(G1,2)))^2+(B1(1,1)-B1(1,size(B1,2)))^2));
im(:,:,1)=(R1);
im(:,:,2)=(G1);
im(:,:,3)=(B1);
im=(im);

end

