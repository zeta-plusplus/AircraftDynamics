# -*- coding: utf-8 -*-
"""--------------------------------------------------------------------------------
description:
    
--------------------------------------------------------------------------------"""
'''----------------------------------------------------------------------
load modules
----------------------------------------------------------------------'''
import csv
import os
import time
import tkinter as tk
import tkinter.ttk as ttk
import tkinter.font as font
import pathlib
import math
import numpy

'''--------------------
declare/instantiation/initialization
--------------------'''
#-----
global simTime
global vel
global alt
global theta
global phi
global phi_deg
global theta_deg
global psi_deg
global vs
#-----
global simTime_prev
global dmy_prev
global alt_prev
global phi_prev
global theta_prev
global psi_prev
global alpha_prev
global beta_prev
global Z_dot_prev
global vel_prev
#-----
global d_simTime
global d_dmy
global d_alt
global d_phi
global d_theta
global d_psi
global d_alpha
global d_beta
global d_Z_dot
global d_vel
#-----
global flagInit


'''----------------------------------------------------------------------
main script (directory operation, define script-global objects)
----------------------------------------------------------------------'''
print('')
print('********** pyPFD01.py **********')
scriptFilePath= os.path.dirname(os.path.abspath(__file__))
print('script file path: '+ str(scriptFilePath))
print('')

os.chdir(scriptFilePath)
print('current directory: '+os.getcwd())
print('')

pathParent1= pathlib.Path('../')
absPathParent1= pathParent1.resolve()
print('pathParent1: '+str(absPathParent1))
print('')

dataFileDir= str(absPathParent1) + '\dataTemp'
print('dataFileDir: ' + str(dataFileDir))
print('')

fileName="currentFlightStates00.csv"
fullPathDataFile= str(dataFileDir) + "\\" + fileName
print('fullPathDataFile: ' + str(fullPathDataFile))
print('exist data file: ' + str( os.path.exists(fullPathDataFile) ))
print('')

flagInit=True

'''--------------------
setting about time handling
--------------------'''
''''''
timeBegin=time.time()
timeLim=10000000
tInterval=30    #[ms]


'''--------------------
setting about gui
--------------------'''
''''''
rootframe= tk.Tk()  # main gui window

rootframe.geometry("1200x1000")

# table display gui
treeview=ttk.Treeview(rootframe)
treeview["show"]= "headings"
treeview["columns"]=(1,2)
treeview.heading(1, text="variable")
treeview.heading(2, text="value")
treeview.pack()

height_PFD=900
width_PFD=800
lenUnitPitch=500
canvasPFD = tk.Canvas(rootframe, bg = "white", height=height_PFD, width=width_PFD)
canvasPFD.pack()
canvasDatTbl= tk.Canvas(rootframe, bg="white", height=900, width=400)

#-----------
simTime_prev= 0.0
dmy_prev= 0.0
alt_prev= 0.0
phi_prev= 0.0
theta_prev= 0.0
psi_prev= 0.0
alpha_prev= 0.0
beta_prev= 0.0
Z_dot_prev= 0.0
vel_prev= 0.0

simTime= 0.0
dmy= 0.0
alt= 0.0
phi= 0.0
theta= 0.0
psi= 0.0
alpha= 0.0
beta= 0.0
Z_dot= 0.0
vel= 0.0

d_simTime= 0.0
d_dmy= 0.0
d_alt= 0.0
d_phi= 0.0
d_theta= 0.0
d_psi= 0.0
d_alpha= 0.0
d_beta= 0.0
d_Z_dot= 0.0
d_vel= 0.0

phi_deg= 0.0
theta_deg= 0.0
psi_deg= 0.0
vs= 0.0

'''----------------------------------------------------------------------
define sub-routines
----------------------------------------------------------------------'''
''''''
def readcsv(fileFullPath):
    
    # open and read simulation data csv
    if(os.path.exists(fileFullPath)==True):
        with open(fileFullPath, mode='r') as dataFile:
            reader = csv.reader(dataFile)
            #print(str(reader))
            
            i=0
            nCol=0
            dataMatrix=[]
            for row in reader:
                #print(str(row))
                #print(str(len(row)))
                if(len(row)==2)and(row[0]!='')and(row[1]!=''):
                    dataMatrix.append(row)
                    i=i+1
                    nCol= len(row)
                #***** end if *****
            #***** end for *****
            
        #***** end with *****
        dataFile.close()
    else:
        print('error: data file does not exit')
    #***** end if *****
    
    nRow=i
    
    return dataMatrix, nRow, nCol
