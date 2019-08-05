import os
import sys

'''
splitfile.py <file> <count>
'''

if len(sys.argv) != 3:
    print("Usage: <file> <count>")
    sys.exit(1)

if not os.path.isfile(sys.argv[1]):
    print("Error: filepath not found or not a file: '%s'" % sys.argv[1])
    sys.exit(1)
filepath = sys.argv[1]

if len(sys.argv[2]) != len("%d" % int(sys.argv[2])):
    print("Error: argv 2 should be number: %s" % sys.argv[2])
    sys.exit(1)
count = int(sys.argv[2])
if count < 1: count = 1

print("task information: %s %d" % (filepath, count))

filesize = os.path.getsize(filepath)
targetpath = os.path.dirname(filepath)
targetpref = os.path.basename(filepath)
print("file information: path: %s, name: %s, size: %d" % (targetpath, targetpref, filesize))


block_size = int(filesize / count) + 1

min_rwsz = 1024
max_rwsz = 1024 * 1024

rwsize = min_rwsz if block_size < min_rwsz else max_rwsz if block_size > max_rwsz else block_size

print("rw size per time: %s " % rwsize)

index = 0
with open(filepath, 'rb') as fr:
    while fr.tell() < filesize:
        target = os.path.join(targetpath, "%s.%03d" % (targetpref, index))
        print("writing to %s" % target)

        perfilesize = 0
        with open(target, 'wb') as fw:
            while perfilesize < block_size:
                content = fr.read(rwsize)
                if not content:
                    break
                
                fw.write(content)
                perfilesize += rwsize
            
            index += 1
