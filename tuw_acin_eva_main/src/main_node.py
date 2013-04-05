#!/usr/bin/env python

import roslib; roslib.load_manifest('tuw_acin_eva_main')
import rospy
from std_msgs.msg import String
from tuw_acin_eva_msgs.msg import * 
from tuw_acin_eva_people.srv import *

# global variable definition
global_command = 0
global_parameters = ['empty']
command_list_de = ["none", "lerne", "entferne", "nenne", "eva", "stop", "folge"]
command_list_en = ["none", "learn", "remove", "rename", "eve", "stop", "follow"]

def callback(msg):
	global global_command, global_parameters
	global command_list_en, command_list_de
	global pub
	
	lang, msg_string, seq = msg.data.split(',')
	# print msg_string
	command, sep, tmp = msg_string.partition(' ')
	global_parameters = tmp.split(' ')

	# print "command: %s parameters: %s"%(command, global_parameters)
	try:
		if lang == "de_DE":
			global_command = command_list_de.index(command)
		elif lang == "en_US":
			global_command = command_list_en.index(command)
		else: 
			rospy.loginfo("No voice command received yet!")
	except Exception, e:
		global_command = 0
		rospy.loginfo("Unknown command received: %s",e)

	pub.publish(int(global_command), global_parameters)
#	executeService()

#def executeService():
#    print "Waiting for service"
#    rospy.wait_for_service('PeopleCommands')
#    try:
#        send_command = rospy.ServiceProxy('PeopleCommands', PeopleCommands)
#        resp = send_command(global_command, global_parameters)
#	print "Service called :-)"
#        return resp.status
#    except rospy.ServiceException, e:
#        print "Service call failed: %s"%e

if __name__ == '__main__':
	#	pub = rospy.Publisher('/tuw_acin_eva/face_to_follow', String)
	rospy.init_node('main_node')
	rospy.Subscriber("tuw_acin_eva/voice_commands", String, callback)
	pub = rospy.Publisher('/tuw_acin_eva/processed_commands', ProcessedCommands)
	pub.publish(int(0), "None")
	print "TU Wien Eva Main node is ready!"
	while not rospy.is_shutdown():
		#		executeService()
		rospy.sleep(1.0)