#***** end def *****


'''---------------------------------------------------------'''
''''''
def disp_CenterCross(xCtr=width_PFD/2,yCtr=height_PFD/2, width=200, height=100, linewidth=2.0):
    r1_1= numpy.array([xCtr-1/2*width, yCtr])
    r1_2= numpy.array([xCtr+1/2*width, yCtr])
    
    r2_1= numpy.array([xCtr, yCtr-1/2*height])
    r2_2= numpy.array([xCtr, yCtr+1/2*height])
    
    canvasPFD.create_line(r1_1[0],r1_1[1], r1_2[0],r1_2[1], width=linewidth)
    canvasPFD.create_line(r2_1[0],r2_1[1], r2_2[0],r2_2[1], width=linewidth)
    
#***** end def *****


'''---------------------------------------------------------'''
''''''
def disp_lineLevel(phi, theta, xCtr=width_PFD/2,yCtr=height_PFD/2, xOfst=0, yOfst=0, length=2*width_PFD, 
                   linewidth=1.5, tag=""):
    r1= numpy.array([xCtr-1/2*length+xOfst, yCtr+yOfst])
    r2= numpy.array([xCtr+1/2*length+xOfst, yCtr+yOfst])
    r1pri= r1
    r2pri= r2
    
    Rtheta=numpy.array([[math.cos(-1.0*phi), -1.0*math.sin(-1.0*phi)],
                     [math.sin(-1.0*phi), math.cos(-1.0*phi)]])
    
    r1pri= r1
    r2pri= r2
    
    r1pri= r1+ numpy.array([0, theta*lenUnitPitch])
    r2pri= r2+ numpy.array([0, theta*lenUnitPitch])
    
    r1pri= r1pri + numpy.array([-xCtr, -yCtr])
    r2pri= r2pri + numpy.array([-xCtr, -yCtr])
    
    r1pri= numpy.dot(Rtheta, r1pri)
    r2pri= numpy.dot(Rtheta, r2pri)
    
    r1pri= r1pri + numpy.array([xCtr, yCtr])
    r2pri= r2pri + numpy.array([xCtr, yCtr])
    
    canvasPFD.create_line(r1pri[0],r1pri[1], r2pri[0],r2pri[1], width=linewidth, tag=tag)
#***** end def *****


'''---------------------------------------------------------'''
''''''
def disp_rectBackground(phi, theta, xCtr=width_PFD/2,yCtr=height_PFD/2, 
                xOfst=0, yOfst=45*math.pi/180*lenUnitPitch, 
                width=2*width_PFD, height=90*math.pi/180*lenUnitPitch, 
                fill="white", tag=""):
    r1= numpy.array([xCtr-1/2*width+xOfst, yCtr-1/2*height+yOfst])
    r2= numpy.array([xCtr-1/2*width+xOfst, yCtr+1/2*height+yOfst])
    r3= numpy.array([xCtr+1/2*width+xOfst, yCtr+1/2*height+yOfst])
    r4= numpy.array([xCtr+1/2*width+xOfst, yCtr-1/2*height+yOfst])
    r1pri= r1
    r2pri= r2
    r3pri= r3
    r4pri= r4
    
    Rtheta=numpy.array([[math.cos(-1.0*phi), -1.0*math.sin(-1.0*phi)],
                     [math.sin(-1.0*phi), math.cos(-1.0*phi)]])
    
    r1pri= r1pri+ numpy.array([0, theta*lenUnitPitch])
    r2pri= r2pri+ numpy.array([0, theta*lenUnitPitch])
    r3pri= r3pri+ numpy.array([0, theta*lenUnitPitch])
    r4pri= r4pri+ numpy.array([0, theta*lenUnitPitch])
    
    r1pri= r1pri + numpy.array([-xCtr, -yCtr])
    r2pri= r2pri + numpy.array([-xCtr, -yCtr])
    r3pri= r3pri + numpy.array([-xCtr, -yCtr])
    r4pri= r4pri + numpy.array([-xCtr, -yCtr])
    
    r1pri= numpy.dot(Rtheta, r1pri)
    r2pri= numpy.dot(Rtheta, r2pri)
    r3pri= numpy.dot(Rtheta, r3pri)
    r4pri= numpy.dot(Rtheta, r4pri)
    
    r1pri= r1pri + numpy.array([xCtr, yCtr])
    r2pri= r2pri + numpy.array([xCtr, yCtr])
    r3pri= r3pri + numpy.array([xCtr, yCtr])
    r4pri= r4pri + numpy.array([xCtr, yCtr])
    
    canvasPFD.create_polygon(
        r1pri[0], r1pri[1],
        r2pri[0], r2pri[1],
        r3pri[0], r3pri[1],
        r4pri[0], r4pri[1],
        fill=fill,
        tag=tag)
