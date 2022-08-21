#!/bin/bash
 #author                  :Joshua Uzoma
 #CopyRights              :Landmark Technologies
 #Contact                 Joshua.Uzoma@gmail.com
 echo "Enter your Github Personal Access Token:"
 read -s token
 echo $token >token.txt
 #cat token.txt
 cat ~/.ssh/id_rsa.pub
 #if condition to validate weather ssh keys are already present or not
 if [ $? -eq 0 ]
 then
 echo "SSH Keys are already present..."
 else
 echo "SSH Keys are not present ..., Create the sshkeys using ssh-keygen command"
 ssh-keygen -t rsa
 echo "Key successfully generated"
 fi
 sshkey= `cat ~/.ssh/id_rsa.pub`
 if [ $? -eq 0 ]
 then
 echo "Copying the key to Github account"
 curl -X POST -H "Content -type: application/json" -d "{\"tilte\": \"SSHKEY\",\"Key\": \"$sshkey\"}" "https://api.github.com/user/keys?access_token=$token
 if [ $? -eq 0 ]
 then 
 echo "Succesfully copied the token to Github"
 exit 0
 else
 echo "Failed"
 exit 1
 fi
 else
 echo "Failure in generating the key"
 exit 1
 fi
