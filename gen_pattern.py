from PIL import Image

#打开图片
im = Image.open(r'src.jpg')

#图片宽度，高度
width,height = im.size

#将RGB转化成灰阶图像，灰阶8位像素，0~255， 0：白 1：黑
im = im.convert('L')

#等比例放缩
im.thumbnail((width//3,height//3))
width,height = im.size

txt = ""

#getpixel获取像素值，pattern 值只能是0或1， 将灰度小于200的归于白色
for i in range(height):
    for j in range(width):
        txt += '1' if im.getpixel((j,i)) <= 200 else '0'
    txt += '\n'

#保存pattern
with open(r'patter.txt','w') as f:
    f.write(txt)
