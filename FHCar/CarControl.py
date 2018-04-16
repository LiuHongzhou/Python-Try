# -*- coding: UTF-8 -*-
import time
import math
import threading
import random

class Location:
    def __init__(self, x = 0.0, y=0.0, angle=0.0):
        self.x = x
        self.y = y
        self.angle = angle
    def Add(self, other):
        self.x = float(self.x) + float(other.x)
        self.y = float(self.y) + float(other.y)
        self.angle = float(self.angle) + float(other.angle)
        return self
    def AddDouble(self, other1, other2):
        self.x = float(self.x) + float(other1.x) + float(other2.x)
        self.y = float(self.y) + float(other1.y) + float(other2.y)
        self.angle = float(self.angle) + float(other1.angle) + float(other2.angle)
        return self
    def Sub(self, other):
        self.x = float(self.x) - float(other.x)
        self.y = float(self.y) - float(other.y)
        self.angle = float(self.angle) - float(other.angle)
        return self
    def Equal(self, other):
        self.x = float(other.x)
        self.y = float(other.y)
        self.angle = float(other.angle)
        return self

    def ifEqual(self, other):
        if self.x == other.x and self.y == other.y and self.angle == other.angle:
            return True
        else:
            return False

class MoveTask():
    def __init__(self, initLocation = Location(), finishLocation = Location()):
        self.InitLocation = initLocation
        self.FinishLocation = finishLocation
        self.DeltaLocation = self.FinishLocation.Sub(self.InitLocation)
        self.TaskStatus = "WAIT" #DOING ABORT ERROR WAIT

    def GetTarget(self):
        return self.FinishLocation

    def GetStatus(self):
        return self.TaskStatus

