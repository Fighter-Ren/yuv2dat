close all;
clear
fid = fopen('Johnny_1280x720_60.yuv','r');
fid2 = fopen('Johnny_300.dat','w');

%------------------ size para 
row=1280;col=720;
frames = 300;
%----------------------

Y = zeros(row,col);
%UV = zeros(row/2,col);

U = zeros(row/2,col/2);
V = zeros(row/2,col/2);


UU= zeros(row,col);
VV= zeros(row,col);

%{
for frame = 1:frames

    [Y(:,:),count]  = fread(fid,[row,col],'uchar');
    [U(:,:),count1] = fread(fid,[row/2,col/2],'uchar');
    [V(:,:),count2] = fread(fid,[row/2,col/2],'uchar');

    for width = 1:col
        for height= 1:row
            mb_y = Y(height,width);
            test_dec = mb_y;
            test_hex = lower(dec2hex(mb_y));
                    %s = char(test_hex);
            len = length(test_hex);
            if len ~= 2
                test_hex = ['0',test_hex];
            end
              %fprintf(fid2,'%s',lower(dec2hex(mb_y(r,c))));
            fprintf(fid2,'%s',test_hex);
        end
    end

     for width = 1:col/2
        for height = 1:row/2
            mb_u = U(height,width);
   
            test_u = lower(dec2hex(mb_u));
       
                    %s = char(test_hex);
            len_u = length(test_u);
          
            if len_u ~= 2
                test_u = ['0',test_u];
            end
             
         
              %fprintf(fid2,'%s',lower(dec2hex(mb_y(r,c))));
            fprintf(fid2,'%s',test_u);
            
        end
    end
	
	
     for width = 1:col/2
        for height = 1:row/2
           
            mb_v = V(height,width);
         
            test_v = lower(dec2hex(mb_v));
                    %s = char(test_hex);
         
             len_v = length(test_v);
          
             if len_v ~= 2
                test_v = ['0',test_v];
            end
              %fprintf(fid2,'%s',lower(dec2hex(mb_y(r,c))));
         
             fprintf(fid2,'%s',test_v);
        end
    end
 end 
%}
%{
for  frame = 1:frames
    
    [Y(:,:),count]  = fread(fid,[row,col],'uchar');
    [U(:,:),count1] = fread(fid,[row/2,col/2],'uchar');
    [V(:,:),count2] = fread(fid,[row/2,col/2],'uchar');
    
    for col_mb_c = 1:col/16
        for row_mb_c = 1:row/16
            mb_y = Y(row_mb_c * 16 - 15:row_mb_c*16,col_mb_c * 16 - 15:col_mb_c*16)';

            %w_mb_y = lower(dec2hex(mb_y));
            for r = 1:16 
                for c = 1:16
                    test_dec = mb_y(r,c);
                   
                   
                    %fprintf(fid2,'%s',lower(dec2hex(mb_y(r,c))));
                    fprintf(fid2,'%c', test_dec);
%                     if mod(c,4) == 0
%                         fprintf(fid2,'\r\n');
%                     end
                end
            end

            mb_u = U(row_mb_c * 8 - 7:row_mb_c*8,col_mb_c * 8 - 7:col_mb_c*8)';
            mb_v = V(row_mb_c * 8 - 7:row_mb_c*8,col_mb_c * 8 - 7:col_mb_c*8)';

            for r = 1:8 
                for c = 1:8
                    test_u = mb_u(r,c);
                    test_v = mb_v(r,c);
                  
                    fprintf(fid2,'%s',test_u);
                    fprintf(fid2,'%s',test_v);

%                     if mod(c,2) == 0
%                         fprintf(fid2,'\r\n');
%                     end
                end
            end

        end

    end
end
%}

for  frame = 1:frames
    
    [Y(:,:),count]  = fread(fid,[row,col],'uchar');
    [U(:,:),count1] = fread(fid,[row/2,col/2],'uchar');
    [V(:,:),count2] = fread(fid,[row/2,col/2],'uchar');
    
    for col_mb_c = 1:col/16
        for row_mb_c = 1:row/16
            mb_y = Y(row_mb_c * 16 - 15:row_mb_c*16,col_mb_c * 16 - 15:col_mb_c*16)';

            %w_mb_y = lower(dec2hex(mb_y));
            for r = 1:16 
                for c = 1:16
                    test_dec = mb_y(r,c);
                    test_hex = lower(dec2hex(mb_y(r,c)));
                    %s = char(test_hex);
                    len = length(test_hex);
                    if len ~= 2
                        test_hex = ['0',test_hex];
                    end
                    %fprintf(fid2,'%s',lower(dec2hex(mb_y(r,c))));
                    fprintf(fid2,'%s',test_hex);
%                     if mod(c,4) == 0
%                         fprintf(fid2,'\r\n');
%                     end
                end
            end

            mb_u = U(row_mb_c * 8 - 7:row_mb_c*8,col_mb_c * 8 - 7:col_mb_c*8)';
            mb_v = V(row_mb_c * 8 - 7:row_mb_c*8,col_mb_c * 8 - 7:col_mb_c*8)';

            for r = 1:8 
                for c = 1:8
                    test_u = lower(dec2hex(mb_u(r,c)));
                    test_v = lower(dec2hex(mb_v(r,c)));
                    len_u = length(test_u);
                    len_v = length(test_v);
                    if len_u ~= 2
						test_u = ['0',test_u];
				    end
					if len_v ~= 2
						test_v = ['0',test_v];
					end
                    fprintf(fid2,'%s',test_u);
                    fprintf(fid2,'%s',test_v);

%                     if mod(c,2) == 0
%                         fprintf(fid2,'\r\n');
%                     end
                end
            end

        end

    end
end


%{
test = dec2hex(Y);
ltest = lower(test);

test2 = lower(dec2hex(UV));

for r = 1:row * col / 2
    for c = 1:2
        fprintf(fid2,'%s',ltest(r,c));
    end
    if mod(r,4) == 0
        fprintf(fid2,'\n');
    end
end
%}

%{
UU = blkproc(U,[1,1],'x.*P1',ones(2,2));
VV = blkproc(V,[1,1],'x.*P1',ones(2,2));

R = Y + 1.140 * (VV-128 );
G = Y + 0.395 * (UU-128 ) - 0.581 *(VV-128);
B = Y + 2.032 *(UU-128);

R=R/255;G=G/255;B=B/255;
images(:,:,1)=R(:,:)';
images(:,:,2)=G(:,:)';
images(:,:,3)=B(:,:)';
figure,imshow(images)
%}

