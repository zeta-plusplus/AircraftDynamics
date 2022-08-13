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
import copy


class flightStates:
    '''--------------------
    declare/instantiation/initialization
    --------------------'''
    time: float()
    #-----
    vel: float()
    theta: float()
    phi: float()
    psi: float()
    alpha: float()
    beta: float()
    u: float()
    v: float()
    w: float()
    X_dot: float()
    Y_dot: float()
    Z_dot: float()
    xEast: float()
    xNorth: float()
    alt: float()
    vs: float()
    #-----
    d_vel: float()
    d_theta: float()
    d_phi: float()
    d_psi: float()
    d_alpha: float()
    d_beta: float()
    d_u: float()
    d_v: float()
    d_w: float()
    d_X_dot: float()
    d_Y_dot: float()
    d_Z_dot: float()
    d_xEast: float()
    d_xNorth: float()
    d_alt: float()
    #-----
    phi_deg: float()
    theta_deg: float()
    psi_deg: float()
    alpha_deg: float()
    beta_deg: float()
    
    def __init__(self):
        self.time= 0.0
        #-----
        self.vel= 0.0
        self.theta= 0.0
        self.phi= 0.0
        self.psi= 0.0
        self.alpha= 0.0
        self.beta= 0.0
        self.u= 0.0
        self.v= 0.0
        self.w= 0.0
        self.X_dot= 0.0
        self.Y_dot= 0.0
        self.Z_dot= 0.0
        self.xEast= 0.0
        self.xEast= 0.0
        self.alt= 0.0
        self.vs= 0.0
        #-----
        self.d_vel= 0.0
        self.d_theta= 0.0
        self.d_phi= 0.0
        self.d_psi= 0.0
        self.d_alpha= 0.0
        self.d_beta= 0.0
        self.d_u= 0.0
        self.d_v= 0.0
        self.d_w= 0.0
        self.d_X_dot= 0.0
        self.d_Y_dot= 0.0
        self.d_Z_dot= 0.0
        self.d_xEast= 0.0
        self.d_xNorth= 0.0
        self.d_alt= 0.0
        self.d_vs= 0.0
        #-----
        self.phi_deg= 0.0
        self.theta_deg= 0.0
        self.psi_deg= 0.0
        self.alpha_deg= 0.0
        self.beta_deg= 0.0
    #********** end def **********
    
    def resetAttributes(self):
        self.time= 0.0
        #-----
        self.vel= 0.0
        self.theta= 0.0
        self.phi= 0.0
        self.psi= 0.0
        self.alpha= 0.0
        self.beta= 0.0
        self.u= 0.0
        self.v= 0.0
        self.w= 0.0
        self.X_dot= 0.0
        self.Y_dot= 0.0
        self.Z_dot= 0.0
        self.xEast= 0.0
        self.xEast= 0.0
        self.alt= 0.0
        self.vs= 0.0
        #-----
        self.d_vel= 0.0
        self.d_theta= 0.0
        self.d_phi= 0.0
        self.d_psi= 0.0
        self.d_alpha= 0.0
        self.d_beta= 0.0
        self.d_u= 0.0
        self.d_v= 0.0
        self.d_w= 0.0
        self.d_X_dot= 0.0
        self.d_Y_dot= 0.0
        self.d_Z_dot= 0.0
        self.d_xEast= 0.0
        self.d_xEast= 0.0
        self.d_alt= 0.0
        self.d_vs= 0.0
        #-----
        self.phi_deg= 0.0
        self.theta_deg= 0.0
        self.psi_deg= 0.0
        self.alpha_deg= 0.0
        self.beta_deg= 0.0
    #********** end def **********
#********** end class **********


'''--------------------
declare/instantiation/initialization
--------------------'''
fltState= flightStates()
fltStatePrev= flightStates()
fltStateSave= flightStates()
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
flagRead=False

'''--------------------
setting about time handling
--------------------'''
''''''
timeBegin=time.time()
timeLim=10000000
tIntervalRead= 20 #[ms]
tInterval=10    #[ms]

