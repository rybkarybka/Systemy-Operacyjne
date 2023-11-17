#!/usr/bin/python

import socket
import threading

# choose nickname
nick = input('Choose your nickname: ')

# connect to server
client = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
client.connect(('127.0.0.1', 21370))


def close(c):
    print('Disconnected from the server')
    c.close()


def receive():
    while True:
        try:
            # trying to receive mess from server
            mess = client.recv(1024).decode('utf-8')
            if mess == 'NICK':
                client.send(nick.encode('utf-8'))
            else:
                print(mess)
        
        except:
            # close connection
            client.close()
            break


def write():
    while True:
        try:
            mess = f'{nick}> {input()}'
            client.send(mess.encode('utf-8'))
        except:
            close(client)
            break


receive_thread = threading.Thread(target=receive)
receive_thread.start()

write_thread = threading.Thread(target=write)
write_thread.start()
