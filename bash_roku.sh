#! /bin/bash
function find_roku {
  for i in $(arp -a | awk '{print $2}' | sed "s/[(|)]//g"); do 
    curl $i:8060 &>/dev/null
    if [[ "$?" == "0" ]]; then 
      export ROKU_IP=$i
    fi
  done
}

function roku {

  if [[ ! $ROKU_IP ]]; then 
    find_roku; 
  fi;  

  if [[ ! $ROKU_IP ]]; then 
    echo "Player not found"
    return 1
  fi;  

  echo
  echo "You player is at $ROKU_IP"
  echo

  while [ TRUE ]; do
    echo
    echo "------------"
    echo "k) Up"
    echo "j) Down"
    echo "h) Left"
    echo "l) Right"
    echo "x) Play"
    echo "b) Back"
    echo "w) Quit"

    read -n 1 key
    echo "------------"
    echo

    if [[ $key == k ]]; then
      echo up
      curl -d "" http://$ROKU_IP:8060/keypress/Up
    elif [[ $key == j ]]; then
      curl -d "" http://$ROKU_IP:8060/keypress/Down
    elif [[ $key == h ]]; then
      curl -d "" http://$ROKU_IP:8060/keypress/Left
    elif [[ $key == l ]]; then
      curl -d "" http://$ROKU_IP:8060/keypress/Right
    elif [[ $key == x ]]; then
      curl -d "" http://$ROKU_IP:8060/keypress/Play
    elif [[ $key == b ]]; then
      curl -d "" http://$ROKU_IP:8060/keypress/Back
    elif [[ $key == w ]]; then
      return 0
    fi

  done
}
roku
