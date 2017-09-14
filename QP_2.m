clc; clear all;

b = zeros(3,2);
for ii = 1:2
    for jj = 1:3
        b(jj,ii) = input('Enter coordinate for boundaries [lb x,y,z; ub x,y,z]: ');
    end
end

y = zeros(3,1);
for ii = 1:3
    y(ii) = input('Enter coordinate for objective [x,y,z]: ');
end

H = 2*[1 0 0; 0 1 0; 0 0 1];
g = -2*y;
A = [1 0 0; 0 1 0;0 0 1];

[x,fval,exitflag,iter,lambda,auxOutput] = qpOASES(H,g,A,b(:,1),b(:,2),b(:,1),b(:,2))

delta = b(:,2)-b(:,1);
deltax = [delta(1);0;0];
deltay = [0;delta(2);0];
deltaz = [0;0;delta(3)];
c(:,1) = b(:,1);
c(:,2) = b(:,2);
c(:,3) = b(:,1) + deltax;
c(:,4) = b(:,1) + deltay;
c(:,5) = b(:,1) + deltaz;
c(:,6) = b(:,2) - deltax;
c(:,7) = b(:,2) - deltay;
c(:,8) = b(:,2) - deltaz;
ob = [y,x];
k = boundary(c(1,:).',c(2,:).',c(3,:).');
dv = y - x;
d = sqrt(dv(1)^2+dv(2)^2+dv(3)^2);

display(['Distance is: ' num2str(d)]);

figure(1)
plot3(c(1,:),c(2,:),c(3,:),'*','MarkerSize', 10)
hold on
plot3(y(1),y(2),y(3),'*','MarkerSize', 10)
hold on
plot3(ob(1,:),ob(2,:),ob(3,:));
hold on
trisurf(k,c(1,:),c(2,:),c(3,:),'Facecolor','red','FaceAlpha',0.1)
legend('Limit','Objective Coordinate');
xlabel('x');
ylabel('y');
zlabel('z');