import sys
import getopt
import cli

print(sys.argv[1])
if __name__ == '__main__':
    print('This is main')
    print(len(sys.argv))
    if sys.argv[1] == 'merge':
        print('Merge file')
    else:
        print('Do nothing')