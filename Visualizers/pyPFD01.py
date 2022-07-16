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
import numpy as np

'''--------------------
declare/instantiation/initialization
--------------------'''
vel: float=0.0
alt: float= 0.0
theta: float= 0.0
phi: float= 0.0


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


'''--------------------
setting about time handling
--------------------'''
''''''
timeBegin=time.time()
timeLim=1000000
tInterval=10    #[ms]


'''--------------------
setting about gui
--------------------'''
''''''
rootframe= tk.Tk()  # main gui window

rootframe.geometry("1200x900")

# table display gui
treeview=ttk.Treeview(rootframe)
treeview["show"]= "headings"
treeview["columns"]=(1,2)
treeview.heading(1, text="variable")
treeview.heading(2, text="value")
treeview.pack()

height_PFD=800
width_PFD=800
lenUnitPitch=500
canvasPFD = tk.Canvas(rootframe, bg = "white", height=height_PFD, width=width_PFD)
canvasDatTbl= tk.Canvas(rootframe, bg="white", height=900, width=400)


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
    r1_1= np.array([xCtr-1/2*width, yCtr])
    r1_2= np.array([xCtr+1/2*width, yCtr])
    
    r2_1= np.array([xCtr, yCtr-1/2*height])
    r2_2= np.array([xCtr, yCtr+1/2*height])
    
    canvasPFD.create_line(r1_1[0],r1_1[1], r1_2[0],r1_2[1], width=linewidth)
    canvasPFD.create_line(r2_1[0],r2_1[1], r2_2[0],r2_2[1], width=linewidth)
    
#***** end def *****


'''---------------------------------------------------------'''
''''''
def disp_lineLevel(phi, theta, xCtr=width_PFD/2,yCtr=height_PFD/2, xOfst=0, yOfst=0, length=2*width_PFD, 
                   linewidth=1.5, tag=""):
    r1= np.array([xCtr-1/2*length+xOfst, yCtr+yOfst])
    r2= np.array([xCtr+1/2*length+xOfst, yCtr+yOfst])
    r1pri= r1
    r2pri= r2
    
    Rtheta=np.array([[math.cos(-1.0*phi), -1.0*math.sin(-1.0*phi)],
                     [math.sin(-1.0*phi), math.cos(-1.0*phi)]])
    
    r1pri= r1
    r2pri= r2
    
    r1pri= r1+ np.array([0, theta*lenUnitPitch])
    r2pri= r2+ np.array([0, theta*lenUnitPitch])
    
    r1pri= r1pri + np.array([-xCtr, -yCtr])
    r2pri= r2pri + np.array([-xCtr, -yCtr])
    
    r1pri= np.dot(Rtheta, r1pri)
    r2pri= np.dot(Rtheta, r2pri)
    
    r1pri= r1pri + np.array([xCtr, yCtr])
    r2pri= r2pri + np.array([xCtr, yCtr])
    
    canvasPFD.create_line(r1pri[0],r1pri[1], r2pri[0],r2pri[1], width=linewidth, tag=tag)
#***** end def *****


'''---------------------------------------------------------'''
''''''
def disp_rectBackground(phi, theta, xCtr=width_PFD/2,yCtr=height_PFD/2, 
                xOfst=0, yOfst=45*math.pi/180*lenUnitPitch, 
                width=2*width_PFD, height=90*math.pi/180*lenUnitPitch, 
                fill="white", tag=""):
    r1= np.array([xCtr-1/2*width+xOfst, yCtr-1/2*height+yOfst])
    r2= np.array([xCtr-1/2*width+xOfst, yCtr+1/2*height+yOfst])
    r3= np.array([xCtr+1/2*width+xOfst, yCtr+1/2*height+yOfst])
    r4= np.array([xCtr+1/2*width+xOfst, yCtr-1/2*height+yOfst])
    r1pri= r1
    r2pri= r2
    r3pri= r3
    r4pri= r4
    
    Rtheta=np.array([[math.cos(-1.0*phi), -1.0*math.sin(-1.0*phi)],
                     [math.sin(-1.0*phi), math.cos(-1.0*phi)]])
    
    r1pri= r1pri+ np.array([0, theta*lenUnitPitch])
    r2pri= r2pri+ np.array([0, theta*lenUnitPitch])
    r3pri= r3pri+ np.array([0, theta*lenUnitPitch])
    r4pri= r4pri+ np.array([0, theta*lenUnitPitch])
    
    r1pri= r1pri + np.array([-xCtr, -yCtr])
    r2pri= r2pri + np.array([-xCtr, -yCtr])
    r3pri= r3pri + np.array([-xCtr, -yCtr])
    r4pri= r4pri + np.array([-xCtr, -yCtr])
    
    r1pri= np.dot(Rtheta, r1pri)
    r2pri= np.dot(Rtheta, r2pri)
    r3pri= np.dot(Rtheta, r3pri)
    r4pri= np.dot(Rtheta, r4pri)
    
    r1pri= r1pri + np.array([xCtr, yCtr])
    r2pri= r2pri + np.array([xCtr, yCtr])
    r3pri= r3pri + np.array([xCtr, yCtr])
    r4pri= r4pri + np.array([xCtr, yCtr])
    
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
def disp_value(val, x=10, y=height_PFD/2, fontsize=18):
    font_val= font.Font(size=fontsize)
    label_val = tk.Label(text=val, font=font_val)
    label_val.place(x=x, y=y)
