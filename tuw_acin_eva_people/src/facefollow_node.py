#!/usr/bin/env python

import math
import roslib; roslib.load_manifest('tuw_acin_eva_people')
import rospy
from tuw_acin_eva_msgs.msg import *
from tuw_acin_eva_servo.msg import ServoPos
from std_msgs.msg import String
from cob_people_detection_msgs.msg import DetectionArray 
	
first_name = True 
first_follow = True
TILT_SPEED_MIN = 3
PAN_SPEED_MIN = 3
pan = 0.0
tilt = 0.0

def followFace(data):
	pub = rospy.Publisher("tuw_acin_eva/servo/pos", ServoPos)
	global name, first_follow
	global pan, tilt
	if first_follow:
		rospy.loginfo("RECEIVED: image data")
		first_follow = False
		tilt = 10.0
		pan = 0.0
	if name == "none":
		rospy.loginfo("No face selected")
	else:
		try: 
			for item in data.detections:
				rospy.loginfo("name in detection: %s, name to follow: %s",item.label, name)
				if item.label == name:
					tilt = 2.0 + (math.atan2(item.pose.pose.position.y, item.pose.pose.position.z ) * 180/math.pi)
					pan  = 2.0 + (math.atan2(item.pose.pose.position.x, item.pose.pose.position.z ) * 180/math.pi)
					if tilt < -1.0:
						tilt = math.fabs(tilt)
					if pan > 1.0:
						pan = math.fabs(pan)
					rospy.loginfo("pan: %s, tilt: %s", pan, tilt)
				else: 
					# execute actionlib which moves the head around its whole xy-range to find the person.
					rospy.loginfo("%s not found. Look around to find ...", name)
					

		except Exception, e:
			rospy.loginfo("%s", e)
		pub.publish(tilt_angle = tilt, pan_angle = pan, tilt_speed = TILT_SPEED_MIN , pan_speed = PAN_SPEED_MIN)

def setName(data):
	global name
	global first_name
	if first_name:
		rospy.loginfo("RECEIVED: person name")
		first_name = False
	if not data.data == name:
		rospy.loginfo("person to follow: %s", data.data)
	name = data.data

def processCommand(msg):
	global name
	# first unpack the message and check if it is relevant for us
	command = msg.command
	parameters = msg.parameters
	# command to follow a person is an integer value of 6
	if command == int(6):
		name = parameters[0]
	else:
		name = "None"
	rospy.loginfo("Person to follow: %s", name)


if __name__ == '__main__':
	name = "None"
	rospy.init_node('facefollow_node')
	rospy.loginfo("TU Wien Eva facefollow node is ready!")
	rospy.loginfo("You should receive two (2) RECEIVED notifications if everything is working")
#	rospy.Subscriber("tuw_acin_eva/face_to_follow", String, setName, queue_size=1)
	rospy.Subscriber("tuw_acin_eva/processed_commands", ProcessedCommands, processCommand, queue_size=1)
	rospy.Subscriber("cob_people_detection/detection_tracker/face_position_array", DetectionArray, followFace)
	rospy.spin()
