#! /usr/bin/python

from optparse import OptionParser

def runmain(argv=None):
   if argv == None:
      argv = sys.argv
   
   usage = 'usage: %prog [options]\n'
   parser = OptionParser(usage=usage)
   (options, args) = parser.parse_args(argv)

if __name__ == "__main__":
   runmain()
