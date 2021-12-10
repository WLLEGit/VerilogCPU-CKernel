import numpy
import cv2
from PIL import Image, ImageDraw
import os
from moviepy.editor import *
from numpy.core.fromnumeric import compress
from tqdm import tqdm
import sys


def get_frame_count(path):
    cap = cv2.VideoCapture(path)
    return cap.get(cv2.CAP_PROP_FRAME_COUNT)


def get_fps(path): 
    cap = cv2.VideoCapture(path)
    return cap.get(cv2.CAP_PROP_FPS)


def get_ratio(path):  
    cap = cv2.VideoCapture(path)
    return cap.get(cv2.CAP_PROP_FRAME_WIDTH) / cap.get(cv2.CAP_PROP_FRAME_HEIGHT)


def video2imgs(path, size):  # convert video to list of images
    img_list = []
    cap = cv2.VideoCapture(path)
    with tqdm(total=get_frame_count(path)) as pbar:  # add progress bar
        while cap.isOpened():
            ret, frame = cap.read()
            if ret:
                gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)  # convert to grayscale
                image = cv2.resize(gray, size, interpolation=cv2.INTER_AREA)
                img_list.append(image)
            else:
                break
            pbar.update(1)
    cap.release()
    return img_list


def img2char(img):
    str = ".:+*?%#@"
    str = str[::-1]
    result = []
    # 灰度最大值255，以下两步意在将每个像素对应的值设为str中的下标
    percents = img / 255
    indexes = (percents * (len(str) - 1)).astype(numpy.int)
    height, width = img.shape
    for row in range(height):
        line = ""
        for col in range(width):
            index = indexes[row][col]
            line += str[index]
        result.append(line)
    return result


def imgs2chars(imgs):
    result = []
    for img in imgs:
        result.append(img2char(img))
    return result

from functools import reduce
def CompressText(lines):
    def pair2byte(p):
        return (int(p[0]) << 3) + int(p[1])
    
    res = []
    
    assert len(lines) == 30
    lines = [line + "." * (64 - len(line)) for line in lines]
    text = reduce(lambda x, y: x + y, lines, "")
    assert len(text) == 64 * 30
    
    cnter = 0
    s = ".:+*?%#@"
    dic = {}
    for i in range(len(s)):
        dic[s[i]] = i
        
    cur = text[0]
    for i in range(len(text)):
        if text[i] == cur:
            if cnter < 31:
                cnter += 1
            else:
                res.append((cnter, dic[cur]))
                cnter = 1
        else:
            res.append((cnter, dic[cur]))
            cur = text[i]
            cnter = 1
    res.append((cnter, dic[cur]))
    res = list(map(pair2byte, res))
    
    return res
    
MAX_MEM = 512 * 1024   #512KB
def bytes2mif(bytes):
    mif_path = "out.mif"
    mif = "WIDTH=8;\nDEPTH=%d;\n\nADDRESS_RADIX=HEX;\nDATA_RADIX=HEX;\n\nCONTENT BEGIN\n" % (MAX_MEM)
    
    for i in range(len(bytes)):
        mif += "{:05X} : {:02X};\n".format(i, bytes[i])
    mif += "[{:06X}..{:06X}] : {};\nEND;".format(i, MAX_MEM-1, 0)
    
    with open(mif_path, "w") as f:
        f.write(mif)


if __name__ == "__main__":
    path = sys.argv[1]

    ratio = get_ratio(path)
    width, height = int(ratio * 30), 30

    imgs = video2imgs(path, (width, height))  
    video_chars = imgs2chars(imgs) 
    
    frames = list(map(CompressText, video_chars))
    
    total_mem = 0
    bytes = []
    
    for i in range(len(frames)):
        bytes += frames[i]
        total_mem += len(frames[i])
        if total_mem + 200> MAX_MEM:
            break
    
    bytes2mif(bytes)
    
    
    
    