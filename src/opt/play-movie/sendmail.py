#!/bin/python
import sys
import smtplib
import socket
from configobj import ConfigObj

config = ConfigObj('/etc/default/play-movie')

smtp_host=config.get('MAIL_HOST')
smtp_port=config.get('MAIL_PORT')
smtp_user=config.get('MAIL_USER')
smtp_pass=config.get('MAIL_PASS')
mail_from=config.get('MAIL_FROM')
mail_to=config.get('MAIL_TO')
mail_subject=config.get('MAIL_SUBJECT')

mail_subject=mail_subject.replace("#HOST#",socket.gethostname())
mail_body=config.get('MAIL_BODY')

# if config.get('SEND_MAIL') != 1:
# 	print "send mail disabled"
# 	sys.exit(2)

smtpserver = smtplib.SMTP(smtp_host,smtp_port)
smtpserver.ehlo()
smtpserver.starttls()
smtpserver.ehlo
smtpserver.login(smtp_user, smtp_pass)

header = 'To:' + mail_to + '\n' + 'From: ' + mail_from + '\n' + 'Subject:'+ mail_subject +'\n'
msg = header + '\n '+mail_body+' \n\n'
smtpserver.sendmail(smtp_user, mail_to, msg)
smtpserver.close()

sys.exit(0)