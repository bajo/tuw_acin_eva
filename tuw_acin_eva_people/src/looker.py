#!/usr/bin/env python

import math
import roslib; roslib.load_manifest('tuw_acin_eva_people')
import rospy
import actionlib
from tuw_acin_eva_people.msg import *
from tuw_acin_eva_servo.msg import * 

TILT_SPEED_LIMIT = 4
PAN_SPEED_LIMIT  = 4
IMAGE_SIZE_X     = 640
IMAGE_SIZE_Y     = 480

class DoHeadMove(object):
	# create messages that are used to publish feedback/result
	_feedback = tuw_acin_eva_people.msg.DoHeadMoveFeedback()
	_result   = tuw_acin_eva_people.msg.DoHeadMoveResult()
	#_speed    = tuw_acin_eva_servo.msg.ServoSpeed
	_speed    = []
	_pub      = rospy.Publisher("/tuw_acin_eva/servo/speed", ServoSpeed)
#	_sub      = rospy.Subscriber("/tuw_acin_eva/servo/cur_head_pos", ServoPos, sub_cb)

	def sub_cb(self, msg):
		self._feedback.current_pos[0] = msg.pan_angle 
		self._feedback.current_pos[1] = msg_tilt_angle
		rospy.loginfo("got message")

	def __init__(self, name):
		print "init ..."
		self._action_name = name
		self._speed.append(0)
		self._speed.append(0)
		#self._sub = rospy.Subscriber("/tuw_acin_eva/servo/cur_head_pos", ServoCurPos, self.sub_cb)
		self._feedback.current_pos.append(0.0)
		self._feedback.current_pos.append(0.0)
		self._as = actionlib.SimpleActionServer(self._action_name, tuw_acin_eva_people.msg.DoHeadMoveAction, execute_cb=self.execute_cb, auto_start=False)
		self._as.start()

	def execute_cb(self, goal):
		# helper variables
		r = rospy.Rate(1)
		success = True

		# publish info to the console for the user
		rospy.loginfo('%s: Executing, evas current head position is: pan: %f tilt: %f' % (self._action_name, self._feedback.current_pos[0], self._feedback.current_pos[1]))

		# start executing the action
		while(True):
			if self._as.is_preempt_requested():
				rospy.loginfo('%s: Preempted' % self._action_name)
				self._as.set_preempted()
				success = False
				break
			# we are close enough stop pan movement
			if goal.target_pos[0] -1  < self._feedback.current_pos[0] < goal.target_pos[0] + 1:
				self._speed[0] = 0
			# we are close enough stop tilt movement
			if goal.target_pos[1] -1  < self._feedback.current_pos[1] < goal.target_pos[1] + 1:
				self._speed[1] = 0

			if self._feedback.current_pos[0] < 0: 
				rospy.loginfo('pan neg')
				self._speed[0] = -PAN_SPEED_LIMIT
				self._feedback.current_pos[0] = self._feedback.current_pos[0] - 1 
			else: 
				rospy.loginfo('pan pos')
				self._speed[0] = PAN_SPEED_LIMIT
				self._feedback.current_pos[0] = self._feedback.current_pos[0] + 1
			
		#	if self._feedback.current_pos[1] < 0: 
		#		self._speed[1] = -TILT_SPEED_LIMIT
		#		self._feedback.current_pos[1] = self._feedback.current_pos[1] - 1 
		#	else: 
		#		self._speed[1] = TILT_SPEED_LIMIT
		#		self._feedback.current_pos[1] = self._feedback.current_pos[1] + 1

			# else we have to move the haed with a reasonable speed in the correct direction

			rospy.loginfo('%s: Executing, evas current head position is: pan: %f tilt: %f' % (self._action_name, self._feedback.current_pos[0], self._feedback.current_pos[1]))
			rospy.loginfo('%s: Executing, evas target head position is:  %f, %f' % (self._action_name, goal.target_pos[0], goal.target_pos[1]))
			rospy.loginfo('')
			#rospy.loginfo('%s: Executing, evas head speed: pan: %f, tilt: %f' % (self._action_name, self._speed[0], self._speed[1]))

		
			# this is the publisher that moves the head. 
			# will activate it when the actionserver part is ready and working
			# pub.publish(tilt_angle = self._speed[1], pan_angle = self._speed[0], tilt_speed = TILT_SPEED_LIMIT , pan_speed = PAN_SPEED_LIMIT)
			# pub.publish(pan_speed = self._speed[0], tilt_speed = self._speed[1])

			# publish the feedback
			self._as.publish_feedback(self._feedback)
	
			# this step is not necessary, the sequence is computed at 1 Hz for demonstration purposes
			r.sleep()

		if success:
			self._result.sequence = self._feedback.sequence
			rospy.loginfo('%s: Succeeded' % self._action_name)
			self._as.set_succeeded(self._result)

if __name__ == '__main__':
	rospy.init_node('Eva_head_mover')
	rospy.loginfo("TU Wien Eva_head_mover node is ready!")
	DoHeadMove(rospy.get_name())
	rospy.spin()
