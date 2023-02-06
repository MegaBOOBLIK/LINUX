#!/bin/bash
# Дружим машины по SSH
clear
echo "Ничего не писать! Нажать 3 раза ENTER !!! и пароль..."
ssh-keygen -t dsa
ssh-copy-id -i ~/.ssh/id_dsa.pub main@192.168.1.5


