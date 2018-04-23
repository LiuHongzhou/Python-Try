# -*- coding:utf-8 -*-
import cv2
from FaceDetection.video import create_capture
hat = cv2.imread("hat.png")
hat = cv2.resize(hat, (320, 240))

video_src = 0
camera = create_capture(video_src)
while True:
    ret, image = camera.read()
    cv2.imshow("video", image)
    if cv2.waitKey(5) is 0:
        break
cv2.destroyAllWindows()

