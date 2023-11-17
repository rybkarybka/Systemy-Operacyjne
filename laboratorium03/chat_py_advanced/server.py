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

# sending message to everyone except client that sent that mess
def send_mess(client, mess):
    for k,v in clients.items():
        if v != client:
            try:
                v.send(mess)
            except:
                clients.pop(k)
                break


# handle mess from clients
def handle(nick):
    while True:
        try:
            mess = clients[nick].recv(1024)
            send_mess(clients[nick], mess)
        except:
            # remove, close and send mess that client is no more
            if nick in clients.keys():
                send_mess(clients[nick], f'{nick} left the chat ...')
                clients[nick].close()
                clients.pop(nick)
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
        clients[nickname] = client

        # print nickname on server and broadcast new client
        print(f'{nickname} connected to server!')
        send_mess(client, f'{nickname} just joined the chat!!'.encode('utf-8'))
        client.send('Connected to the server!'.encode('utf-8'))

        # each client runs on 1 thread
        thread = threading.Thread(target=handle, args=(nickname,))
        thread.start()

print("Server is listening ...")
receive_mess()
