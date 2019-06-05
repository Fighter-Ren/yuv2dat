clear 

fid = fopen('tennis_1080p_15.dat','r');

row=1072;col=1920;

mb_y = zeros(16,16);
mb_u = zeros(8,8);
mb_v = zeros(8,8);

y = zeros(row,col);
u = zeros(row,col);
v = zeros(row,col);

write_u = zeros(row/2,col/2);
write_v = zeros(row/2,col/2);

mb_expand_u = zeros(16,16);
mb_expand_v = zeros(16,16);

outfid=fopen('tennis_1080p_10.yuv','wb');

frames = 10;

for  frame = 1:frames
    for r_c = 1:row/16
        for c_c = 1:col/16
            for r=1:32
                for c = 1:2
                    [s , count] = fread(fid,[1,8],'char');
                    [tmp , count] = fread(fid,[1,2],'char');
                    char_s = char(s);
                    for index = 1:4
                        mb_y(ceil(r/2.0), mod(r-1,2)*8+(c-1)*4+index) = hex2dec(char_s(index*2-1:index*2));
                    end
                end
            end
            %{
            for r=1:8
                for c = 1:2
                    [s , count] = fread(fid,[1,8],'char');
                    [tmp , count] = fread(fid,[1,2],'char');
                    char_s = char(s);
                    for index = 1:4
                        mb_u(ceil(r), (c-1)*4+index) = hex2dec(char_s(index*2-1:index*2));
                    end
                end
            end

            for r=1:8
                for c = 1:2
                    [s , count] = fread(fid,[1,8],'char');
                    [tmp , count] = fread(fid,[1,2],'char');
                    char_s = char(s);
                    for index = 1:4
                        mb_v(ceil(r), (c-1)*4+index) = hex2dec(char_s(index*2-1:index*2));
                    end
                end
            end
            %}
            
            for r = 1:8
                for c = 1:4
                    [s , count] = fread(fid,[1,8],'char');
                    [tmp , count] = fread(fid,[1,2],'char');
                    char_s = char(s);
                    for index = 1:4
                        if mod(index,2) == 1
                            mb_u(ceil(r), (c-1)*2+ceil(index/2.0)) = hex2dec(char_s(index*2-1:index*2));
                        end
                        if mod(index,2) == 0
                            mb_v(ceil(r), (c-1)*2+ceil(index/2.0)) = hex2dec(char_s(index*2-1:index*2));
                        end
                    end
                end
            end
            write_u(r_c*8-7:r_c*8,c_c*8-7:c_c*8) = mb_u;
            write_v(r_c*8-7:r_c*8,c_c*8-7:c_c*8) = mb_v;

            mb_expand_u = blkproc(mb_u,[1,1],'x.*P1',ones(2,2));
            mb_expand_v = blkproc(mb_v,[1,1],'x.*P1',ones(2,2));

            y(r_c*16-15:r_c*16,c_c*16-15:c_c*16) = mb_y;
            u(r_c*16-15:r_c*16,c_c*16-15:c_c*16) = mb_expand_u;
            v(r_c*16-15:r_c*16,c_c*16-15:c_c*16) = mb_expand_v;

        end
    end
    
    %%{
    write_y = uint8(y);
    write_u = uint8(write_u);
    write_v = uint8(write_v);
    
    for tmp_i = 1: 1072
        fwrite(outfid,write_y(tmp_i,:),'uint8');
    end
    
    for tmp_i = 1:536
        fwrite(outfid,write_u(tmp_i,:),'uint8');
    end
    
    for tmp_i = 1: 536
        fwrite(outfid,write_v(tmp_i,:),'uint8');
    end
    
    %}
    
    %%{ 
    %output RBG image 
    
    R = y + 1.140 * (v-128 );
    G = y + 0.395 * (u-128 ) - 0.581 *(v-128);
    B = y + 2.032 *(u-128);
    
    
    for i=1:16
        for j=1:16
            if R(i,j )<0
                R(i,j )=0;
            end
            if R(i,j )>255
                R(i,j )=255;
            end
            if G(i,j )<0
                G(i,j )=0;
            end
            if G(i,j )>255
                G(i,j )=255;
            end
            if B(i,j )<0
                B(i,j )=0;
            end  
            if B(i,j )>255
                B(i,j )=255;
            end
        end
    end
    R=R/255;G=G/255;B=B/255;

    images(:,:,1)=R(:,: );
    images(:,:,2)=G(:,: );
    images(:,:,3)=B(:,: );
    %figure;
    %imshow(images);
    imwrite(images,['pic_qcif',num2str(frame), '.jpg']);
    %}
    
end

