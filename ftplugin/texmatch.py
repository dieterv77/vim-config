import vim

endstr = r'\end{'
beginstr = r'\begin{'

def mySearch(line, endindex, mycount):
   i1 = line.rfind(endstr, 0, endindex)
   i2 = line.rfind(beginstr, 0, endindex)
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
         rindex = cline.find('}',result,endindex)
         envname = cline[result+len(beginstr):rindex]
         vim.command('normal '+'a\\end{%s}' % envname)
         break
      endindex = result
      result = mySearch(cline, endindex, mycount)
   if done:
      break
         