'''--------------------
setting about gui
--------------------'''
''''''
rootframe= tk.Tk()  # main gui window
#rootframe2= tk.Tk()  # main gui window

rootframe.geometry("1200x1000")
height_PFD=900
width_PFD=800
lenUnitPitch=500
canvasPFD = tk.Canvas(rootframe, bg = "white", height=height_PFD, width=width_PFD)
canvasPFD.pack()
canvasDatTbl= tk.Canvas(rootframe, bg="white", height=900, width=400)

# table display gui
'''
treeview=ttk.Treeview(rootframe2)
treeview["show"]= "headings"
treeview["columns"]=(1,2)
treeview.heading(1, text="variable")
treeview.heading(2, text="value")
treeview.pack()
'''

# ----- generate canvas
canvasPFD.place(x=0, y=0)
canvasDatTbl.place(x=800, y=0)

# ----- generate value labels
''''''
label_bank= tk.Label(text="bank: 0", font=font.Font(size=16)); label_bank.place(x=1/2*width_PFD-20, y=10)     # display bank angle
label_pitch= tk.Label(text="pitch: 0", font=font.Font(size=16)); label_pitch.place(x=1/2*width_PFD-20, y=40)     # display pitch angle

label_heading= tk.Label(text="0", font=font.Font(size=20)); label_heading.place(x=1/2*width_PFD-20, y=height_PFD-140)     # display heading angle

label_vel= tk.Label(text="0 m/s", font=font.Font(size=18)); label_vel.place(x=80, y=height_PFD/2)   # display velocity
label_alt= tk.Label(text="0 m", font=font.Font(size=18)); label_alt.place(x=1/2*width_PFD+220, y=height_PFD/2)     # display altitude
label_VS= tk.Label(text="0 m", font=font.Font(size=18)); label_VS.place(x=1/2*width_PFD+280, y=height_PFD/2+40)     # vertical speed

label_simTime= tk.Label(text="Sim Time: 0 s", font=font.Font(size=12)); label_simTime.place(x=0, y=height_PFD-40)     # simulation time
label_appTime= tk.Label(text="App Time: 0 s", font=font.Font(size=12)); label_appTime.place(x=0, y=height_PFD-20)     # simulation time


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
def disp_directionalGyro(psi, linewidth=1.5, tag="dirGyro"):
    radius= 1/4*width_PFD
    xCtr=1/2*width_PFD
    yCtr=height_PFD+30
    Rrot=[]
    r1=[]
    r2=[]
    r1pri=[]
    r2pri=[]
    tag_lines=["0deg", "45deg", "90deg", "135deg"]
    
    #----------
    canvasPFD.create_oval(xCtr-radius, yCtr-radius, \
                          xCtr+radius, yCtr+radius, \
                          width=linewidth, fill="gray80", tag=tag)
    
    canvasPFD.create_line(xCtr, yCtr-radius-20, xCtr, yCtr, width=linewidth+0.5, fill="Black", arrow=tk.FIRST)
        
    Rpsi= numpy.array([[math.cos(-1.0*psi), -1.0*math.sin(-1.0*psi)],
                     [math.sin(-1.0*psi), math.cos(-1.0*psi)]])
    
    Rrot.append(Rpsi)
    
    for i in range(3):
        Rrot.append(numpy.array([[math.cos(-1.0*psi-(i+1)*math.pi/4.0), -1.0*math.sin(-1.0*psi-(i+1)*math.pi/4.0)],
                     [math.sin(-1.0*psi-(i+1)*math.pi/4.0), math.cos(-1.0*psi-(i+1)*math.pi/4.0)]]))
    
    for i in range(4):
        r1.append(numpy.array([xCtr, yCtr-radius-5]))
        r2.append(numpy.array([xCtr, yCtr+radius+5]))
        
        r1pri=r1
        r2pri=r2
        
        r1pri[i]= r1pri[i] + numpy.array([-xCtr, -yCtr])
        r2pri[i]= r2pri[i] + numpy.array([-xCtr, -yCtr])
        
        r1pri[i]= numpy.dot(Rrot[i], r1pri[i])
        r2pri[i]= numpy.dot(Rrot[i], r2pri[i])
        
        r1pri[i]= r1pri[i] + numpy.array([xCtr, yCtr])
        r2pri[i]= r2pri[i] + numpy.array([xCtr, yCtr])
        
        canvasPFD.create_line(r1pri[i][0],r1pri[i][1], r2pri[i][0],r2pri[i][1], width=linewidth, tag=tag_lines[i], fill="gray25")
    #***** end for *****
