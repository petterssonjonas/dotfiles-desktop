#!/usr/bin/python

import imaplib
import re

M=imaplib.IMAP4_SSL("fuzebox@bahnhof.se", 993)
M.login("mc601696","budw3iser..")

status, counts = M.status("INBOX","(MESSAGES UNSEEN)")

if status == "OK":
	unread = re.search(r'UNSEEN\s(\d+)', counts[0].decode('utf-8')).group(1)
else:
	unread = "N/A"

print(unread)
