#!/usr/bin/env python
# ROS imports
import roslib; roslib.load_manifest('tuw_acin_eva_main')
import rospy
from std_msgs.msg import String
from tuw_acin_eva_msgs.msg import *
# standard python imports
import re

# the configfiles which contain essential informations like objects, color, etc. 
cmdfile = "commands.txt"
colorfile = "colors.txt"
sizefile = "sizes.txt"
objectfile = "objects.txt"

# global arrays
cmd_ger = []
cmd_eng = []
sizes = []
colors = []
objects = []

# default language 
language = "german"

debug = False
def load_commands(cmdfile):
	temp = []
	with open(cmdfile) as f:
		for line in f:
			german, english, code = line.strip().split('%')
			if language == "german":
				temp.append((german.lower()[:-1], code))
			elif language == "english":
				temp.append((english.lower()[:-1], code))
	return temp

def load_commands2(cmdfile):
	temp1 = []
	temp2 = []
	with open(cmdfile) as f:
		for line in f:
			german, english, code = line.strip().split('%')
			temp1.append((german.lower()[:-1], code))
			temp2.append((english.lower()[:-1], code))
	return temp1, temp2

def load2(filename):
	temp = []
	with open(filename) as f:
		for line in f:
			english,german = line.strip().split('%')
			temp.append((english, german))
	return temp

def speechCallback(data):
	global cmd_ger, cmd_eng, sizes, colors, objects, language
	# store result and a temporary list of possible recognized commands
	commands = []
	list_ = []
	command = 0
	params = []
	recognized = False

	lang,speech,index = data.data.lower().split(',')
	if lang == "de_de":
		language = "german"
		commands = cmd_ger
		params.append("german")
		if debug:
			print "GERMAN"
	elif lang == "en_us":
		language = "english"
		commands = cmd_eng
		params.append("english")
		if debug:
			print "ENGLISH"
	else:
		rospy.loginfo("No voice command received yet!")

	if debug:
		print "german command: %s"%str(cmd_ger)
		print "english command: %s"%str(cmd_eng)
		print "commands: %s"%str(commands)
		print "sizes: %s"%str(sizes)
		print "colors: %s"%str(colors)
		print "objects: %s"%str(objects)

	msgs = filter(None, speech.split('#'))

	if debug:
		print "received messages"
		print msgs
	# parse all receieved messages and correlate them with known commands
	# which have the same amount of words
	for msg in msgs:
		msg_len = len(re.findall(r'\w+', msg)) 
		for j in commands:
			cmd_len = len(re.findall(r'\w+', j[0]))
			if msg_len == cmd_len:
				list_.append((msg,j))

	# process the resulting list of known commands to find the received
	# command and their parameters
	for candidates in list_:
		if debug:	
			print "processing received commands: . . ."
			print candidates

		# process commands without keywords
		if candidates[0] == candidates[1][0]:
			recognized = True
			command = int(candidates[1][1])
			break
		else:
			if debug:
				print "NEXT candidate . . ."

	if not recognized:
		for candidates in list_:
			msg_len = len(re.findall(r'\w+', candidates[0]))
			if debug:
				print "number of words in msg: %i"% msg_len
			if (msg_len == 2) or (msg_len == 3):
				if not candidates[0] == candidates[1][0]:
					shortmsg = candidates[0].split()[:-1]
					shortcmd = candidates[1][0].split()[:-1]
					if shortmsg == shortcmd:
						command = int(candidates[1][1])
						params.append(candidates[1][0].split()[-1:])
						params.append(candidates[0].split()[-1:])
						recognized = True

	if not recognized:
		for candidates in list_:
		# process keyword _colors_
			try:
				idx = candidates[1][0].index("_color_")
				if candidates[0][0:idx] == candidates[1][0][0:idx]:
					recognized = True
					#print candidates[1][0].split()
					idxc=candidates[1][0].split().index("_color_")
					idxo=candidates[1][0].split().index("_object_")
					# change color descriptions in german from blaue to blau, rotes to rot
					color = candidates[0].split()[idxc]
					for i in colors:
						if i[1] in candidates[0].split()[idxc]:
							color = i[1]
					command = int(candidates[1][1])
					params.append(str(candidates[1][0].split()[idxc])+"#"+str(color))
					params.append(str(candidates[1][0].split()[idxo])+"#"+str(candidates[0].split()[idxo]))
					#params.append((candidates[1][0].split()[idxc],color))
					#params.append((candidates[1][0].split()[idxo],candidates[0].split()[idxo]))
					if debug:
						print "command found:"
						print candidates
					break
				else: 
					print "command not yet recognized"
			except ValueError:
				if debug:
					print "No color in command found"
		
	print "command number: %i"%command
	print "parameters: %s"%str(params)

	if not recognized:
		print "Sorry. I did not recognize this command."
	
	pub = rospy.Publisher('/tuw_acin_eva/speech_processed', ProcessedCommands)
	pub.publish(command, params)

def main():
	rospy.init_node('Eva_main_speech_processing')
	# load known commands, colors, sizes and objects from text files
	global cmd_ger, cmd_eng, commands, sizes, colors, objects, language
	commands = load_commands(cmdfile)
	cmd_ger, cmd_eng = load_commands2(cmdfile)
	sizes = load2(sizefile)
	colors = load2(colorfile)
	objects = load2(objectfile)
	rospy.loginfo("TU Wien Evas speech processing node is ready!")
	rospy.Subscriber("/tuw_acin_eva/voice_commands", String, speechCallback)
	rospy.spin()

if __name__ == '__main__':
	main()
