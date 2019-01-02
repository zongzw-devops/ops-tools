import os
import sys

'''
python joinfiles.py <target> <file list ...>
'''
if len(sys.argv) <= 1:
    print("file list cannot be empty.")
    sys.exit(1)

target = sys.argv[1]
filelist = sys.argv[2:]

print("file list: %s" % filelist)

for n in filelist: 
    if not os.path.isfile(n):
        print("file invalid: %s" % n)
        sys.exit(1)

rwsize = 1024 * 1024 * 16

with open(target, 'wb') as fw:
    for n in filelist:
        with open(n, 'rb') as fr:
            while True: 
                content = fr.read(rwsize)
                if not content: break
                
                fw.write(content)

