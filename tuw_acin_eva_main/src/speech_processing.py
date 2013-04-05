#!/usr/bin/env python
import roslib; roslib.load_manifest('tuw_acin_eva_main')
import rospy
from std_msgs.msg import String
from tuw_acin_eva_msgs.msg import *

# filename for possible commands
#filename = "../conf/voice_input.conf"

# some global variables
global_command = 0
global_parameters = ['empty']
#command_list_de = ["none", "lerne", "entferne", "nenne", "eva", "stop", "folge"]
#command_list_en = ["none", "learn", "remove", "rename", "eve", "stop", "follow"]
command_list_de = []
command_list_en= []

commands = []
cmd_file = "commands.txt"

debug = True

def load_commands():
        global commands
        del commands[:]
	if debug: 
		print commands
	with open(cmdfile) as f:
		for line in f:
			german, english, type_ = line.strip().split(',')
			if language == "german":
				commands.append((german, type_))
			elif language == "english":
				commands.append((english, type_))
	if debug:
		print commands



def speechCallback(data):
	load_commands()

	global commands
	global global_command, global_parameters

	pub = rospy.Publisher('/tuw_acin_eva/processed_commands', ProcessedCommands)
	pub.publish(int(0), "None")

	lang, msg, seq = data.data.split(',')
	# print msg_string
	#command, sep, tmp = msg_string.partition(' ')
	#global_parameters = tmp.split(' ')
	msgs = filter(None, msg.split('#'))
	
	# print "command: %s parameters: %s"%(command, global_parameters)
	try:
		if lang == "de_DE":
			#global_command = command_list_de.index(command)
		elif lang == "en_US":
			#global_command = command_list_en.index(command)

		else:
			rospy.loginfo("No voice command received yet!")
	except Exception, e:
		global_command = 0
		rospy.loginfo("Unknown command received: %s",e)
	
	pub.publish(int(global_command), global_parameters)


def main():
	rospy.init_node('Eva_main_speech_processing')
	rospy.loginfo("TU Wien Evas speech processing node is ready!")
	rospy.Subscriber("/tuw_acin_eva/voice_commands", String, speechCallback)
	rospy.spin()
	
if __name__ == '__main__':
	main()

