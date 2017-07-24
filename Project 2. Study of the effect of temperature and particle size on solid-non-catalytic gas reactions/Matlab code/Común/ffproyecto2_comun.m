function dr=ffproyecto2_comun(t,r)
global Ca dmolb R kg De k b

R1=r^2/(R^2*kg); %siendo kg el coeficiente de transf de mat asociado a la dif_ext
R2=(R-r)*r/(R*De); 
R3=1/k;
dr=-b*Ca/dmolb/(R1+R2+R3); %siendo R1 R2 y R3 las resistencias y b el coef que va delante del sólido