function theta = adiff(theta1,theta2)

cost=cosd(theta1).*cosd(theta2)+sind(theta1).*sind(theta2);

theta=acos(cost);

end