FLASH_DRIVE='H'

import os,sys,time,re

print sys.argv

PRJ = os.getcwd().split('\\')[-1] ; print 'PRJ',PRJ

NOW = '%.4i%.2i%.2i.%.2i%.2i%.2i'%time.localtime()[:6] ; print 'NOW',NOW

ARH = '%s:\\%s.%s.rar'%(FLASH_DRIVE,PRJ,NOW) ; print 'ARH',ARH

os.system('make clean')

CMD = 'rar a -r %s *'%ARH ; print 'CMD',CMD ; print os.system(CMD)

#raw_input('.')