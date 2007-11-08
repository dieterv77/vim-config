#! /usr/bin/python

import sys
from optparse import OptionParser

def runmain(argv=None):
   if argv == None:
      argv = sys.argv
   
   usage = 'usage: %prog [options]\n'
   parser = OptionParser(usage=usage)
   parser.add_option("-f", "--file", dest="filename",
                           help="Read solution from FILE", metavar="FILE")
   (options, args) = parser.parse_args(argv)

if __name__ == "__main__":
   runmain()