#***** end def *****


'''---------------------------------------------------------'''
''''''
def disp_value(val, x=10, y=height_PFD/2, fontsize=18, tag=""):
    font_val= font.Font(size=fontsize)
    label_val = tk.Label(text=val, font=font_val)
    label_val.place(x=x, y=y)
#***** end def *****


'''---------------------------------------------------------'''
''''''


'''-----------------------------------------------------------------------------'''
'''-----------------------------------------------------------------------------'''
''''''
def updatePFD(flagInit, flagRead, \
                fltState: flightStates, fltStatePrev: flightStates, fltStateSave: flightStates):
    swPrintDbg=False
    #--------------------
    timeRunning= time.time() - timeBegin
    
    [flagInit, flagRead, fltState, fltStatePrev, fltStateSave] \
        =readFltStatesDat(flagInit, flagRead, timeRunning, tInterval, fltState, fltStatePrev, fltStateSave)
    #-----
    if(flagInit==True):
        flagInit=False
    #***** end if *****
    
    if(swPrintDbg==True):
        print(str(round(timeRunning,3))+": updatePFD: "+str(flagRead))
    #***** end if *****
    ''''''
    fltState.phi_deg= fltState.phi*180.0/math.pi
    fltState.theta_deg= fltState.theta*180.0/math.pi
    fltState.psi_deg= fltState.psi*180.0/math.pi
    fltState.vs= fltState.Z_dot
    
    # -------------------- delete items displayed on window --------------------
    for i in range(9):
        tag_temp= str((i+1.0)*10) + "deg-pitch"
        canvasPFD.delete(tag_temp)
        
        tag_temp= str((i+1.0)*(-10)) + "deg-pitch"
        canvasPFD.delete(tag_temp)
    #----- end for -----
    
    canvasPFD.delete("0deg-pitch")
    canvasPFD.delete("Vvector_Fslg")
    canvasPFD.delete("Vvector_LW")
    canvasPFD.delete("Vvector_RW")
    canvasPFD.delete("Vvector_VS")
    
    # -------------------- re-display --------------------
    disp_rectBackground(fltState.phi, fltState.theta, fill="chocolate1", tag="ground")
    disp_rectBackground(fltState.phi, fltState.theta, \
                        yOfst=-45*math.pi/180*lenUnitPitch, fill="cyan", tag="sky")
    disp_lineLevel(phi=fltState.phi, theta=fltState.theta, \
                   linewidth=2.0, tag="0deg-pitch")    # 0-deg-pitch
    
    k=0.3
    for i in range(9):
        yOfst_temp= (i+1.0)*(-10)*math.pi/180*lenUnitPitch
        tag_temp= str((i+1.0)*10) + "deg-pitch"
        disp_lineLevel(phi=fltState.phi, theta=fltState.theta, \
                       xCtr=width_PFD/2, yCtr=height_PFD/2, xOfst=0, yOfst=yOfst_temp, \
                           length=k*width_PFD, tag=tag_temp)    # 10s-deg-pitch
        
        yOfst_temp= (i+1.0)*(10)*math.pi/180*lenUnitPitch
        tag_temp= str((i+1.0)*(-10)) + "deg-pitch"
        disp_lineLevel(phi=fltState.phi, theta=fltState.theta, \
                       xCtr=width_PFD/2, yCtr=height_PFD/2, xOfst=0, yOfst=yOfst_temp, \
                           length=k*width_PFD, tag=tag_temp)    # -10s-deg-pitch
    #----- end for -----
    
    disp_CenterCross()
    disp_Vvector(alpha=fltState.alpha, beta=fltState.beta, 
                 tagFslg="Vvector_Fslg", tagLW="Vvector_LW", tagRW="Vvector_RW", tagVS="Vvector_VS")
    disp_directionalGyro(psi=fltState.psi)
    
    # update display values
    label_bank["text"]="bank: "+str(round(fltState.phi_deg,2))
    label_pitch["text"]="pitch: "+str(round(fltState.theta_deg,2))
    label_heading["text"]=str(round(fltState.psi_deg))
    
    label_vel["text"]=str(round(fltState.vel))+" m/s"
    label_alt["text"]=str(round(fltState.alt))+" m"
    label_VS["text"]=str(round(fltState.vs))+" m/s"
    
    label_simTime["text"]="Sim time: "+str(round(fltState.time,3))
    label_appTime["text"]="App time: "+str(round(timeRunning,3))
    
    fltStatePrev= copy.deepcopy(fltState)
    
    # ----- command of recursive call, with specific time interval
    rootframe.after(tInterval, updatePFD, \
                    flagInit, flagRead, 
                    fltState, fltStatePrev, fltStateSave)
    #-----
    
    return flagInit, flagRead, fltState, fltStatePrev, fltStateSave
    ''''''
