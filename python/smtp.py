import smtplib
import numpy as np
import pandas as pd
from email.mime.text import MIMEText

my_id = 'jinwooh'  # YOUR ID
my_pw = ''  # YOUR PW

def email():
    students = pd.read_csv('/home/jinu/Downloads/students.csv', dtype=(object))
    teams = pd.read_csv('/home/jinu/Downloads/team.csv', dtype=(object), skiprows=1)

    smtp = smtplib.SMTP('mail.kaist.ac.kr', 587)
    smtp.ehlo()
    smtp.starttls()
    print(smtp.login(my_id, my_pw))
    input()

    n = 1;
    for row_num, team in teams.iterrows():
        if row_num < 56:
            continue

        for i in range(2):
            if pd.isnull(team['Student ID_1']):
                break

            if pd.isnull(team['Student ID_2']):
                teammate = 'Solo Team'
                email = ''

            else:
                if i == 0:
                    teammate = team['Student ID_2']
                    email = students.loc[np.where(students['학번'] == team['Student ID_2'])]['이메일 주소'].values[0]
                else:
                    teammate = team['Student ID_1']
                    email = students.loc[np.where(students['학번'] == team['Student ID_1'])]['이메일 주소'].values[0]
                email = ' / e-mail: ' + email

            ip = team['Server IP']
            port = team['Server Port']
            userid = team['User ID']
            pw = team['Initial Password']
            cont = f'''There was an issue with the email.
My apologies for the ones who got duplicate emails.

You should use KVPN when accessing the server from outside campus.
You should login using user ID instead of root.

Your team has been assigned as following:

Team number: {userid}
Teammate: {teammate}{email}
Server IP: {ip}
Server Port: {port}
User ID: {userid}
Initial Password: {pw}

Please change the password after you login.

Again, sorry for the inconvenience.

Regards,
Jinwoo Hwang
'''
            msg = MIMEText(cont)
            msg['Subject'] = '[CS330] Pintos Team Assignment'
            msg['From'] = 'jinwooh@kaist.ac.kr'
            to = students.loc[np.where(students['학번'] == team['Student ID_'+str(i+1)])]['이메일 주소'].values[0]
            msg['To'] = to

            # smtp.sendmail('jinwooh@kaist.ac.kr', to,  msg.as_string())

            # print(n, ' : ', msg.as_string())
            # input()
            n = n + 1
            if pd.isnull(team['Student ID_2']):
                break;

if __name__ == '__main__':
    email()
