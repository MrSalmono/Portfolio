# -*- coding: utf-8 -*-
"""
Created on Mon Dec 18 10:24:14 2017

@author: salmon
"""

import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
import Tkinter as tk


#Position_Y_du_Lune=0
print ("Les distances sont en mètre, les temps en secondes, les vitesse en m/s et les masses en kg")
print ("M=5.97*10**24, Ml=7.35*10**22, Mm=tres variable ; dT=5.5, dl=3.3, dm=(chondrite=3.5)variable ")
#paramètre
dT=float(input('Densite_Terre='))
dm=float(input('Densite_Meteorite='))
dl=float(input('Densite_Lune='))
dt=int(20)
tmax=float(input('durée de la simulation='))
N=int(tmax/dt)
G=6.67*10**-11
M=5.97*10**24
Ml=float(input('Masse_de_la_Lune='))
Mm=float(input('Masse_du_Meteore='))
R_T=((M/((4.0/3.0)*np.pi*dT))**(1.0/3.0))/10.0
print 'Rayon_de_la_Terre=',R_T
Boum=R_T
R_L=((Ml/((4.0/3.0)*np.pi*dl))**(1.0/3.0))/10.0
print 'Rayon_de_la_Lune=',R_L
R_M=((Mm/((4.0/3.0)*np.pi*dm))**(1.0/3.0))/10.0
print 'Rayon_du_Meteore=',R_M
BOUM=R_T+R_L
Boom=R_T+R_M
Boume=R_L+R_M
print 'N=',N

#vecteur météorite :
t=np.linspace(0,tmax,N)
    #position
Xm=np.zeros(N)
Ym=np.zeros(N)
Zm=np.zeros(N)
    #vitesse :
Vxm=np.zeros(N)
Vym=np.zeros(N)
Vzm=np.zeros(N)
#vecteur Lune :
    #position :
Xl=np.zeros(N)
Yl=np.zeros(N)
Zl=np.zeros(N)
    #vitesse :
Vxl=np.zeros(N)
Vyl=np.zeros(N)
Vzl=np.zeros(N)
#vecteur pour la Terre
theta=np.linspace(0.0,2.0*np.pi,N-1)
#position 
Xt=np.zeros(N)
Yt=np.zeros(N)
Zt=np.zeros(N)
#vitesse
Vxt=np.zeros(N)
Vyt=np.zeros(N)
Vzt=np.zeros(N)
#print 't=',t
#vecteur distance terre-météorite :
Rmt=np.zeros(N)
#vecteur distance metéorite lune :
Rml=np.zeros(N)
#vecteur distance terre-Lune
Rlt=np.zeros(N)

#première valeur de chaques vecteurs Terre 
Vxt[0]=0
Vyt[0]=0
Vzt[0]=0
Xt[0]=0
Yt[0]=0
Zt[0]=0
#première valeur de chaques vecteurs météorite
#F=tk.Tk()
Vxm[0]=float(input('Composante_X_du_vecteur_vitesse_Meteore='))
Vym[0]=float(input('Composante_Y_du_vecteur_vitesse_Meteore='))
Vzm[0]=float(input('Composante_Z_du_vecteur_vitesse_Meteore='))
Xm[0]=float(input('Position_X_du_Meteore='))
Ym[0]=float(input('Position_Y_du_Meteore='))
Zm[0]=float(input('Position_Z_du_Meteore='))
#première valeure de chaques vecteurs Lune
Vxl[0]=float(input('Composante_X_du_vecteur_vitesse_Lune='))
Vyl[0]=float(input('Composante_Y_du_vecteur_vitesse_Lune='))
Vzl[0]=float(input('Composante_Z_du_vecteur_vitesse_Lune='))
Xl[0]=float(input('Position_X_du_Lune='))
Yl[0]=float(input('Position_Y_du_Lune='))
Zl[0]=float(input('Position_Z_du_Lune='))
#F.mainloop()
#première valeur du vecteur Rmt : 
Rmt[0]=(((Xm[0]-Xt[0])**2+(Ym[0]-Yt[0])**2)+(Zm[0]-Zt[0])**2)**(1.0/2.0)
Rml[0]=(((Xl[0]-Xm[0])**2+(Yl[0]-Ym[0])**2)+(Zl[0]-Zm[0])**2)**(1.0/2.0)
Rlt[0]=(((Xl[0]-Xt[0])**2+(Yl[0]-Yt[0])**2)+(Zl[0]-Zt[0])**2)**(1.0/2.0)