#***** end def *****


'''---------------------------------------------------------'''
''''''
def readFltStatesDat(flagInit, flagRead, timeRunning, tInterval, \
                     fltState: flightStates(), fltStatePrev: flightStates(), fltStateSave: flightStates()):
    swPrintDbg=False
    
    #-----
    flagRead=False
    
    if(os.path.exists(fullPathDataFile)==True):
        # ----- read data csv
        [dataMatrix, nRow, nCol]= readcsv(fileFullPath=fullPathDataFile)
        cols_dataMatrix= [len(v) for v in dataMatrix]
        
        if(swPrintDbg==True):
            print("timeRunning="+str(round(timeRunning,3)))
            print("nRow="+str(nRow))
            print("nCol="+str(nCol))
            print(cols_dataMatrix)
        #***** end if *****
        
        flagReadDat=[False]*31
        i=0
        flagRead=True
        
        if(i<nRow)and(cols_dataMatrix[i]==2):
            fltState.time=float(dataMatrix[i][1])
            flagReadDat[i]=True
        else:
            fltState.time= fltStatePrev.time + tInterval
        #***** end if *****
        i=i+1
        
        if(i<nRow)and(cols_dataMatrix[i]==2):
            fltState.vel= float(dataMatrix[i][1])
            flagReadDat[i]=True
        else:
            #fltState.vel= fltStatePrev.vel + fltStatePrev.d_vel*tInterval
            fltState.vel= fltStatePrev.vel
        #***** end if *****
        i=i+1
        
        if(i<nRow)and(cols_dataMatrix[i]==2):
            fltState.alt= float(dataMatrix[i][1])
            flagReadDat[i]=True
        else:
            #fltState.alt= fltStatePrev.alt + fltStatePrev.d_alt*tInterval
            fltState.alt= fltStatePrev.alt
        #***** end if *****
        i=i+1
        
        if(i<nRow)and(cols_dataMatrix[i]==2):
            fltState.phi= float(dataMatrix[i][1])
            flagReadDat[i]=True
        else:
            #fltState.phi= fltStatePrev.phi + fltStatePrev.d_phi*tInterval
            fltState.phi= fltStatePrev.phi
        #***** end if *****
        i=i+1
        
        if(i<nRow)and(cols_dataMatrix[i]==2):
            fltState.theta= float(dataMatrix[i][1])
            flagReadDat[i]=True
        else:
            #fltState.theta= fltStatePrev.theta + fltStatePrev.d_theta*tInterval
            fltState.theta= fltStatePrev.theta
        #***** end if *****
        i=i+1
        
        if(i<nRow)and(cols_dataMatrix[i]==2):
            fltState.psi= float(dataMatrix[i][1])
            flagReadDat[i]=True
        else:
            #fltState.psi= fltStatePrev.psi + fltStatePrev.d_psi*tInterval
            fltState.psi= fltStatePrev.psi
        #***** end if *****
        i=i+1
        
        if(i<nRow)and(cols_dataMatrix[i]==2):
            fltState.alpha= float(dataMatrix[i][1])
            flagReadDat[i]=True
        else:
            #fltState.alpha= fltStatePrev.alpha + fltStatePrev.d_alpha*tInterval
            fltState.alpha= fltStatePrev.alpha
        #***** end if *****
        i=i+1
        
        if(i<nRow)and(cols_dataMatrix[i]==2):
            fltState.beta= float(dataMatrix[i][1])
            flagReadDat[i]=True
        else:
            #fltState.beta= fltStatePrev.beta + fltStatePrev.d_beta*tInterval
            fltState.beta= fltStatePrev.beta
        #***** end if *****
        i=i+1
        
        if(i<nRow)and(cols_dataMatrix[i]==2):
            fltState.u= float(dataMatrix[i][1])
            flagReadDat[i]=True
        else:
            #fltState.u= fltStatePrev.u + fltStatePrev.d_u*tInterval
            fltState.u= fltStatePrev.u
        #***** end if *****
        i=i+1
        
        if(i<nRow)and(cols_dataMatrix[i]==2):
            fltState.v= float(dataMatrix[i][1])
            flagReadDat[i]=True
        else:
            #fltState.v= fltStatePrev.v + fltStatePrev.d_v*tInterval
            fltState.v= fltStatePrev.v
        #***** end if *****
        i=i+1
        
        if(i<nRow)and(cols_dataMatrix[i]==2):
            fltState.w= float(dataMatrix[i][1])
            flagReadDat[i]=True
        else:
            #fltState.w= fltStatePrev.w + fltStatePrev.d_w*tInterval
            fltState.w= fltStatePrev.w
        #***** end if *****
        i=i+1
        
        if(i<nRow)and(cols_dataMatrix[i]==2):
            fltState.X_dot= float(dataMatrix[i][1])
            flagReadDat[i]=True
        else:
            #fltState.X_dot= fltStatePrev.X_dot + fltStatePrev.d_X_dot*tInterval
            fltState.X_dot= fltStatePrev.X_dot
        #***** end if *****
        i=i+1
        
        if(i<nRow)and(cols_dataMatrix[i]==2):
            fltState.Y_dot= float(dataMatrix[i][1])
            flagReadDat[i]=True
        else:
            #fltState.Y_dot= fltStatePrev.Y_dot + fltStatePrev.d_Y_dot*tInterval
            fltState.Y_dot= fltStatePrev.Y_dot
        #***** end if *****
        i=i+1
        
        if(i<nRow)and(cols_dataMatrix[i]==2):
            fltState.Z_dot= float(dataMatrix[i][1])
            flagReadDat[i]=True
        else:
            #fltState.Z_dot= fltStatePrev.Z_dot + fltStatePrev.d_Z_dot*tInterval
            fltState.Z_dot= fltStatePrev.Z_dot
        #***** end if *****
        i=i+1
        
        if(i<nRow)and(cols_dataMatrix[i]==2):
            fltState.xEast= float(dataMatrix[i][1])
            flagReadDat[i]=True
        else:
            #fltState.xEast= fltStatePrev.xEast + fltStatePrev.d_xEast*tInterval
            fltState.xEast= fltStatePrev.xEast
        #***** end if *****
        i=i+1
        
        if(i<nRow)and(cols_dataMatrix[i]==2):
            fltState.xNorth= float(dataMatrix[i][1])
            flagReadDat[i]=True
        else:
            #fltState.xNorth= fltStatePrev.xNorth + fltStatePrev.d_xNorth*tInterval
            fltState.xNorth= fltStatePrev.xNorth
        #***** end if *****
        i=i+1
        
        #----------
        if(i<nRow)and(cols_dataMatrix[i]==2):
            fltState.d_vel= float(dataMatrix[i][1])
            flagReadDat[i]=True
        else:
            fltState.d_vel= fltStatePrev.d_vel
        #***** end if *****
        i=i+1
        
        if(i<nRow)and(cols_dataMatrix[i]==2):
            fltState.d_alt= float(dataMatrix[i][1])
            flagReadDat[i]=True
        else:
            fltState.d_alt= fltStatePrev.d_alt
        #***** end if *****
        i=i+1
        
        if(i<nRow)and(cols_dataMatrix[i]==2):
            fltState.d_phi= float(dataMatrix[i][1])
            flagReadDat[i]=True
        else:
            fltState.d_phi= fltStatePrev.d_phi
        #***** end if *****
        i=i+1
        
        if(i<nRow)and(cols_dataMatrix[i]==2):
            fltState.d_theta= float(dataMatrix[i][1])
            flagReadDat[i]=True
        else:
            fltState.d_theta= fltStatePrev.d_theta
        #***** end if *****
        i=i+1
        
        if(i<nRow)and(cols_dataMatrix[i]==2):
            fltState.d_psi= float(dataMatrix[i][1])
            flagReadDat[i]=True
        else:
            fltState.d_psi= fltStatePrev.d_psi
        #***** end if *****
        i=i+1
        
        if(i<nRow)and(cols_dataMatrix[i]==2):
            fltState.d_alpha= float(dataMatrix[i][1])
            flagReadDat[i]=True
        else:
            fltState.d_alpha= fltStatePrev.d_alpha
        #***** end if *****
        i=i+1
        
        if(i<nRow)and(cols_dataMatrix[i]==2):
            fltState.d_beta= float(dataMatrix[i][1])
            flagReadDat[i]=True
        else:
            fltState.d_beta= fltStatePrev.d_beta
        #***** end if *****
        i=i+1
        
        if(i<nRow)and(cols_dataMatrix[i]==2):
            fltState.d_u= float(dataMatrix[i][1])
            flagReadDat[i]=True
        else:
            fltState.d_u= fltStatePrev.d_u
        #***** end if *****
        i=i+1
        
        if(i<nRow)and(cols_dataMatrix[i]==2):
            fltState.d_v= float(dataMatrix[i][1])
            flagReadDat[i]=True
        else:
            fltState.d_v= fltStatePrev.d_v
        #***** end if *****
        i=i+1
        
        if(i<nRow)and(cols_dataMatrix[i]==2):
            fltState.d_w= float(dataMatrix[i][1])
            flagReadDat[i]=True
        else:
            fltState.d_w= fltStatePrev.d_w
        #***** end if *****
        i=i+1
        
        if(i<nRow)and(cols_dataMatrix[i]==2):
            fltState.d_X_dot= float(dataMatrix[i][1])
            flagReadDat[i]=True
        else:
            fltState.d_X_dot= fltStatePrev.d_X_dot
        #***** end if *****
        i=i+1
        
        if(i<nRow)and(cols_dataMatrix[i]==2):
            fltState.d_Y_dot= float(dataMatrix[i][1])
            flagReadDat[i]=True
        else:
            fltState.d_Y_dot= fltStatePrev.d_Y_dot
        #***** end if *****
        i=i+1
        
        if(i<nRow)and(cols_dataMatrix[i]==2):
            fltState.d_Z_dot= float(dataMatrix[i][1])
            flagReadDat[i]=True
        else:
            fltState.d_Z_dot= fltStatePrev.d_Z_dot
        #***** end if *****
        i=i+1
        
        if(i<nRow)and(cols_dataMatrix[i]==2):
            fltState.d_xEast= float(dataMatrix[i][1])
            flagReadDat[i]=True
        else:
            fltState.d_xEast= fltStatePrev.d_xEast
        #***** end if *****
        i=i+1
        
        if(i<nRow)and(cols_dataMatrix[i]==2):
            fltState.d_xNorth= float(dataMatrix[i][1])
            flagReadDat[i]=True
        else:
            fltState.d_xNorth= fltStatePrev.d_xNorth
        #***** end if *****
        i=i+1
        
        #----------
        fltStateSave= copy.deepcopy(fltState)
        
        if(swPrintDbg==True):
            print("fltState.time="+str(round(fltState.time,3)))
            print(flagReadDat)
        #***** end if *****
    else:
        flagRead=False
        fltState= copy.deepcopy(fltStateSave)
    #***** end if *****
    
    #print("readFltStatesDat: "+str(flagRead))
    return flagInit, flagRead, fltState, fltStatePrev, fltStateSave
