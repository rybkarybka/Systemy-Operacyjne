#!/usr/bin/python

import threading
import socket
import random
import subprocess
import time

# default ip and port
IP = '127.0.0.1'
PORT = 21375

# setting up server 
server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
try:
    server.bind((IP, PORT))
    server.listen()
except OSError:
    print('OSError: socket already in use')
    exit()


########## global variables
clients = {}
word = ''
temp_word = ''
allowed_errors = 7
guesses = []
guess_before = ''
game = 1


################ starting new game
def start_game():
    global temp_word, allowed_errors, guesses, game
    print(f'\n\nStart of game nr {game}')
    find_word()
    temp_word = ''
    guesses = []
    allowed_errors = 7
    game += 1


def new_game():
    time.sleep(5)
    start_game()
    send_all('New game just started\nGood luck\n\n'.encode('utf-8'))


#################### printing W/L messages
def print_win_mess():
    print('Players guessed the word')
    send_all(f'Congratulations, YOU WON\nGuessed word is {word}\n\nThanks for the game\nNew gamme will start in 5 seconds'.encode('utf-8'))
    new_game()


def print_loose_mess():
    print('Players did not guess the word')
    send_all(f'Better luck next time, your word was:\n{word}\n\nThanks for the game\n'.encode('utf-8'))
    new_game() 


################### functions to disconnect people
def disconnect(nick):
    if nick in clients.keys():
        print(f'{nick} disconnected ...')
        clients[nick].close()
        clients.pop(nick)
        send_mess(nick, f'{nick} left the game'.encode('utf-8'))


#################### sending messages
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


def send_all(mess):
    for _,v in clients.items():
        v.send(mess)


# choose word to play with
def find_word():
    global word
    x = random.randint(1, 3185955)
    temp_word = subprocess.check_output(f'head -n {x} slowa.txt | tail -1', shell=True).strip().decode('utf-8')
    if len(temp_word) <= 5: find_word()
    word = ''
    for letter in temp_word:
        word += f'{letter} '
    print(f'The Chosen One: {word}')


# handle mess from clients
def handle(nick):
    global allowed_errors, temp_word, guesses, guess_before, game
    while True:
        temp_game = game
        try:
            # update current state of guessed word
            temp_word = ''
            for letter in word:
                if letter.lower() in guesses: temp_word += f'{letter} '
                elif letter == ' ': pass
                else: temp_word += '_ '

            # find out if word was guessed
            if temp_word == word:
                guess_before = guesses[-1]
                print_win_mess()
            else:
                send_all(f'You can make {allowed_errors} errors\nYour word: {temp_word}\n'.encode('utf-8'))

            # receive message from client
            mess = clients[nick].recv(1024).decode('utf-8')
            mess = mess.strip()

            # check if this is mess from the previous game
            if temp_game == game:
                # check if player is guessing whole word or just 1 letter
                if len(mess) < 2:
                    if mess in guesses:
                        allowed_errors -= 1
                        send_all(f'PLayer {nick} tried to guess letter that already was guessed: {mess}\n'.encode('utf-8'))
                    else: 
                        guesses.append(mess.lower())
                        if mess.lower() not in word.lower():
                            allowed_errors -= 1
                            send_all(f'Player {nick} did not guess the letter, letter used: {mess}\n'.encode('utf-8'))

                else:
                    try_guess = ''
                    for letter in mess:
                        try_guess += f'{letter} '

                    if try_guess == word:
                        guess_before = try_guess
                        print_win_mess()
                    else:
                        allowed_errors -= 1
                        send_all(f'Player {nick} did not guess the word, word used: {mess}\n'.encode('utf-8'))

                if allowed_errors < 0:
                    guess_before = guesses[-1]
                    print_loose_mess()

        except:
            # remove, close and send mess that client is no more
            disconnect(nick) 
            break


# main function
def receive_mess():
    while True:
        # accept connection from client
        client, address = server.accept()
        print(f'\n\nConnected with {str(address)}')

        # get nickname from client
        client.send('NICK'.encode('utf-8'))
        nickname = client.recv(1024).decode('utf-8')
        clients[nickname] = client

        # print nickname on server and broadcast new client
        print(f'{nickname} connected to server!')
        send_mess(nickname, f'\n{nickname} just joined the game!!\n'.encode('utf-8'))
        client.send('Connected to the server!'.encode('utf-8'))

        # each client runs on 1 thread
        thread = threading.Thread(target=handle, args=(nickname,))
        thread.start()

print(f'{"*" * 5} Hangman the Game {"*" * 5}')
start_game()
# find_word()
receive_mess()
