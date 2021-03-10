#!/bin/env python3
import smtplib
import numpy as np
import pandas as pd
from email.mime.text import MIMEText
import argparse
import yaml
from rich.progress import track
from rich.console import Console


def smtp_login(id, passwd):
    smtp = smtplib.SMTP('mail.kaist.ac.kr', 587)
    smtp.ehlo()
    smtp.starttls()
    code, ret = smtp.login(id, passwd)
    print(ret.decode())

    if code >= 300:
        exit(1)

    return smtp


def send_mail(send_to, send_from, subject, content):
    msg = MIMEText(content)
    msg['Subject'] = subject
    msg['From'] = send_from
    msg['To'] = send_to

    code, ret = smtp.sendmail(send_from, send_to, msg.as_string())
    print(ret.decode())

    if code >= 300:
        exit(1)


if __name__ == '__main__':
    parser = argparse.ArgumentParser(
        description='script to send emails to students')
    parser.add_argument(
        'CONFIG', help='Path to YAML file containing configuration', type=str)
    parser.add_argument('-f', '--fire', help='Confirm to fire the emails',
                        action='store_true')
    parser.add_argument('-t', '--test', help='Test script by sending email to myself',
                        action='store_true')
    args = parser.parse_args()
    config = yaml.load(open(args.CONFIG))
    console = Console()

    client = smtp_login(config['id'], config['passwd'])

    df = pd.read_csv(config['csv'])
    df = df[[config['to_columns']] + config['columns']]

    for i, (to, *row) in track(df.iterrows(), description='Sending Email...'):
        formatted = config['content'].format(*row)

        if args.fire:
            send_mail(to, config['from'], config['subject'], formatted)
        elif args.test:
            to = config['from']
            send_mail(to, config['from'], config['subject'], formatted)
        else:
            print('Would send:')
            print('From: ', config['from'])
            print('to: ', to)
            console.rule('[bold]' + config['subject'])
            print(formatted)

        console.input('Press Enter to continue')
