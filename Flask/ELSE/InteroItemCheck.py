# coding=utf-8
import re

# 正则匹配电话号码
# phone="13893670000"
def isPhoneNumber(inputStr = None):
    if inputStr:
        phone = str(inputStr)
        if len(phone) != 11:
            return None
        p2 = re.compile("^1[3578]\d{9}$|^147\d{8}")
        phone_match = p2.match(phone)
        if phone_match:
            return phone_match.group()
        else:
            return None
    else:
        return None

def isMailBox(inputStr = None):
    if inputStr:
        mailbox = str(inputStr)
        p2 = re.compile("[^\._-][\w\.-]+@(?:[A-Za-z0-9]+\.)+[A-Za-z]+$")
        mailbox_match = p2.match(mailbox)

        if mailbox_match:
            return mailbox_match.group()
        else:
            return None
    else:
        return None

def passwordValid(inputStr = None):
    if inputStr:
        password = str(inputStr)
        p2 = re.compile("/^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,20}$/")
        password_match = p2.match(password)

        if password_match:
            return password_match.group()
        else:
            return None
    else:
        return None
