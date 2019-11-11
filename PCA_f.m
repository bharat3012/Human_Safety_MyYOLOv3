folderN = uigetdir();
images = dir('*.jpg');

for i = 1:length(images)
    
    A = imread([folderN,'\',images(i).name]);

    if ~exist([folderN,'\data_f11\'],'dir')
        mkdir([folderN,'\data_f11\']);
    end
    
    if ~exist([folderN,'\data_f12\'],'dir')
        mkdir([folderN,'\data_f12\']);
    end
    
    if ~exist([folderN,'\data_f13\'],'dir')
        mkdir([folderN,'\data_f13\']);
    end
    
    if ~exist([folderN,'\data_f14\'],'dir')
        mkdir([folderN,'\data_f14\']);
    end
    
    
    
    A = rgb2gray(A);
    A = im2double(A);
    T = graythresh(A);
    A = im2bw(A,T);
    [r c] = find(A == 1);
    %r = bsxfun(@minus,r,mean(r));
    %c = bsxfun(@minus,c,mean(c));
    P = [r c];
    Sp = cov(P);
    [U D] = eig(Sp);

    U1 = U(:,1);
    U2 = U(:,2);
    
%     v1 = [-1;0];
%     v2 = [0;1];
    Y = U' * P';
    e = Y(1,:);
    f = Y(2,:);
    Sy = cov(Y');
    [V I] = eig(Sy);
    v1 = V(:,1);
    v2 = V(:,2);



    scale = 10;
    figure, plot(r,c,'g.');
    hold on
    quiver(0,0,U1(1,1), U1(2,1),'r');
    plot([U1(1,1)*-scale, U1(1,1)*scale],[U1(2,1)*-scale, U1(2,1)*scale],'r');
    quiver(0,0,U2(1,1),U2(2,1),'b');
    plot([U2(1,1)*-scale*2, U2(1,1)*scale*2],[U2(2,1)*-scale*2, U2(2,1)*scale*2],'b');
    quiver(0,0,v2(1,1),v2(2,1),'k');
    axis([-250 250 -250 250]);
    hold off

        
    
    x1 = v1(1,1);
    y1 = v1(2,1);
    x2 = v2(1,1);
    y2 = v2(2,1);
    x3 = U2(1,1);
    y3 = U2(2,1);
    a = atan2d((x1*y3)-(y1*x3),(x1*x3)+(y1*y3));
    b = atan2d((x2*y3)-(y2*x3),(x2*x3)+(y2*y3));

    A = imread([folderN,'\',images(i).name]);
    B1 = imrotate(A,-a);
   % B1 = imresize(B1,[28 28]);
    B2 = imrotate(A,180-a);
   % B2 = imresize(B2,[28 28]);
    B3 = imrotate(A,-b);
    B4 = imrotate(A,180-b);

%     imwrite(B1,fullfile([folderN,'\data_f11\',images(i).name]));
%     imwrite(B2,fullfile([folderN,'\data_f12\',images(i).name]));
%     imwrite(B3,fullfile([folderN,'\data_f13\',images(i).name]));
%     imwrite(B4,fullfile([folderN,'\data_f14\',images(i).name]));

end

        
          
