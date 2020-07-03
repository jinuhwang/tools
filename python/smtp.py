#!/bin/env python3
import smtplib
import numpy as np
import pandas as pd
from email.mime.text import MIMEText
import argparse

my_id = 'jinwooh'  # YOUR ID
my_pw = input('Password: ')  # YOUR PW

parser = argparse.ArgumentParser(description='script to send emails to students')
parser.add_argument('students', type=str,
                    help='path to the CSV file holding student info')
parser.add_argument('teams', type=str,
                    help='path to the CSV file holding team info')
parser.add_argument('passwd', type=str,
                    help='path to the CSV file holding password info')
parser.add_argument('-f', '--fire', help='confirm to fire the emails',
                    action='store_true')

def email():
    students = pd.read_csv(args.students, dtype=(object))
    teams = pd.read_csv(args.teams, dtype=(object))
    passwds = pd.read_csv(args.passwd, dtype=(object))

    smtp = smtplib.SMTP('mail.kaist.ac.kr', 587)
    smtp.ehlo()
    smtp.starttls()
    print(smtp.login(my_id, my_pw))
    input()

    n = 1;
    for row_num, team in teams.iterrows():
        if row_num < 55:
            continue
        for i in range(2):
            if pd.isnull(team['Student ID 1']):
                break

            if pd.isnull(team['Student ID 2']):
                teammate = 'Solo Team'
                email = ''

            else:
                if i == 0:
                    teammate = team['Student ID 2']
                    email = students.loc[np.where(students['학번'] == team['Student ID 2'])]['이메일 주소'].values[0]
                else:
                    teammate = team['Student ID 1']
                    email = students.loc[np.where(students['학번'] == team['Student ID 1'])]['이메일 주소'].values[0]
                email = ' / e-mail: ' + email

            ip = team['Server IP']
            port = team['Server Port']
            userid = passwds.loc[np.where(team['Team Number'] == passwds['Team Number'])]['Username'].values[0]
            pw = passwds.loc[np.where(team['Team Number'] == passwds['Team Number'])]['Password'].values[0]
            cont = f'''Hi, this is your CS330 TA,

The following is your team's account information to the extra server.

Note that you will get penalty if you access the server without reserving a time slot.
Please refer to the Piazza note @572 for detail
https://piazza.com/class/k7ov1jagacl3j3?cid=572

Team number: {userid}
Teammate: {teammate}{email}
Server IP: To be announced via Piazza
Server Port: To be announced via Piazza
User ID: {userid}
Initial Password: {pw}

Same as before,
You should use KVPN when accessing the server from outside campus.
You should login using user ID instead of root.
If you encounter any problem, please contact via cs330_ta@casys.kaist.ac.kr

Regards,
Jinwoo Hwang
'''
            msg = MIMEText(cont)
            msg['Subject'] = '[CS330] Extra Server Account Info'
            msg['From'] = 'jinwooh@kaist.ac.kr'
            to = students.loc[np.where(students['학번'] == team['Student ID '+str(i+1)])]['이메일 주소'].values[0]
            msg['To'] = to

            if args.fire:
                print(smtp.sendmail('jinwooh@kaist.ac.kr', to,  msg.as_string()))

            print(cont)
            print('Sent to ' + to)
            input()
            n = n + 1
            if pd.isnull(team['Student ID 2']):
                break;

if __name__ == '__main__':
    args = parser.parse_args()
    email()
