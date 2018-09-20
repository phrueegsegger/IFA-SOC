#!/bin/bash

################################################################################
################### TOOL - XXX - under GPLv3                  ###################
################### by Rüegsegger Philipp                     ###################
################### From the freecybersecurity.org Project    ###################
################### Thanks to the community!                  ###################
#################################################################################


# airmon-ng start wlan0
# airmon-ng check kill
# airodump-ng wlan0mon

start-airmon() {
    airmon-ng start wlan0
    airmon-ng check kill
    clear
}


#main
start-airmon


filter="((wlan.fc.type_subtype==0x04)&&!(wlan.tag.data=="'""'"))"

# tshark -i wlan0mon -T fields -e frame.time_relative \
#       -e wlan.sa -e wlan.da -e wlan_radio.signal_dbm \
#       -e wlan.ssid -Y $filter