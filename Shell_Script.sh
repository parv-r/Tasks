#!/bin/bash
echo "Enter the username: "
read username
if [ $username == "user" ]
then
   echo "Enter the password: "
   read password
   if [ $password == "pass" ]
   then
      echo -e "You're Logged In\n"
   else
      echo -e "Invalid Password\n"
      exit 0
    fi
else
   echo -e "Invalid Username\n"
   exit 1
fi