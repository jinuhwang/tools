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
    _print(ret.decode())

    if code >= 300:
        exit(1)

    return smtp


def send_mail(client, send_to, send_from, subject, content):
    msg = MIMEText(content)
    msg['Subject'] = subject
    msg['From'] = send_from
    msg['To'] = send_to

    client.sendmail(send_from, send_to, msg.as_string())

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
    _print = console.print

    client = smtp_login(config['id'], config['passwd'])

    df = pd.read_csv(config['csv'])
    df = df[[config['to_columns']] + config['format_columns']]

    for i, (to, *row) in track(df.iterrows(), description='Sending Email...', total=len(df)):
        formatted = config['content'].format(*row)

        _print()
        _print('Would send:')
        _print('From: ', config['from'])
        _print('To: ', to)
        _print('[bold]' + config['subject'])
        _print(formatted)

        console.input('Press Enter to continue')

        if args.fire:
            send_mail(client, to, config['from'], config['subject'], formatted)
        elif args.test:
            to = config['from']
            send_mail(client, to, config['from'], config['subject'], formatted)
