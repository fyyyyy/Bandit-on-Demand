# Bandit on Demand™
Spawn bandits with your voice in DCS.

Hello
This is a universal BFM/BVR training mission/script which allows you to spawn bandits with your voice (VoiceAttack). If you don't have VoiceAttack, the F10 menu works as well but not as convenient.


![bandit on demand v2(2)(2)](https://user-images.githubusercontent.com/3744048/156612949-8a655584-b2ce-4ca7-9960-5a53ac15dfb6.png)

## COMBO voice commands:

* "Spawn four Mig 21 at 10 miles, angels 30" - 4x Mig21 will spawn on your 12'o clock at 10 miles, at 30,000 feet
* "Spawn one F-18 at 50 miles"- 1x F-18 will spawn on your 12'o clock at 50 miles, equal altitude to your aircraft
* "Spawn two A-10 on my six" - 2x A-10 will spawn on your 6'o clock at 1 mile, equal altitude to your aircraft

## SETTINGS voice commands:

* "Missiles On/Off" - bandits spawn with missiles or guns
* "Sam sites On/Off" - turns SAM sites on / off
* "Set enemy count 4" - next wave will spawn 4 bandits
* "Set enemy skill (average good high ace)" 
* "Set enemy type (F16 F18 F15 F14 SU27 SU30 MIG29 MIG31 MIG21 A10 Bf109 A4 F5 Fw190 I16 MiG15 MiG19 Mosquito P51D Spitfire)" - Sets enemy aircraft type for next spawn
* "Set enemy distance (1-150) miles" - Sets enemy distance to 1,5,10.25,50,75,100,150 miles
* "Set enemy distance on my six" - next wave will spawn 1 mile on your 6'o clock
* "Set bandit angels (1,5,10,15,20,25,30,40,50)" - Next bandits will spawn at 1,000, 5,000, 10,000, 15,000, 20,000, 25,000, 30,000, 40,000 or 50,000 feet
* "Set bandit angels same as me" - Next bandits will spawn at your altitude
* "Set bandit altitude 30 thousand feet" - Next bandits will spawn at 30,000 feet
* "Set bandit altitude equal - Next bandits will spawn at your altitude
* "Spawn random group" - spawns 1-4 random bandits at previous distance
* "Spawn enemy group" - spawns bandits with current/last used settings

 

It gets pretty intense at times. AI skill level is ace by default, but can be changed to average / good / high. Adding more support to choose skill and fuel level of bandits. Im still learning the Tomcat and needed more "engagements" to practice, so I extended sesksa's script with more functionalty and created VoiceAttack commands.

## VoiceAttack

Voice Profile .vap : import in VoiceAttack. **Unbind** **F11** and **F12** keys, so that the radio menu can be operated from anywhere without switching to external views.

## Adding Bandit on Demand™ to your map:

The script bandit_on_demand.lua can be added to any map. mist_4_5_106 is required.
