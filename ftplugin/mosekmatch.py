import vim
import re

begregex = re.compile(r'\[(?!/).*?\]')
endregex = re.compile(r'\[/.*?\]')

def mySearch(line, endindex, mycount):
   endresit = endregex.finditer(line,0, endindex)
   endres = [res for res in endresit]
   if len(endres) == 0:
      i1 = -1
   else:
      i1 = endres[-1].start()
   begresit = begregex.finditer(line,0, endindex)
   begres = [res for res in begresit]
   if len(begres) == 0:
      i2 = -1
   else:
      i2 = begres[-1].start()
#   i1 = line.rfind(endstr, 0, endindex)
#   i2 = line.rfind(beginstr, 0, endindex)
   if i1 == -1 and i2 == -1:
      return -1
   elif i1 < i2:
      mycount[1] += 1
      return i2
   elif i2 < i1:
      mycount[0] += 1
      return i1

lineno, col = vim.current.window.cursor
cb = vim.current.buffer
mycount = [0,0]
done = False
for index in reversed(range(0,lineno)):
   cline = cb[index]
   if index == (lineno - 1):
      endindex = col
   else:
      endindex = len(cline)
   result = mySearch(cline, endindex, mycount)
   while result != -1:
      if mycount[1] > mycount[0]:
         done = True
         rindex = cline.find(']',result,endindex)
         envname = cline[result+1:rindex].split()[0]
         vim.command('normal '+'a[/%s]' % envname)
         break
      endindex = result
      result = mySearch(cline, endindex, mycount)
   if done:
      break
         