#coordonné du cercle (terre) 
xT=np.cos(theta)*R_T
yT=np.sin(theta)*R_T
Ny=np.size(yT)
#print xT
print 'Ny=',Ny

for i in range(0,int(N-1),1):
    #Trajectoire de la Terre + vecteurs vitesses
    Vxt[i+1]= ( (Xt[i]-Xm[i]) *-G*Mm / ( (((Xm[i]-Xt[i])**2+(Ym[i]-Yt[i])**2)+(Zm[i]-Zt[i])**2)**(3.0/2.0) ) + ( (Xt[i]-Xl[i])*-G*Ml / ( (((Xl[i]-Xt[i])**2+(Yl[i]-Yt[i])**2)+(Zl[i]-Zt[i])**2)**(3.0/2.0) )) ) *dt+Vxt[i]
    Vyt[i+1]= ( (Yt[i]-Ym[i]) *-G*Mm / ( (((Xm[i]-Xt[i])**2+(Ym[i]-Yt[i])**2)+(Zm[i]-Zt[i])**2)**(3.0/2.0) ) + ( (Yt[i]-Yl[i])*-G*Ml / ( (((Xl[i]-Xt[i])**2+(Yl[i]-Yt[i])**2)+(Zl[i]-Zt[i])**2)**(3.0/2.0) )) ) *dt+Vyt[i]
    Vzt[i+1]= ( (Zt[i]-Zm[i]) *-G*Mm / ( (((Xm[i]-Xt[i])**2+(Ym[i]-Yt[i])**2)+(Zm[i]-Zt[i])**2)**(3.0/2.0) ) + ( (Zt[i]-Zl[i])*-G*Ml / ( (((Xl[i]-Xt[i])**2+(Yl[i]-Yt[i])**2)+(Zl[i]-Zt[i])**2)**(3.0/2.0) )) ) *dt+Vzt[i]
    Xt[i+1]=Vxt[i]*dt+Xt[i]
    Yt[i+1]=Vyt[i]*dt+Yt[i]
    Zt[i+1]=Vzt[i]*dt+Zt[i]
    #trajectoire de la Lune + vecteur vitesse
    Vxl[i+1]= ( -G*M* (Xl[i]-Xt[i]) / ( (((Xl[i]-Xt[i])**2+(Yl[i]-Yt[i])**2)+(Zl[i]-Zt[i])**2)**(3.0/2.0) ) + ( (Xl[i]-Xm[i])*-G*Mm / ( (((Xm[i]-Xl[i])**2+(Ym[i]-Yl[i])**2)+(Zm[i]-Zl[i])**2)**(3.0/2.0) )) ) *dt+Vxl[i]
    Vyl[i+1]= ( -G*M* (Yl[i]-Yt[i]) / ( (((Xl[i]-Xt[i])**2+(Yl[i]-Yt[i])**2)+(Zl[i]-Zt[i])**2)**(3.0/2.0) ) + ( (Yl[i]-Ym[i])*-G*Mm / ( (((Xm[i]-Xl[i])**2+(Ym[i]-Yl[i])**2)+(Zm[i]-Zl[i])**2)**(3.0/2.0) )) ) *dt+Vyl[i]
    Vzl[i+1]= ( (Zl[i]-Zt[i]) *-G*M / ( (((Xl[i]-Xt[i])**2+(Yl[i]-Yt[i])**2)+(Zl[i]-Zt[i])**2)**(3.0/2.0) ) + ( (Zl[i]-Zm[i])*-G*Mm / ( (((Xm[i]-Xl[i])**2+(Ym[i]-Yl[i])**2)+(Zm[i]-Zl[i])**2)**(3.0/2.0) )) ) *dt+Vzl[i]
    Xl[i+1]=Vxl[i]*dt+Xl[i]
    Yl[i+1]=Vyl[i]*dt+Yl[i]
    Zl[i+1]=Vzl[i]*dt+Zl[i]
    #trajectoire du météore + vecteur vitesse 
    Vxm[i+1]= ( -G*M* (Xm[i]-Xt[i]) / ( (((Xm[i]-Xt[i])**2+(Ym[i]-Yt[i])**2)+(Zm[i]-Zt[i])**2)**(3.0/2.0) ) + ( (Xm[i]-Xl[i])*-G*Ml / ( (((Xm[i]-Xl[i])**2+(Ym[i]-Yl[i])**2)+(Zm[i]-Zl[i])**2)**(3.0/2.0) )) ) *dt+Vxm[i]
    Vym[i+1]= ( -G*M* (Ym[i]-Yt[i]) / ( (((Xm[i]-Xt[i])**2+(Ym[i]-Yt[i])**2)+(Zm[i]-Zt[i])**2)**(3.0/2.0) ) + ( (Ym[i]-Yl[i])*-G*Ml / ( (((Xm[i]-Xl[i])**2+(Ym[i]-Yl[i])**2)+(Zm[i]-Zl[i])**2)**(3.0/2.0) )) ) *dt+Vym[i]
    Vzm[i+1]= ( -G*M* (Zm[i]-Zt[i]) / ( (((Xm[i]-Xt[i])**2+(Ym[i]-Yt[i])**2)+(Zm[i]-Zt[i])**2)**(3.0/2.0) ) + ( (Zm[i]-Zl[i])*-G*Ml / ( (((Xm[i]-Xl[i])**2+(Ym[i]-Yl[i])**2)+(Zm[i]-Zl[i])**2)**(3.0/2.0) )) ) *dt+Vzm[i]
    Xm[i+1]=Vxm[i]*dt+Xm[i]
    Ym[i+1]=Vym[i]*dt+Ym[i]
    Zm[i+1]=Vzm[i]*dt+Zm[i]
    #rayon
    Rmt[i+1]=(((Xm[i]-Xt[i])**2+(Ym[i]-Yt[i])**2)+(Zm[i]-Zt[i])**2)**(1.0/2.0)
    Rml[i+1]=(((Xm[i]-Xl[i])**2+(Ym[i]-Yl[i])**2)+(Zm[i]-Zl[i])**2)**(1.0/2.0)
    Rlt[i+1]=(((Xl[i]-Xt[i])**2+(Yl[i]-Yt[i])**2)+(Zl[i]-Zt[i])**2)**(1.0/2.0)
    #print Vx[i]
    #print Vyl[i]    
    #XY=([Xm[i],Ym[i]])
    #print XY
    #crash du meteore sur la terre
    if Rmt[i]<=Boom:
        #f=tk.Tk()
        print 'Meteore_crash_t=',t[i],'s'
        print 'Meteore_crash_X=',Xm[i],'m'
        print 'Meteore_crash_Y=',Ym[i],'m'
        print 'Meteore_crash_Z=',Zm[i],'m'
        print 'Rmt=',Rmt[i],'m'
        break
        #f.mainloop()
    #crash du meteore sur la lune    
    if Rml[i]<=Boume:
        #f1=tk.Tk()
        print 'meteore_crash_t=',t[i],'s'
        print 'meteore_crash_X=',Xm[i],'m'
        print 'meteore_crash_Y=',Ym[i],'m'
        print 'meteore_crash_Z=',Zm[i],'m'
        print 'Rml=',Rml[i],"m"
        break
        #f1.mainloop
    #crash de la lune sur la terre
    if Rlt[i]<=BOUM:
        #f2=tk.Tk()
        print 'Lune_crash_t=',t[i],'s'
        print 'Lune_crash_X=',Xl[i],'m'
        print 'Lune_crash_Y=',Yl[i],'m'
        print 'Lune_crash_Z=',Zl[i],'m'
        print 'Rlt=',Rlt,'m'
        #f2.mainloop
        break

#NBoum=np.size(Boum)
#print 'NBoum=',NBoum   
#print 'Boum=',Boum
#NXY=np.size(XY)
#print NXY
#print XY 

#F=tk.Tk()
fig=plt.figure() 
ax=fig.gca(projection='3d')     
ax.plot(Xl,Yl,Zl,label="trajectoire lune")
ax.plot(Xm,Ym,Zm,label="trajectoire meteorite")
ax.plot(xT,yT,label="Terre")
ax.plot(Xt,Yt,Zt,label="trajectoire Terre")
#plt.legend()
plt.xlabel('distance (en m)')
plt.ylabel('distance (en m)')
plt.title('Diagramme de la trajectoire d un meteorite a prox de la Terre et la Lune')
plt.show()
ax.axis([-10.0*10**8,10.0*10**8,-1.0*10**9,1.0*10**9])
ax.set_zlim(-10**9,10**9)
#F.mainloop()