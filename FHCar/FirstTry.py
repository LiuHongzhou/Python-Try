# -*- coding:utf-8 -*-
from __future__ import print_function
import pygame
from pygame.locals import *
from sys import exit
from CarControl import Car
from CarControl import Location
import threading
import time
import math

def ReadConfig(filePath):
    CarName = "NoName"
    Width = 0
    Height = 0
    WonderMode = False
    xMin = 0
    xMax = 10
    yMin = 0
    yMax = 10
    Printable = False
    x = 0
    y = 0
    angle = 0
    Speed = 1
    Time_Gap = 0.05
    fileName = filePath + "Config.txt"

    f = open(fileName, "r")
    lines = f.readlines()  # 读取全部内容
    for line in lines:
        line = line.strip('\n')
        if line.find("CAR_NAME") == 0:
            startIndex = line.index(" ")
            CarName = line[startIndex + 1:]
        elif line.find("CAR_FIGURE") == 0:
            firstIndex = line.index(" ")
            secondIndex = line.index(" ", firstIndex + 1)
            Width = float(line[firstIndex + 1: secondIndex])
            Height = float(line[secondIndex + 1:])
        elif line.find("WONDER_MODE") == 0:
            startIndex = line.index(" ")
            if line[startIndex + 1:] == "True":
                WonderMode = True
            elif line[startIndex + 1:] == "False":
                WonderMode = False
        elif line.find("MAP_AREA") == 0:
            firstIndex = line.index(" ")
            secondIndex = line.index(" ", firstIndex + 1)
            thirdIndex = line.index(" ", secondIndex + 1)
            fourthIndex = line.index(" ", thirdIndex + 1)
            xMin = float(line[firstIndex + 1: secondIndex])
            xMax = float(line[secondIndex + 1: thirdIndex])
            yMin = float(line[thirdIndex + 1: fourthIndex])
            yMax = float(line[fourthIndex + 1:])
        elif line.find("PRINTABLE") == 0:
            startIndex = line.index(" ")
            if line[startIndex + 1:] == "True":
                Printable = True
            elif line[startIndex + 1:] == "False":
                Printable = False
        elif line.find("INIT_LOCATION") == 0:
            firstIndex = line.index(" ")
            secondIndex = line.index(" ", firstIndex + 1)
            thirdIndex = line.index(" ", secondIndex + 1)
            x = float(line[firstIndex + 1: secondIndex])
            y = float(line[secondIndex + 1: thirdIndex])
            angle = float(line[thirdIndex + 1:])
        elif line.find("SPEED") == 0:
            startIndex = line.index(" ")
            Speed = float(line[startIndex + 1:])
        elif line.find("TIME_GAP") == 0:
            startIndex = line.index(" ")
            Time_Gap = float(line[startIndex + 1:])
    return {"CAR_NAME": CarName,
            "CAR_FIGURE": [Width, Height],
            "WONDER_MODE": WonderMode,
            "MAP_AREA": [xMin, xMax, yMin, yMax],
            "PRINTABLE": Printable,
            "INIT_LOCATION": Location(x, y, angle),
            "SPEED": Speed,
            "TIME_GAP": Time_Gap
            }

class FHCar(Car):
    def __init__(self, filePath):
        ConfigDict = ReadConfig(filePath)
        Car.__init__(self, ConfigDict["CAR_NAME"],
                     ConfigDict["CAR_FIGURE"][0],
                     ConfigDict["CAR_FIGURE"][1],
                     ConfigDict["INIT_LOCATION"],
                     ConfigDict["PRINTABLE"],
                     ConfigDict["SPEED"],
                     ConfigDict["TIME_GAP"],
                     ConfigDict["MAP_AREA"],
                     filePath,
                     ConfigDict["WONDER_MODE"]
                     )

class UpdateGUI(threading.Thread):
    def __init__(self):
        threading.Thread.__init__(self)
        self.Killed = False

    def run(self):
        self.Update()

    def Kill(self):
        self.Killed = True

    def Update(self):
        global Screen, Background, FHBlackCar, FHGreenCar, FHYellowCar, BlackCar, GreenCar, YellowCar
        while self.Killed == False:
            Screen.blit(Background, (0, 0))

            BlackCar_Rotate = pygame.transform.rotate(BlackCar, -FHBlackCar.NowLocation.angle * 180 / math.pi - 90)
            Screen.blit(BlackCar_Rotate, (FHBlackCar.NowLocation.x*100 - BlackCar_Rotate.get_width()/2.0, FHBlackCar.NowLocation.y*100 - BlackCar_Rotate.get_height()/2.0))

            GreenCar_Rotate = pygame.transform.rotate(GreenCar, -FHGreenCar.NowLocation.angle * 180 / math.pi - 90)
            Screen.blit(GreenCar_Rotate, (FHGreenCar.NowLocation.x*100 - GreenCar_Rotate.get_width()/2.0, FHGreenCar.NowLocation.y*100 - GreenCar_Rotate.get_height()/2.0))

            YellowCar_Rotate = pygame.transform.rotate(YellowCar, -FHYellowCar.NowLocation.angle * 180 / math.pi - 90)
            Screen.blit(YellowCar_Rotate, (FHYellowCar.NowLocation.x*100 - YellowCar_Rotate.get_width()/2.0, FHYellowCar.NowLocation.y*100 - YellowCar_Rotate.get_height()/2.0))

            pygame.display.update()
            time.sleep(0.02)

BackgroundPic = "BackGround.png"
BlackCarPic = "BlackCar\Black.png"
GreenCarPic = "GreenCar\Green.png"
YellowCarPic = "YellowCar\Yellow.png"

pygame.init()
Screen = pygame.display.set_mode((1200, 800), 0, 32)
pygame.display.set_caption("FH_Car")
Background = pygame.image.load_extended(BackgroundPic).convert()
Screen.blit(Background, (0, 0))

BlackCar = pygame.image.load_extended(BlackCarPic).convert_alpha()
FHBlackCar = FHCar("BlackCar\\")
Screen.blit(BlackCar, (FHBlackCar.NowLocation.x*100, FHBlackCar.NowLocation.y*100))

GreenCar = pygame.image.load_extended(GreenCarPic).convert_alpha()
FHGreenCar = FHCar("GreenCar\\")
Screen.blit(GreenCar, (FHGreenCar.NowLocation.x*100, FHGreenCar.NowLocation.y*100))

YellowCar = pygame.image.load_extended(YellowCarPic).convert_alpha()
FHYellowCar = FHCar("YellowCar\\")
Screen.blit(YellowCar, (FHYellowCar.NowLocation.x*100, FHYellowCar.NowLocation.y*100))

Thread_UpdateGUI = UpdateGUI()
Thread_UpdateGUI.start()

while True:
    for event in pygame.event.get():
        if event.type == QUIT:
            FHBlackCar.Kill()
            FHGreenCar.Kill()
            FHYellowCar.Kill()
            Thread_UpdateGUI.Kill()
            exit()
        elif event.type == MOUSEBUTTONDOWN:
            x, y = pygame.mouse.get_pos()
            pressBtn = pygame.mouse.get_pressed()
            if pressBtn[0] == 1:
                FHBlackCar.SetNewTarget(Location(x/100.0, y/100.0, 0.0))
            elif pressBtn[1] == 1:
                FHGreenCar.SetNewTarget(Location(x/100.0, y/100.0, 0.0))
            elif pressBtn[2] == 1:
                FHYellowCar.SetNewTarget(Location(x/100.0, y/100.0, 0.0))