#***** end def *****


'''---------------------------------------------------------'''
''''''
def disp_Vvector(alpha, beta, lenUnitAngle=lenUnitPitch, radius=20, 
                 xCtr=width_PFD/2, yCtr=height_PFD/2, wingSpan=40, VSheight=15, lineWidth=2.0, 
                 tagFslg="", tagLW="", tagRW="", tagVS=""):
    ctr= numpy.array([xCtr+beta*lenUnitAngle, yCtr+alpha*lenUnitAngle])
    r0= numpy.array([ctr[0]-radius, ctr[1]-radius])
    r1= numpy.array([ctr[0]+radius, ctr[1]+radius])
    
    r0_lw= numpy.array([ctr[0]-radius-1.0/2.0*wingSpan, ctr[1]])
    r1_lw= numpy.array([ctr[0]-radius, ctr[1]])
    r0_rw= numpy.array([ctr[0]+radius, ctr[1]])
    r1_rw= numpy.array([ctr[0]+radius+1.0/2.0*wingSpan, ctr[1]])
    r0_vs= numpy.array([ctr[0], ctr[1]-radius-VSheight])
    r1_vs= numpy.array([ctr[0], ctr[1]-radius])
    
    canvasPFD.create_oval(r0[0], r0[1], r1[0], r1[1], width=lineWidth, tag=tagFslg)
    canvasPFD.create_line(r0_lw[0],r0_lw[1], r1_lw[0],r1_lw[1], width=lineWidth, tag=tagLW)
    canvasPFD.create_line(r0_rw[0],r0_rw[1], r1_rw[0],r1_rw[1], width=lineWidth, tag=tagRW)
    canvasPFD.create_line(r0_vs[0],r0_vs[1], r1_vs[0],r1_vs[1], width=lineWidth, tag=tagVS)
#***** end def *****


'''---------------------------------------------------------'''
''''''
def disp_value(val, x=10, y=height_PFD/2, fontsize=18):
    font_val= font.Font(size=fontsize)
    label_val = tk.Label(text=val, font=font_val)
    label_val.place(x=x, y=y)
#***** end def *****