#***** end def *****


'''---------------------------------------------------------'''
''''''
def state_by_deriv(fltState: flightStates(), fltStatePrev: flightStates(), dt):
    
    fltState.time= fltStatePrev.time + dt
    fltState.vel= fltStatePrev.vel + fltStatePrev.d_vel*dt
    fltState.alt= fltStatePrev.alt + fltStatePrev.d_alt*dt
    fltState.phi= fltStatePrev.phi + fltStatePrev.d_phi*dt
    fltState.theta= fltStatePrev.theta + fltStatePrev.d_theta*dt
    fltState.psi= fltStatePrev.psi + fltStatePrev.d_psi*dt
    
    return fltState, fltStatePrev
#***** end def *****


'''---------------------------------------------------------'''
''''''
def initialize(flagInit: flightStates(), fltState: flightStates(), fltStatePrev: flightStates(), fltStateSave: flightStates()):
    flagInit=True
    fltState.resetAttributes()
    fltStatePrev.resetAttributes()
    fltStateSave.resetAttributes()
    return flagInit, \
        fltState, fltStatePrev, fltStateSave
    ''''''
#***** end def *****


'''---------------------------------------------------------'''
'''
def update_Rootframe2_Treeview(fltState: flightStates()):
    x = treeview.get_children()
        
    # delete table displayed on window
    for item in x:
        treeview.delete(item)
    #----- end for -----
    
    # re-display info of scv data
    timeRunning= time.time() - timeBegin
    treeview.insert("","end",values=("time (after python script began)", timeRunning))
    treeview.insert("","end",values=("d_vel",fltState.d_vel))
    treeview.insert("","end",values=("d_alt",fltState.d_alt))
    treeview.insert("","end",values=("d_phi",fltState.d_phi))
    treeview.insert("","end",values=("d_theta",fltState.d_theta))
    treeview.insert("","end",values=("d_psi",fltState.d_psi))
    
    # command of recursive call, with specific time interval
    rootframe2.after(tInterval, update_Rootframe2_Treeview, \
                     fltState)
#***** end def *****
'''

'''----------------------------------------------------------------------
main script
----------------------------------------------------------------------'''
# ---------- read data csv
fltState.__init__()
fltStatePrev.__init__()
fltStateSave.__init__()

[dataMatrix, nRow, nCol]= readcsv(fileFullPath=fullPathDataFile)
[flagInit, fltState, fltStatePrev, fltStateSave] \
    = initialize(flagInit, fltState, fltStatePrev, fltStateSave)

'''
# ----- generate canvas
canvasPFD.place(x=0, y=0)
canvasDatTbl.place(x=800, y=0)
'''
# ---------- call routine of display & update, with specific time interval
rootframe.after(tInterval, updatePFD, \
                flagInit, flagRead, \
                fltState, fltStatePrev, fltStateSave)
'''    
rootframe2.after(tInterval, update_Rootframe2_Treeview, \
                 fltState)
'''
# ---------- continue display & update of csv data until window is closed
rootframe.mainloop()

print('********** End of pyConsole02.py **********')
print('')