#***** end def *****


'''-----------------------------------------------------------------------------'''
'''-----------------------------------------------------------------------------'''
''''''
def mainroutine():
    
    # generate canvas
    canvasPFD.place(x=0,y=0)
    canvasDatTbl.place(x=800, y=0)
    
    if(os.path.exists(fullPathDataFile)==True):
        # read data csv
        [dataMatrix, nRow, nCol]= readcsv(fileFullPath=fullPathDataFile)
        vel= float(dataMatrix[1][1])
        alt= float(dataMatrix[2][1])
        phi= float(dataMatrix[3][1])
        theta= float(dataMatrix[4][1])
        psi= float(dataMatrix[5][1])
        Z_dot= float(dataMatrix[11][1])
        
        phi_deg= phi*180.0/math.pi
        psi_deg= psi*180.0/math.pi
        vs= -1.0*Z_dot
        
        x = treeview.get_children()
        disp_CenterCross()
        
        # delete items displayed on window
        for item in x:
            treeview.delete(item)
            canvasPFD.delete("ground")
            
            canvasPFD.delete("0deg-pitch")
            
            canvasPFD.delete("10deg-pitch")
            canvasPFD.delete("20deg-pitch")
            canvasPFD.delete("30deg-pitch")
            canvasPFD.delete("40deg-pitch")
            canvasPFD.delete("50deg-pitch")
            canvasPFD.delete("60deg-pitch")
            canvasPFD.delete("70deg-pitch")
            canvasPFD.delete("80deg-pitch")
            canvasPFD.delete("90deg-pitch")
            
            canvasPFD.delete("-10deg-pitch")
            canvasPFD.delete("-20deg-pitch")
            canvasPFD.delete("-30deg-pitch")
            canvasPFD.delete("-40deg-pitch")
            canvasPFD.delete("-50deg-pitch")
            canvasPFD.delete("-60deg-pitch")
            canvasPFD.delete("-70deg-pitch")
            canvasPFD.delete("-80deg-pitch")
            canvasPFD.delete("-90deg-pitch")
        #----- end for -----
        
        # re-display
        timeRunning= time.time() - timeBegin
        treeview.insert("","end",values=("time (after python script began)", timeRunning))
        
        i=0
        for i in range(nRow):
            treeview.insert("","end",values=(dataMatrix[i][0],dataMatrix[i][1]))
            
            disp_rectBackground(phi, theta, fill="chocolate1", tag="ground")
            disp_rectBackground(phi, theta, yOfst=-45*math.pi/180*lenUnitPitch,
                                fill="cyan", tag="ground")
            
            disp_lineLevel(phi=phi, theta=theta, linewidth=2.0, tag="0deg-pitch")    # 0-deg-pitch
            
            k=0.3
            disp_lineLevel(phi=phi, theta=theta, xCtr=width_PFD/2, yCtr=height_PFD/2, xOfst=0, yOfst=-10*math.pi/180*lenUnitPitch, length=k*width_PFD, tag="10deg-pitch")    # 10-deg-pitch
            disp_lineLevel(phi=phi, theta=theta, xCtr=width_PFD/2, yCtr=height_PFD/2, xOfst=0, yOfst=-20*math.pi/180*lenUnitPitch, length=k*width_PFD, tag="20deg-pitch")    # 20-deg-pitch
            disp_lineLevel(phi=phi, theta=theta, xCtr=width_PFD/2, yCtr=height_PFD/2, xOfst=0, yOfst=-30*math.pi/180*lenUnitPitch, length=k*width_PFD, tag="30deg-pitch")    # 30-deg-pitch
            disp_lineLevel(phi=phi, theta=theta, xCtr=width_PFD/2, yCtr=height_PFD/2, xOfst=0, yOfst=-40*math.pi/180*lenUnitPitch, length=k*width_PFD, tag="40deg-pitch")    # 40-deg-pitch
            disp_lineLevel(phi=phi, theta=theta, xCtr=width_PFD/2, yCtr=height_PFD/2, xOfst=0, yOfst=-50*math.pi/180*lenUnitPitch, length=k*width_PFD, tag="50deg-pitch")    # 50-deg-pitch
            disp_lineLevel(phi=phi, theta=theta, xCtr=width_PFD/2, yCtr=height_PFD/2, xOfst=0, yOfst=-60*math.pi/180*lenUnitPitch, length=k*width_PFD, tag="60deg-pitch")    # 60-deg-pitch
            disp_lineLevel(phi=phi, theta=theta, xCtr=width_PFD/2, yCtr=height_PFD/2, xOfst=0, yOfst=-70*math.pi/180*lenUnitPitch, length=k*width_PFD, tag="70deg-pitch")    # 70-deg-pitch
            disp_lineLevel(phi=phi, theta=theta, xCtr=width_PFD/2, yCtr=height_PFD/2, xOfst=0, yOfst=-80*math.pi/180*lenUnitPitch, length=k*width_PFD, tag="80deg-pitch")    # 80-deg-pitch
            disp_lineLevel(phi=phi, theta=theta, xCtr=width_PFD/2, yCtr=height_PFD/2, xOfst=0, yOfst=-90*math.pi/180*lenUnitPitch, length=1.5*k*width_PFD, tag="90deg-pitch")    # 90-deg-pitch
            
            disp_lineLevel(phi=phi, theta=theta, xCtr=width_PFD/2, yCtr=height_PFD/2, xOfst=0, yOfst=10*math.pi/180*lenUnitPitch, length=k*width_PFD, tag="-10deg-pitch")    # -10-deg-pitch
            disp_lineLevel(phi=phi, theta=theta, xCtr=width_PFD/2, yCtr=height_PFD/2, xOfst=0, yOfst=20*math.pi/180*lenUnitPitch, length=k*width_PFD, tag="-20deg-pitch")    # -20-deg-pitch
            disp_lineLevel(phi=phi, theta=theta, xCtr=width_PFD/2, yCtr=height_PFD/2, xOfst=0, yOfst=30*math.pi/180*lenUnitPitch, length=k*width_PFD, tag="-30deg-pitch")    # -30-deg-pitch
            disp_lineLevel(phi=phi, theta=theta, xCtr=width_PFD/2, yCtr=height_PFD/2, xOfst=0, yOfst=40*math.pi/180*lenUnitPitch, length=k*width_PFD, tag="-40deg-pitch")    # -40-deg-pitch
            disp_lineLevel(phi=phi, theta=theta, xCtr=width_PFD/2, yCtr=height_PFD/2, xOfst=0, yOfst=50*math.pi/180*lenUnitPitch, length=k*width_PFD, tag="-50deg-pitch")    # -50-deg-pitch
            disp_lineLevel(phi=phi, theta=theta, xCtr=width_PFD/2, yCtr=height_PFD/2, xOfst=0, yOfst=60*math.pi/180*lenUnitPitch, length=k*width_PFD, tag="-60deg-pitch")    # -60-deg-pitch
            disp_lineLevel(phi=phi, theta=theta, xCtr=width_PFD/2, yCtr=height_PFD/2, xOfst=0, yOfst=70*math.pi/180*lenUnitPitch, length=k*width_PFD, tag="-70deg-pitch")    # -70-deg-pitch
            disp_lineLevel(phi=phi, theta=theta, xCtr=width_PFD/2, yCtr=height_PFD/2, xOfst=0, yOfst=80*math.pi/180*lenUnitPitch, length=k*width_PFD, tag="-80deg-pitch")    # -80-deg-pitch
            disp_lineLevel(phi=phi, theta=theta, xCtr=width_PFD/2, yCtr=height_PFD/2, xOfst=0, yOfst=90*math.pi/180*lenUnitPitch, length=1.5*k*width_PFD, tag="-90deg-pitch")    # -90-deg-pitch
            
            disp_CenterCross()
            
            disp_value(val= str(round(phi_deg,2)), x=1/2*width_PFD-20, y=10, fontsize=16)     # display altitude
            disp_value(val= str(round(vel))+" m/s", x=80)   # display velocity
            disp_value(val= str(round(alt))+" m", x=1/2*width_PFD+220)     # display altitude
            disp_value(val= str(round(vs))+" m/s", x=1/2*width_PFD+280, y=height_PFD/2+40)     # display altitude
            disp_value(val= str(round(psi_deg)), x=1/2*width_PFD-30, y=height_PFD-50)     # display altitude
            
        #***** end for *****
        ''''''
    else:
        print("failed to open file")
    #***** end if *****
    
    # command of recursive call, with specific time interval
    rootframe.after(tInterval, mainroutine)
#***** end def *****



'''----------------------------------------------------------------------
main script
----------------------------------------------------------------------'''
''''''
# read data csv
[dataMatrix, nRow, nCol]= readcsv(fileFullPath=fullPathDataFile)

# display info of scv data
timeRunning= time.time() - timeBegin
treeview.insert("","end",values=("time(in python script)", timeRunning))
i=0
for i in range(nRow):
    treeview.insert( "","end",values=(dataMatrix[i][0],dataMatrix[i][1]) )
#***** end for *****


# call routine of display & update, with specific time interval
rootframe.after(tInterval, mainroutine)

# continue display & update of csv data until window is closed
rootframe.mainloop()

print('********** End of pyConsole02.py **********')
print('')
