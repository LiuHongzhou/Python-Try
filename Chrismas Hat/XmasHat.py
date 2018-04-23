# -*- coding:utf-8 -*-
import cv2
from FaceDetection.video import create_capture

hat_length = 64
hat_width = 48
scaler = 0.75
startx = 0
starty = 0

def getImg(filename, size = (hat_length, hat_length*scaler)):
    img = cv2.imread(filename, cv2.IMREAD_UNCHANGED)
    r, g, b, a = cv2.split(img)
    rgb_img = cv2.merge((r,g,b))
    resize_img = cv2.resize(rgb_img, size)
    return resize_img

def detect(img, cascade):
    rects = cascade.detectMultiScale(img, scaleFactor=1.3, minNeighbors=4, minSize=(30, 30),
                                     flags=cv2.CASCADE_SCALE_IMAGE)
    if len(rects) == 0:
        return []
    rects[:,2:] += rects[:,:2]
    return rects

def draw_rects(img, rects, color):
    for x1, y1, x2, y2 in rects:
        cv2.rectangle(img, (x1, y1), (x2, y2), color, 2)

if __name__ == '__main__':
    video_src = 0
    cam = create_capture(video_src)
    cascade_fn = "FaceDetection/haarcascade_frontalface_alt.xml"
    nested_fn  = "FaceDetection/haarcascade_eye.xml"
    cascade = cv2.CascadeClassifier(cascade_fn)
    nested = cv2.CascadeClassifier(nested_fn)
    hat = getImg("hat.png", (64, 48))
    while True:
        ret, img = cam.read()
        # img = cv2.imread("lhz.png")
        # img = getImg("lhz.png", (640,480))
        gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
        gray = cv2.equalizeHist(gray)
        rects = detect(gray, cascade)
        draw_rects(img, rects, (0, 255, 0))
        print rects
        if len(rects) is not 0:
            startx = rects[0][0]
            starty = rects[0][1] - 100
            hat_length = int(rects[0][3]*0.5)
            hat_width = int(hat_length*scaler)
            hat = getImg("hat.png", (hat_length, hat_width))
        if starty>0 and starty+hat_width<480 and startx>0 and startx+hat_length<640:
            tem_img = img[starty:starty+hat_width, startx:startx+hat_length]
            tem_img2 = cv2.addWeighted(tem_img, 1, hat[:], 1, 0)
            img[starty:starty+hat_width, startx:startx+hat_length] = tem_img2
        cv2.imshow("MixImg", img)
        if cv2.waitKey(5) is 0:
            break
    cv2.destroyAllWindows()