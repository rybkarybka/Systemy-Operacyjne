#!/usr/bin/python

import threading
import socket

# default ip and port
IP = '127.0.0.1'
PORT = 21370

# setting up server 
server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
server.bind((IP, PORT))
server.listen()


# dict that contains nickname and info about client
clients = {}


def disconnect(nick):
    if nick in clients.keys():
        print(f'{nick} disconnected ...')
        clients[nick].close()
        clients.pop(nick)
        send_mess(nick, f'{nick} left the chat'.encode('utf-8'))


# sending message to everyone except client that sent that mess
def send_mess(nick, mess):
    for k,v in clients.items():
        if nick != k:
            v.send(mess)
        else:
            # this else must be here
            # else sends message to client 
            # thanks that it knows wheter client disconnects or not
            v.send(''.encode('utf-8'))


# handle mess from clients
def handle(nick):
    while True:
        try:
            mess = clients[nick].recv(1024)
            send_mess(nick, mess)
        except:
            # remove, close and send mess that client is no more
            disconnect(nick) 
            break


# main function
def receive_mess():
    while True:
        # accept connection from client
        client, address = server.accept()
        print(f'Connected with {str(address)}')

        # get nickname from client
        client.send('NICK'.encode('utf-8'))
        nickname = client.recv(1024).decode('utf-8')

        # check if this nickname is taken
        if nickname in clients.keys():
            client.send(f'This nick: {nickname} is already used, you cannot join the server'.encode('utf-8'))
            print(f'Disconnected from {str(address)}')
            client.close()
            break

        else:

            clients[nickname] = client

            # print nickname on server and broadcast new client
            print(f'{nickname} connected to server!')
            send_mess(nickname, f'\n{nickname} just joined the chat!!\n'.encode('utf-8'))
            client.send('Connected to the server!'.encode('utf-8'))

            # each client runs on 1 thread
            thread = threading.Thread(target=handle, args=(nickname,))
            thread.start()

print("Server is listening ...")
receive_mess()