'''-----------------------------------------------------------------------------'''
'''-----------------------------------------------------------------------------'''
''''''
def mainroutine(flagInit, simTime_prev, alt_prev, \
                phi_prev, theta_prev, psi_prev, \
                alpha_prev, beta_prev, Z_dot_prev, vel_prev, \
                d_simTime, d_alt, \
                d_phi, d_theta, d_psi, \
                d_alpha, d_beta, d_Z_dot, d_vel):
    #--------------------
    timeRunning= time.time() - timeBegin
    
    #-----
    if(os.path.exists(fullPathDataFile)==True):
        # ----- read data csv
        [dataMatrix, nRow, nCol]= readcsv(fileFullPath=fullPathDataFile)
        cols_dataMatrix= [len(v) for v in dataMatrix]
        
        if(nRow==17):
            i=0
            
            if(cols_dataMatrix[i]==2):
                simTime= float(dataMatrix[i][1])
            else:
                simTime= simTime_prev + d_simTime*tInterval
            #***** end if *****
            i=i+1
            
            if(cols_dataMatrix[i]==2):
                vel= float(dataMatrix[i][1])
            else:
                vel= vel_prev + d_vel*tInterval
            #***** end if *****
            i=i+1
            
            if(cols_dataMatrix[i]==2):
                alt= float(dataMatrix[i][1])
            else:
                alt= alt_prev + d_alt*tInterval
            #***** end if *****
            i=i+1
            
            if(cols_dataMatrix[i]==2):
                phi= float(dataMatrix[i][1])
            else:
                phi= phi_prev + d_phi*tInterval
            #***** end if *****
            i=i+1
            
            if(cols_dataMatrix[i]==2):
                theta= float(dataMatrix[i][1])
            else:
                theta= theta_prev + d_theta*tInterval
            #***** end if *****
            i=i+1
            
            if(cols_dataMatrix[i]==2):
                psi= float(dataMatrix[i][1])
            else:
                psi= psi_prev + d_psi*tInterval
            #***** end if *****
            i=i+1
            
            if(cols_dataMatrix[i]==2):
                alpha= float(dataMatrix[i][1])
            else:
                alpha= alpha_prev + d_alpha*tInterval
            #***** end if *****
            i=i+1
            
            if(cols_dataMatrix[i]==2):
                beta= float(dataMatrix[i][1])
            else:
                beta= beta_prev + d_beta*tInterval
            #***** end if *****
            i=i+1
            
            if(cols_dataMatrix[i]==2):
                Z_dot= float(dataMatrix[i][1])
            else:
                Z_dot= Z_dot_prev + d_Z_dot*tInterval
            #***** end if *****
            i=i+1
            
            d_simTime=(simTime-simTime_prev)/tInterval
            d_alt= (alt-alt_prev)/tInterval
            d_phi= (phi-phi_prev)/tInterval
            d_theta= (theta-theta_prev)/tInterval
            d_psi= (psi-psi_prev)/tInterval
            d_alpha= (alpha-alpha_prev)/tInterval
            d_beta= (beta-beta_prev)/tInterval
            d_Z_dot= (Z_dot-Z_dot_prev)/tInterval
            d_vel= (vel-vel_prev)/tInterval
            
        else:
            if(flagInit==False):
                simTime= simTime_prev + d_simTime*tInterval
                alt= alt_prev + d_alt*tInterval
                phi= phi_prev + d_phi*tInterval
                theta= theta_prev + d_theta*tInterval
                psi= psi_prev + d_psi*tInterval
                alpha= alpha_prev + d_alpha*tInterval
                beta= beta_prev + d_beta*tInterval
                Z_dot= Z_dot_prev + d_Z_dot*tInterval
                vel= vel_prev + d_vel*tInterval
            else:
                simTime= simTime_prev
                alt= alt_prev
                phi= phi_prev
                theta= theta_prev
                psi= psi_prev
                alpha= alpha_prev
                beta= beta_prev
                Z_dot= Z_dot_prev
                vel= vel_prev
            #***** end if *****
        #***** end if *****
        
        if(flagInit==True):
            flagInit=False
        #***** end if *****
        
        phi_deg= phi*180.0/math.pi
        theta_deg= theta*180.0/math.pi
        psi_deg= psi*180.0/math.pi
        vs= -1.0*Z_dot
        
        # -------------------- delete items displayed on window --------------------
        for i in range(9):
            tag_temp= str((i+1.0)*10) + "deg-pitch"
            canvasPFD.delete(tag_temp)
            
            tag_temp= str((i+1.0)*(-10)) + "deg-pitch"
            canvasPFD.delete(tag_temp)
        #----- end for -----
        
        canvasPFD.delete("0deg-pitch")
        canvasPFD.delete(("Vvector_Fslg"))
        canvasPFD.delete(("Vvector_LW"))
        canvasPFD.delete(("Vvector_RW"))
        canvasPFD.delete(("Vvector_VS"))
        
        # -------------------- re-display --------------------
        disp_rectBackground(phi, theta, fill="chocolate1", tag="ground")
        disp_rectBackground(phi, theta, yOfst=-45*math.pi/180*lenUnitPitch, fill="cyan", tag="sky")
        disp_lineLevel(phi=phi, theta=theta, linewidth=2.0, tag="0deg-pitch")    # 0-deg-pitch
        
        k=0.3
        for i in range(9):
            yOfst_temp= (i+1.0)*(-10)*math.pi/180*lenUnitPitch
            tag_temp= str((i+1.0)*10) + "deg-pitch"
            disp_lineLevel(phi=phi, theta=theta, xCtr=width_PFD/2, yCtr=height_PFD/2, xOfst=0, yOfst=yOfst_temp, length=k*width_PFD, tag=tag_temp)    # 10s-deg-pitch
            
            yOfst_temp= (i+1.0)*(10)*math.pi/180*lenUnitPitch
            tag_temp= str((i+1.0)*(-10)) + "deg-pitch"
            disp_lineLevel(phi=phi, theta=theta, xCtr=width_PFD/2, yCtr=height_PFD/2, xOfst=0, yOfst=yOfst_temp, length=k*width_PFD, tag=tag_temp)    # -10s-deg-pitch
        #----- end for -----
        
        disp_CenterCross()
        disp_value(val= "bank: "+str(round(phi_deg,2)), x=1/2*width_PFD-20, y=10, fontsize=16)     # display bank angle
        disp_value(val= "pitch: "+str(round(theta_deg,2)), x=1/2*width_PFD-20, y=40, fontsize=16)     # display pitch angle
        
        disp_value(val= "Heading", x=1/2*width_PFD-50, y=height_PFD-110)     # label heading angle
        disp_value(val= str(round(psi_deg)), x=1/2*width_PFD-30, y=height_PFD-80)     # display heading angle
        
        disp_value(val= str(round(vel))+" m/s", x=80)   # display velocity
        disp_value(val= str(round(alt))+" m", x=1/2*width_PFD+220)     # display altitude
        disp_value(val= str(round(vs))+" m/s", x=1/2*width_PFD+280, y=height_PFD/2+40)     # vertical speed
        
        disp_Vvector(alpha=alpha, beta=beta, 
                     tagFslg="Vvector_Fslg", tagLW="Vvector_LW", tagRW="Vvector_RW", tagVS="Vvector_VS")
        
        disp_value(val= "Sim time: "+str(round(simTime,2)), 
                   x=1/2*width_PFD-70, y=height_PFD-40, fontsize=12)     # 
        disp_value(val= "time after begin: "+str(round(timeRunning,2)), 
                   x=1/2*width_PFD-90, y=height_PFD-20, fontsize=12)     # 
        
    else:
        print("failed to open file")
    #***** end if *****
    
    simTime_prev= simTime
    vel_prev= vel
    alt_prev= alt
    phi_prev= phi
    theta_prev= theta
    psi_prev= psi
    alpha_prev= alpha
    beta_prev= beta
    Z_dot_prev= Z_dot
    
    # ----- command of recursive call, with specific time interval
    rootframe.after(tInterval, mainroutine, \
                    flagInit, simTime_prev, alt_prev, \
                    phi_prev, theta_prev, psi_prev, \
                    alpha_prev, beta_prev, Z_dot_prev, vel_prev, \
                    d_simTime, d_alt, \
                    d_phi, d_theta, d_psi, \
                    d_alpha, d_beta, d_Z_dot, d_vel)
    #-----
    
    return flagInit, simTime_prev, alt_prev, \
        phi_prev, theta_prev, psi_prev, \
        alpha_prev, beta_prev, Z_dot_prev, vel_prev, \
        d_simTime, d_alt, \
        d_phi, d_theta, d_psi, \
        d_alpha, d_beta, d_Z_dot, d_vel
    ''''''
