import pandas as pd
import paramiko

df = pd.read_csv('server.csv')


ssh = paramiko.SSHClient()
ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
for rows, server in df.iterrows():
    ip = server['IP']
    port = server['SSH']
    passwd = server['root PW']
    user = server['User']
    if not user.startswith('team'):
        print(ip, port, ': Not a team server, skip')
        continue

    try:
        ssh.connect(ip, port=port, username='root', password=passwd)

    except:
        print(ip, port, ': Authentication failed')
        continue

    try:
        ssh_stdin, ssh_stdout, ssh_stderr = ssh.exec_command('ls /home | wc -w | grep "^1$" > /dev/null && usermod --expiredate 1 ' + user)
        for line in ssh_stdout:
            print(user, ip, port, line)
        for line in ssh_stderr:
            print(user, ip, port, line)

    except:
        print(ip, port, ': Command failed')

    ssh.close()