class Car():
    def __init__(self, CarName, FigureX = 0.0, FigureY = 0.0, initLocation = None, PrintState = False, Speed = 1, TimeGap = 0.01, MapArea = None, LogPath = "", wonderMode = False):
        self.carLocation = Location() #本次计算使用的小车位置 局部变量
        self.TargetLocation = Location() #小车目标位置
        self.nextLocation = Location() #计算出的下一个点位置 局部变量
        self.CarLocationImg = Location() #小车位置镜像
        self.NowLocation = Location() #小车当前位置 用于输出
        self.xyPixPerCycle = Location()

        self.carLocation.Equal(initLocation)
        self.TargetLocation.Equal(self.carLocation)
        self.nextLocation.Equal(self.carLocation)
        self.CarLocationImg.Equal(self.carLocation)
        self.NowLocation.Equal(self.carLocation)
        self.Killed = False
        self.Printable = PrintState
        self.Speed = Speed # 1m/s
        self.AngleSpeed = math.pi # rad/s
        self.RefreshGap = TimeGap # 0.1s
        self.Angle2Target = 0
        self.Width, self.Height = FigureX, FigureY
        self.StartTime = time.time()
        self.NowTime = time.time()
        self.WonderModeEnable = wonderMode
        self.MapMinX = MapArea[0]
        self.MapMaxX = MapArea[1]
        self.MapMinY = MapArea[2]
        self.MapMaxY = MapArea[3]

        self.ThreadBegin = time.time()
        self.ThreadFinish = time.time()
        self.ThreadDelay = 0

        self.CarName = CarName
        self.file = open(LogPath + CarName + ".txt", "w")
        car = CarWorkThread(self)
        car.start()

    def OutputLocation(self, Location):
        self.NowLocation = Location

    def RefreshImgLocation(self):
        self.CarLocationImg.Equal(self.nextLocation)

    def SetNewTarget(self, location = Location()):
        location.Sub(Location(self.Width/2.0, self.Height/2.0, 0.0))
        self.TargetLocation.Equal(location)

    def Kill(self):
        self.Killed = True

    def SetWonderMode(self, ifEnable):
        self.WonderModeEnable = ifEnable

    def SetMapArea(self, xmin, xmax, ymin, ymax):
        self.MapMinX = xmin
        self.MapMaxX = xmax
        self.MapMinY = ymin
        self.MapMaxY = ymax

    def SetDebugState(self, printState):
        self.Printable = printState

    def SetSpeed(self, speed = 1):
        self.Speed = speed

    def SetRefreshGap(self, refreshGap = 0.1):
        self.RefreshGap = refreshGap

    def RefreshCarLocation(self):
        self.carLocation.Equal(self.CarLocationImg)
        if self.TargetLocation.x == self.carLocation.x and self.TargetLocation.y == self.carLocation.y:
            self.Angle2Target = self.TargetLocation.angle
        elif self.TargetLocation.x == self.carLocation.x:
            self.Angle2Target = Sign(self.TargetLocation.y - self.carLocation.y) * math.pi/2
        elif self.TargetLocation.y == self.carLocation.y:
            if self.TargetLocation.x - self.carLocation.x > 0:
                self.Angle2Target = 0
            else:
                self.Angle2Target = math.pi
        else:
            self.Angle2Target = math.atan(math.fabs(self.TargetLocation.y - self.carLocation.y) / math.fabs(self.TargetLocation.x - self.carLocation.x))
            if self.TargetLocation.y - self.carLocation.y > 0 and self.TargetLocation.x - self.carLocation.x > 0:
                self.Angle2Target = self.Angle2Target
            elif self.TargetLocation.y - self.carLocation.y > 0 and self.TargetLocation.x - self.carLocation.x < 0:
                self.Angle2Target = math.pi - self.Angle2Target
            elif self.TargetLocation.y - self.carLocation.y < 0 and self.TargetLocation.x - self.carLocation.x < 0:
                self.Angle2Target = -math.pi + self.Angle2Target
            elif self.TargetLocation.y - self.carLocation.y < 0 and self.TargetLocation.x - self.carLocation.x > 0:
                self.Angle2Target =  - self.Angle2Target



    def CalcNewLocation(self):
        disPerGap = self.Speed * self.RefreshGap
        self.xyPixPerCycle.Equal(Location(disPerGap * math.cos(self.Angle2Target), disPerGap * math.sin(self.Angle2Target), 0.0))
        if self.TargetLocation.x == self.carLocation.x and self.TargetLocation.y == self.carLocation.y:
            self.nextLocation.Equal(self.TargetLocation)
            self.xyPixPerCycle.Equal(Location())
        elif math.fabs(self.TargetLocation.x - self.carLocation.x) <= math.fabs(self.xyPixPerCycle.x) and \
             math.fabs(self.TargetLocation.y - self.carLocation.y) <= math.fabs(self.xyPixPerCycle.y):
            self.nextLocation.Equal(self.TargetLocation)
        else:
            Temp = Location()
            Temp.AddDouble(self.carLocation, self.xyPixPerCycle)
            self.nextLocation.Equal(Temp)

    def CalcNewLocationNew(self):
        # if self.TargetLocation.x == self.carLocation.x and self.TargetLocation.y == self.carLocation.y:
        #     disPerGap = 0
        # else:
        #     disPerGap = self.Speed * self.RefreshGap

        if self.carLocation.angle == self.Angle2Target:
            anglePerGap = 0
            if self.TargetLocation.x == self.carLocation.x and self.TargetLocation.y == self.carLocation.y:
                disPerGap = 0
            else:
                disPerGap = self.Speed * self.RefreshGap
        else:
            anglePerGap = self.AngleSpeed * self.RefreshGap
            disPerGap = 0

        self.xyPixPerCycle.Equal(Location(disPerGap * math.cos(self.Angle2Target), disPerGap * math.sin(self.Angle2Target), anglePerGap * Sign(self.Angle2Target - self.carLocation.angle)))
        if self.TargetLocation.x == self.carLocation.x and self.TargetLocation.y == self.carLocation.y and self.TargetLocation.angle == self.carLocation.angle:
            self.nextLocation.Equal(self.TargetLocation)
            self.xyPixPerCycle.Equal(Location())
        else:
            if math.fabs(self.TargetLocation.x - self.carLocation.x) <= math.fabs(self.xyPixPerCycle.x) and  math.fabs(self.TargetLocation.y - self.carLocation.y) <= math.fabs(self.xyPixPerCycle.y):
                self.carLocation.x = self.TargetLocation.x
                self.carLocation.y = self.TargetLocation.y
                self.xyPixPerCycle.x = 0
                self.xyPixPerCycle.y = 0
            if math.fabs(self.Angle2Target - self.carLocation.angle) <= math.fabs(self.xyPixPerCycle.angle):
                self.carLocation.angle = self.Angle2Target
                self.xyPixPerCycle.angle = 0
            Temp = Location()
            Temp.AddDouble(self.carLocation, self.xyPixPerCycle)
            self.nextLocation.Equal(Temp)

    def WonderMode(self):
        if self.WonderModeEnable == True:
            if self.carLocation.ifEqual(self.TargetLocation) == True:
                newX = random.uniform(self.MapMinX, self.MapMaxX)
                newY = random.uniform(self.MapMinY, self.MapMaxY)

                if newX == self.carLocation.x and newY == self.carLocation.y:
                    newAngle = self.TargetLocation.angle
                elif newX == self.carLocation.x:
                    newAngle = Sign(newY - self.carLocation.y) * math.pi / 2
                elif newY == self.carLocation.y:
                    if newX - self.carLocation.x > 0:
                        newAngle = 0
                    else:
                        newAngle = math.pi
                else:
                    newAngle = math.atan(math.fabs(newY - self.carLocation.y) / math.fabs(
                        newX - self.carLocation.x))
                    if newY - self.carLocation.y > 0 and newX - self.carLocation.x > 0:
                        newAngle = newAngle
                    elif newY - self.carLocation.y > 0 and newX - self.carLocation.x < 0:
                        newAngle = math.pi - newAngle
                    elif newY - self.carLocation.y < 0 and newX - self.carLocation.x < 0:
                        newAngle = - math.pi + newAngle
                    elif newY - self.carLocation.y < 0 and newX - self.carLocation.x > 0:
                        newAngle = -newAngle
                self.SetNewTarget(Location(newX, newY, newAngle))

    def CarWorkThreadCallback(self):
        while self.Killed == False:
            self.ThreadBegin = time.time()
            self.WonderMode()
            self.RefreshImgLocation()
            self.RefreshCarLocation()
            #self.CalcNewLocation()
            self.CalcNewLocationNew()
            self.OutputLocation(self.nextLocation)
            self.DebugInfoLine()
            self.ThreadFinish = time.time()
            self.ThreadDelay = self.ThreadFinish - self.ThreadBegin
            time.sleep(self.RefreshGap)
        self.file.close()

    def DebugInfoLine(self):
        if self.Printable:
            #打印调试信息
            self.NowTime = time.time()
            print self.CarName       + " " \
                  "TimeStamp: "      + str("%.3f" % (self.NowTime - self.StartTime)) + "  " \
                  "NowPosition: "    + str("%.3f" % self.carLocation.x)              + "  " + str("%.3f" % self.carLocation.y)      + "  " + str("%.3f" % self.carLocation.angle)     + "  " \
                  "TargetPosition: " + str("%.3f" % self.TargetLocation.x)           + "  " + str("%.3f" % self.TargetLocation.y)   + "  " + str("%.3f" % self.TargetLocation.angle)  + "  " \
                  "NextPosition: "   + str("%.3f" % self.nextLocation.x)             + "  " + str("%.3f" % self.nextLocation.y)     + "  " + str("%.3f" % self.nextLocation.angle)    + "  " \
                  "xyPixPerCycle: "  + str("%.3f" % self.xyPixPerCycle.x)            + "  " + str("%.3f" % self.xyPixPerCycle.y)    + "  " + str("%.3f" % self.xyPixPerCycle.angle)   + "  " \
                  "Angle2Target: "   + str("%.3f" % self.Angle2Target) + "  " \
                  "Thread Time: "    + str("%.3f" % (self.ThreadDelay))
            #打印调试信息到文件
            print >> self.file, \
                  self.CarName       + " " \
                  "TimeStamp: "      + str("%.3f" % (self.NowTime - self.StartTime)) + "  " \
                  "NowPosition: "    + str("%.3f" % self.carLocation.x)              + "  " + str("%.3f" % self.carLocation.y)      + "  " + str("%.3f" % self.carLocation.angle)     + "  " \
                  "TargetPosition: " + str("%.3f" % self.TargetLocation.x)           + "  " + str("%.3f" % self.TargetLocation.y)   + "  " + str("%.3f" % self.TargetLocation.angle)  + "  " \
                  "NextPosition: "   + str("%.3f" % self.nextLocation.x)             + "  " + str("%.3f" % self.nextLocation.y)     + "  " + str("%.3f" % self.nextLocation.angle)    + "  " \
                  "xyPixPerCycle: "  + str("%.3f" % self.xyPixPerCycle.x)            + "  " + str("%.3f" % self.xyPixPerCycle.y)    + "  " + str("%.3f" % self.xyPixPerCycle.angle)   + "  " \
                  "Angle2Target: "   + str("%.3f" % self.Angle2Target) + "  " \
                  "Thread Time: "    + str("%.3f" % (self.ThreadDelay))

def Sign(x):
    if x > 0:
        return 1
    elif x < 0:
        return -1
    else:
        return 0

class CarWorkThread(threading.Thread):
    def __init__(self, car):
        threading.Thread.__init__(self)
        self.Car = car

    def run(self):
        Car.CarWorkThreadCallback(self.Car)