#***** end def *****


'''---------------------------------------------------------'''
''''''
def initialize(flagInit, simTime_prev, alt_prev, \
            phi_prev, theta_prev, psi_prev, \
            alpha_prev, beta_prev, Z_dot_prev, vel_prev):
    
    flagInit=True
    simTime= 0.0
    alt= 0.0
    phi= 0.0
    theta= 0.0
    psi= 0.0
    alpha= 0.0
    beta= 0.0
    Z_dot= 0.0
    vel= 0.0
    
    simTime_prev= simTime
    alt_prev= alt
    phi_prev= phi
    theta_prev= theta
    psi_prev= psi
    alpha_prev= alpha
    beta_prev= beta
    Z_dot_prev= Z_dot
    vel_prev= vel
    
    return flagInit, simTime_prev, alt_prev, \
        phi_prev, theta_prev, psi_prev, \
        alpha_prev, beta_prev, Z_dot_prev, vel_prev
    ''''''
#***** end def *****


'''----------------------------------------------------------------------
main script
----------------------------------------------------------------------'''
# ---------- read data csv
[dataMatrix, nRow, nCol]= readcsv(fileFullPath=fullPathDataFile)
[flagInit, simTime_prev, alt_prev, phi_prev, theta_prev, psi_prev, alpha_prev, beta_prev, Z_dot_prev, vel_prev] \
    = initialize(flagInit, simTime_prev, alt_prev, phi_prev, theta_prev, psi_prev, alpha_prev, beta_prev, Z_dot_prev, vel_prev)

# ----- generate canvas
canvasPFD.place(x=0, y=0)
canvasDatTbl.place(x=800, y=0)

# ---------- call routine of display & update, with specific time interval
rootframe.after(tInterval, mainroutine, \
                flagInit, simTime_prev, alt_prev, \
                phi_prev, theta_prev, psi_prev, \
                alpha_prev, beta_prev, Z_dot_prev, vel_prev, \
                d_simTime, d_alt, \
                d_phi, d_theta, d_psi, \
                d_alpha, d_beta, d_Z_dot, d_vel)

# ---------- continue display & update of csv data until window is closed
rootframe.mainloop()

print('********** End of pyConsole02.py **********')
print('')
